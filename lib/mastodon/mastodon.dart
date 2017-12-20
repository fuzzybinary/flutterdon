library mastodon;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'models.dart';
part 'web_view_modal.dart';

final String clientName = "flutterdon";
final int redirectPort = 8553;
final String redirectUrl = "http://localhost:$redirectPort/code";

class MastodonInstanceManager {
  static const String _InstanceListKey = "flutterdon:instance_list";

  // TODO: Don't like holding the current API here but I need to look into
  // how do to it better.
  MastodonApi currentApi; 

  // TODO: Investigate better ways to pass the current MastodonAPI to
  // various pages / switching instances.
  static MastodonInstanceManager _instance;
  static MastodonInstanceManager instance() {
    if(_instance == null) {
      _instance = new MastodonInstanceManager._();
    }

    return _instance;
  }

  MastodonInstanceManager._();

  Future<List<String>> getRegisteredInstances() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(_InstanceListKey);
  }

  Future addAuthorizedInstance(ClientInfo info) async {
    final sp = await SharedPreferences.getInstance();
    var currentList = sp.getStringList(_InstanceListKey);
    if(currentList == null) {
      currentList = new List<String>();
    } else {
      currentList = new List<String>.from(currentList);  
    }
    if(!currentList.contains(info.instanceName)) {
      currentList.add(info.instanceName);
      sp.setStringList(_InstanceListKey, currentList);
      await sp.commit();
    }
  }
}

class MastodonApi {
  String _instanceUrl;
  Client _httpClient;
  ClientInfo _clientInfo;
  Account _account;

  MastodonApi(this._instanceUrl) {
      _httpClient = createHttpClient();
  }

  Future login() async {
    final sp = await SharedPreferences.getInstance();
    _clientInfo = ClientInfo.fromSharedPreferences(sp, _instanceUrl); 
    if(_clientInfo == null) {
      _clientInfo = await _registerApp(sp);
    }

    if(_clientInfo.accessToken == null) {
      final refreshToken = await _authorizeApp();
      _clientInfo.accessToken = await _getAccessToken(refreshToken);
      await _clientInfo.saveToSharedPreferences(sp);
    }

    _account = await _verifyCredentials();
    MastodonInstanceManager.instance().addAuthorizedInstance(_clientInfo);
    MastodonInstanceManager.instance().currentApi = this;
  }

  Future logout() async {
    final sp = await SharedPreferences.getInstance();
    _clientInfo.accessToken = null;
    await _clientInfo.saveToSharedPreferences(sp);
  }

  Future<List<Status>> getTimeline() async {
    final response = await _performRequest("/api/v1/timelines/home");
    final statusListJson = JSON.decode(response.body);
    final statusList = new List<Status>();
    for(var statusJson in statusListJson) {
      statusList.add(new Status.fromJson(statusJson));
    }
    return statusList;
  }

  Future<ClientInfo> _registerApp(SharedPreferences sp) async {
    final url = "https://$_instanceUrl/api/v1/apps";
    final body = {
      "client_name": clientName,
      "redirect_uris": redirectUrl,
      "scopes": "read write follow"
    };

    var response = await _httpClient.post(url, body: body);
    if (response.statusCode < 200 && response.statusCode >= 300) {
      throw new Exception("Error registering app with mastodon instance: ");
    }
  
    final jsonResponse = JSON.decode(response.body);
    final regResponse = new RegisterResponse.fromJson(jsonResponse);

    var clientInfo = new ClientInfo(_instanceUrl, regResponse.clientId, regResponse.clientSecret);
    await clientInfo.saveToSharedPreferences(sp);

    return clientInfo;
  }

  Future _authorizeApp() async {
    final uri = new Uri(scheme: "https", host: _instanceUrl, path: "oauth/authorize", queryParameters:  {
      "scope": "read write follow",
      "response_type": "code",
      "redirect_uri": redirectUrl,
      "client_id": _clientInfo.clientId
    });
    print("Going to: $uri");
    final modal = new WebViewModal(uri.toString());
    
    String code;
    HttpServer server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, redirectPort);
    server.listen((HttpRequest request) async {
      const html = "<html></html>";
      code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.HTML.mimeType)
        ..write(html);
      await request.response.close();
      modal.close();
    });

    await modal.present();
    await server.close(force: true);

    if(code == null) {
      throw new Exception("Could not authorize app: ");
    }
    
    return code;
  }

  Future<String> _getAccessToken(String refreshToken) async {
    final uri = new Uri(scheme: "https", host: _instanceUrl, path: "/oauth/token", queryParameters: {
      "client_id": _clientInfo.clientId,
      "client_secret": _clientInfo.clientSecret,
      "grant_type": "authorization_code",
      "code": refreshToken,
      "redirect_uri": redirectUrl
    });
    
    var response = await _httpClient.post(uri);
    if(response.statusCode < 200 || response.statusCode >= 300) {
      throw new Exception("Error getting access token: ");
    }

    final jsonResponse = JSON.decode(response.body);
    final code = jsonResponse["access_token"];
    
    return code;
  }

  Future<Account> _verifyCredentials() async {
    final response = await _performRequest("/api/v1/accounts/verify_credentials");

    return new Account.fromJson(JSON.decode(response.body));
  }

  Future<Response> _performRequest(String path) async {
    final uri = new Uri(scheme: "https", host: _instanceUrl, path: path);
    final response = await _httpClient.get(uri, headers: {
      "Authorization": "Bearer ${_clientInfo.accessToken}"
    });
    if(response.statusCode < 200 || response.statusCode >= 300) {
      throw new Exception("Couldn't verify credentials: ");
    }
    
    return response;
  }
}