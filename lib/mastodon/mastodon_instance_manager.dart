import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'client_info.dart';
import 'mastodon_api.dart';
import 'models.dart';

class MastodonInstanceManager extends ChangeNotifier {
  static const String _instanceListKey = 'flutterdon:instance_list';

  // TODO: Don't like holding the current API here but I need to look into
  // how do to it better.
  MastodonApi? currentApi;

  MastodonInstanceManager();

  Future<List<String>?> getRegisteredInstances() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(_instanceListKey);
  }

  Future<void> loginToInstance(String instanceUrl) async {
    final sp = await SharedPreferences.getInstance();
    var clientInfo = ClientInfo.fromSharedPreferences(sp, instanceUrl);
    clientInfo ??= await _registerApp(instanceUrl);

    final api = MastodonApi(clientInfo);
    await api.login();

    currentApi = api;
    addAuthorizedInstance(clientInfo);
    notifyListeners();
  }

  Future<ClientInfo> _registerApp(String instanceUrl) async {
    final url = Uri.parse('https://$instanceUrl/api/v1/apps');
    final body = {
      'client_name': clientName,
      'redirect_uris': redirectUrl,
      'scopes': 'read write follow'
    };

    var response = await http.post(url, body: body);
    if (response.statusCode < 200 && response.statusCode >= 300) {
      throw Exception('Error registering app with mastodon instance: ');
    }

    final jsonResponse = json.decode(response.body);
    final regResponse = RegisterResponse.fromJson(jsonResponse);

    var clientInfo = ClientInfo(
      instanceUrl,
      regResponse.name,
      regResponse.clientId,
      regResponse.clientSecret,
    );

    return clientInfo;
  }

  Future<void> addAuthorizedInstance(ClientInfo info) async {
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
