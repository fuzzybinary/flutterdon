library mastodon;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

part 'models.dart';

final String clientName = "flutterdon";
final int redirectPort = 8553;
final String redirectUrl = "http://localhost:${redirectPort}/code";

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

  Future<Stream<String>> _loginServer() async {
    final StreamController<String> onCode = new StreamController();
    HttpServer server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, redirectPort);
    server.listen((HttpRequest request) async {
      const html = """
        <html>
          <body>
            <h1>You can now close this window</h1>
          </body>
        </html>
      """;
      final String code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.HTML.mimeType)
        ..write(html);
      await request.response.close();
      await server.close(force: true);
      onCode.add(code);
      await onCode.close();
    });

    return onCode.stream;
  }

  Future login() async {
    Stream<String> onCode = await _loginServer();

    final String url = "https://${_instanceUrl}/oauth/authorize/?scope=read%20write%20follow&response_type=code&redirect_uri=${redirectUrl}&client_id=${_clientInfo.clientId}";
    print("Going to: ${url}");
    final FlutterWebviewPlugin webviewPlugin = new FlutterWebviewPlugin();
    webviewPlugin.launch(url, fullScreen: true);
    final code = await onCode.first;
    print(code);
    webviewPlugin.close();
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