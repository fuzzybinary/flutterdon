import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'client_info.dart';
import 'models.dart';

const String clientName = 'flutterdon';
const int redirectPort = 8553;
const String redirectUrl = 'http://localhost:$redirectPort/code';

class MastodonInstanceManager {
  static const String _instanceListKey = 'flutterdon:instance_list';

  // TODO: Don't like holding the current API here but I need to look into
  // how do to it better.
  MastodonApi? currentApi;

  // TODO: Investigate better ways to pass the current MastodonAPI to
  // various pages / switching instances.
  static MastodonInstanceManager? _instance;
  static MastodonInstanceManager instance() {
    _instance ??= MastodonInstanceManager._();

    return _instance!;
  }

  MastodonInstanceManager._();

  Future<List<String>?> getRegisteredInstances() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(_instanceListKey);
  }

  Future addAuthorizedInstance(ClientInfo info) async {
    final sp = await SharedPreferences.getInstance();
    var currentList = sp.getStringList(_instanceListKey);
    if (currentList == null) {
      currentList = [];
    } else {
      currentList = List<String>.from(currentList);
    }
    if (!currentList.contains(info.instanceName)) {
      currentList.add(info.instanceName);
      sp.setStringList(_instanceListKey, currentList);
    }
  }
}

class MastodonApi {
  final Client _httpClient;
  final String _instanceUrl;
  ClientInfo? _clientInfo;
  Account? _account;

  MastodonApi(this._instanceUrl) : _httpClient = Client();

  Future login() async {
    final sp = await SharedPreferences.getInstance();
    _clientInfo = ClientInfo.fromSharedPreferences(sp, _instanceUrl);
    _clientInfo ??= await _registerApp(sp);

    if (_clientInfo!.accessToken == null) {
      final refreshToken = await _authorizeApp();
      _clientInfo!.accessToken = await _getAccessToken(refreshToken);
      await _clientInfo!.saveToSharedPreferences(sp);
    }

    _account = await _verifyCredentials();
    MastodonInstanceManager.instance().addAuthorizedInstance(_clientInfo!);
    MastodonInstanceManager.instance().currentApi = this;
  }

  Future logout() async {
    final sp = await SharedPreferences.getInstance();
    await _clientInfo?.clearFromSharedPreferences(sp);
  }

  Future<List<Status>> getTimeline() async {
    final response = await _performRequest('/api/v1/timelines/home');
    final statusListJson = json.decode(response.body);
    final statusList = <Status>[];
    for (var statusJson in statusListJson) {
      final status = Status.fromJson(statusJson);
      statusList.add(status);
    }
    return statusList;
  }

  Future<Context> getContext(Status status) async {
    final response =
        await _performRequest('/api/v1/statuses/${status.id}/context');
    final contextJson = json.decode(response.body);
    final context = Context.fromJson(contextJson);
    return context;
  }

  Future<ClientInfo> _registerApp(SharedPreferences sp) async {
    final url = Uri.parse('https://$_instanceUrl/api/v1/apps');
    final body = {
      'client_name': clientName,
      'redirect_uris': redirectUrl,
      'scopes': 'read write follow'
    };

    var response = await _httpClient.post(url, body: body);
    if (response.statusCode < 200 && response.statusCode >= 300) {
      throw Exception('Error registering app with mastodon instance: ');
    }

    final jsonResponse = json.decode(response.body);
    final regResponse = RegisterResponse.fromJson(jsonResponse);

    var clientInfo = ClientInfo(
        _instanceUrl, regResponse.clientId, regResponse.clientSecret);
    await clientInfo.saveToSharedPreferences(sp);

    return clientInfo;
  }

  Future<String> _authorizeApp() async {
    final uri = Uri(
      scheme: 'https',
      host: _instanceUrl,
      path: 'oauth/authorize',
      queryParameters: {
        'scope': 'read write follow',
        'response_type': 'code',
        'redirect_uri': redirectUrl,
        'client_id': _clientInfo!.clientId
      },
    );

    final requestCompleter = Completer();

    String? code;
    HttpServer server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, redirectPort);
    server.listen((HttpRequest request) async {
      const html = '<html></html>';
      code = request.uri.queryParameters['code'];
      request.response
        ..statusCode = 200
        ..headers.set('Content-Type', ContentType.html.mimeType)
        ..write(html);
      await request.response.close();
      if (!PlatformUtils.isDesktopPlatform) {
        await closeInAppWebView();
      }
      requestCompleter.complete();
    });

    launchUrl(uri);

    await requestCompleter.future;
    await server.close(force: true);

    if (code == null) {
      throw Exception('Could not authorize app: ');
    }

    return code!;
  }

  Future<String> _getAccessToken(String refreshToken) async {
    final uri = Uri(
      scheme: 'https',
      host: _instanceUrl,
      path: '/oauth/token',
      queryParameters: {
        'client_id': _clientInfo!.clientId,
        'client_secret': _clientInfo!.clientSecret,
        'grant_type': 'authorization_code',
        'code': refreshToken,
        'redirect_uri': redirectUrl
      },
    );

    var response = await _httpClient.post(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Error getting access token: ');
    }

    final jsonResponse = json.decode(response.body);
    final code = jsonResponse['access_token'];

    return code;
  }

  Future<Account> _verifyCredentials() async {
    final response =
        await _performRequest('/api/v1/accounts/verify_credentials');
    var decoded = json.decode(response.body);

    return Account.fromJson(decoded);
  }

  Future<Response> _performRequest(String path) async {
    final uri = Uri(scheme: 'https', host: _instanceUrl, path: path);
    final response = await _httpClient.get(uri,
        headers: {'Authorization': 'Bearer ${_clientInfo!.accessToken}'});
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Couldn't verify credentials: ");
    }

    return response;
  }
}

class PlatformUtils {
  static bool get isDesktopPlatform {
    return !kIsWeb &&
        (Platform.isWindows || Platform.isMacOS || Platform.isLinux);
  }
}
