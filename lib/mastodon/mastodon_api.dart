import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/platform_utils.dart';
import 'client_info.dart';
import 'models.dart';

const String clientName = 'flutterdon';
const int redirectPort = 8553;
const String redirectUrl = 'http://localhost:$redirectPort/code';

class MastodonApi {
  final ClientInfo _clientInfo;
  final Client _httpClient;

  Account? _account;

  MastodonApi(this._clientInfo) : _httpClient = Client();

  Future<void> login() async {
    if (_clientInfo.accessToken == null) {
      final refreshToken = await _authorizeApp();
      _clientInfo.accessToken = await _getAccessToken(refreshToken);
      final sp = await SharedPreferences.getInstance();
      await _clientInfo.saveToSharedPreferences(sp);
    }

    _account = await _verifyCredentials();
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    _clientInfo.accessToken = null;
    // Don't delete on logout, just remove the access token
    await _clientInfo.saveToSharedPreferences(sp);
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

  Future<String> _authorizeApp() async {
    final uri = Uri(
      scheme: 'https',
      host: _clientInfo.instanceUrl,
      path: 'oauth/authorize',
      queryParameters: {
        'scope': 'read write follow',
        'response_type': 'code',
        'redirect_uri': redirectUrl,
        'client_id': _clientInfo.clientId
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
      if (!PlatformUtils.isDesktop) {
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
      host: _clientInfo.instanceUrl,
      path: '/oauth/token',
      queryParameters: {
        'client_id': _clientInfo.clientId,
        'client_secret': _clientInfo.clientSecret,
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
    final uri = Uri(scheme: 'https', host: _clientInfo.instanceUrl, path: path);
    final response = await _httpClient.get(uri,
        headers: {'Authorization': 'Bearer ${_clientInfo.accessToken}'});
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Couldn't verify credentials: ");
    }

    return response;
  }
}
