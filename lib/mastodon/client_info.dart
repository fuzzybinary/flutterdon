part of mastodon;

class ClientInfo {
  String instanceName;
  String clientId;
  String clientSecret;
  String accessToken;

  ClientInfo(this.instanceName, this.clientId, this.clientSecret, [this.accessToken]);

  static ClientInfo fromSharedPreferences(SharedPreferences sp, String instanceName) {
    ClientInfo clientInfo;
    final encoded = sp.getString("mastodon:instance:data:$instanceName");
    if(encoded != null) {
      final json = JSON.decode(encoded);
    
      clientInfo = new ClientInfo(json['instance_name'], json['client_id'], json['client_secret'], json['access_token']);
    }
    return clientInfo;
  }
  

  Future clearFromSharedPreferences(SharedPreferences sp) async {
    sp.remove("mastodon:instance:data:$instanceName");
    await sp.commit();
  }

  Future saveToSharedPreferences(SharedPreferences sp) async {
    var encoded = JSON.encode({ 
      'instance_name': instanceName,
      'client_id': clientId,
      'client_secret': clientSecret,
      'access_token': accessToken
    });
  
    sp.setString("mastodon:instance:data:$instanceName", encoded);
    await sp.commit();
  }

}