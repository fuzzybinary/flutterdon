import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ClientInfo {
  static const keyPrefix = 'mastodon:instance:data:';

  String instanceUrl;
  String instanceName;
  String clientId;
  String clientSecret;
  String? accessToken;

  ClientInfo(
    this.instanceUrl,
    this.instanceName,
    this.clientId,
    this.clientSecret, [
    this.accessToken,
  ]);

  static ClientInfo? fromSharedPreferences(
      SharedPreferences sp, String instanceUrl) {
    ClientInfo? clientInfo;
    final key = '$keyPrefix$instanceUrl';
    final encoded = sp.getString(key);
    if (encoded != null) {
      final decoded = json.decode(encoded);

      try {
        clientInfo = ClientInfo(
          decoded['instance_url'],
          decoded['instance_name'],
          decoded['client_id'],
          decoded['client_secret'],
          decoded['access_token'],
        );
      } catch (e) {
        sp.remove(key);
      }
    }
    return clientInfo;
  }

  Future clearFromSharedPreferences(SharedPreferences sp) async {
    sp.remove('$keyPrefix$instanceUrl');
  }

  Future saveToSharedPreferences(SharedPreferences sp) async {
    var encoded = json.encode({
      'instance_url': instanceUrl,
      'instance_name': instanceName,
      'client_id': clientId,
      'client_secret': clientSecret,
      'access_token': accessToken
    });

    sp.setString('$keyPrefix$instanceUrl', encoded);
  }
}
