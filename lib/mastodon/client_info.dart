part of mastodon;

class ClientInfo {
  String instanceName;
  String clientId;
  String clientSecret;
  String? accessToken;

  ClientInfo(this.instanceName, this.clientId, this.clientSecret,
      [this.accessToken]);

  static ClientInfo? fromSharedPreferences(
      SharedPreferences sp, String instanceName) {
    ClientInfo? clientInfo;
    final encoded = sp.getString('mastodon:instance:data:$instanceName');
    if (encoded != null) {
      final decoded = json.decode(encoded);

      clientInfo = ClientInfo(
        decoded['instance_name'],
        decoded['client_id'],
        decoded['client_secret'],
        decoded['access_token'],
      );
    }
    return clientInfo;
  }

  Future clearFromSharedPreferences(SharedPreferences sp) async {
    sp.remove('mastodon:instance:data:$instanceName');
  }

  Future saveToSharedPreferences(SharedPreferences sp) async {
    var encoded = json.encode({
      'instance_name': instanceName,
      'client_id': clientId,
      'client_secret': clientSecret,
      'access_token': accessToken
    });

    sp.setString('mastodon:instance:data:$instanceName', encoded);
  }
}
