library mastodon;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'models.dart';

final String clientName = "flutterdon";
final int redirectPort = 8553;
final String redirectUrl = "http://localhost:${redirectPort}/code";

const MethodChannel _channel =
    const MethodChannel('plugins.flutter.io/webmodal');

class WebViewModal {
  String _urlString;
  
  WebViewModal(String urlString) {
    this._urlString = urlString;
    final Uri url = Uri.parse(urlString.trimLeft());
    final bool isWebURL = url.scheme == 'http' || url.scheme == 'https';
    if (!isWebURL) {
      throw new PlatformException(
          code: 'NOT_A_WEB_SCHEME',
          message: 'To use webview or safariVC, you need to pass'
              'in a web URL. This $urlString is not a web URL.');
    }
  }

  Future present() async {
    return _channel.invokeMethod(
      'present',
      <String, Object>{
        'url': _urlString
      },
    );
  }

  void close() {
    _channel.invokeMethod('close', {});
  }
}

class MastodonApi {
  String _instanceUrl;
  Client _httpClient;
  ClientInfo _clientInfo;

  MastodonApi(this._instanceUrl) {
      _httpClient = createHttpClient();

  }

  Future register() async {
    final sp = await SharedPreferences.getInstance();
    var clientInfo = ClientInfo.fromSharedPreferences(sp, _instanceUrl); 
    //var clientInfo = null;
    if(clientInfo != null) {
      print("Found saved client info!");
    } else {
      final response = await _register_internal();
      if(response != null) {
        clientInfo = new ClientInfo(_instanceUrl, response.clientId, response.clientSecret);
      
        await clientInfo.saveToSharedPreferences(sp);
      }
    }

    if(clientInfo != null) {
      _clientInfo = clientInfo; 
      print("Registerd app okay. Ready to login!");
    }
  }

  Future login() async {
    final String url = "https://${_instanceUrl}/oauth/authorize/?scope=read%20write%20follow&response_type=code&redirect_uri=${redirectUrl}&client_id=${_clientInfo.clientId}";
    print("Going to: ${url}");
    final modal = new WebViewModal(url);
    
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
    print(code);
  }

  Future<RegisterResponse> _register_internal() async {
    final url = "https://${_instanceUrl}/api/v1/apps";
    final body = {
      "client_name": clientName,
      "redirect_uris": redirectUrl,
      "scopes": "read write follow"
    };

    var response = await _httpClient.post(url, body: body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = JSON.decode(response.body);
      final regResponse = new RegisterResponse.fromJson(jsonResponse);

      return regResponse;  
    }

    return null;
  }

}