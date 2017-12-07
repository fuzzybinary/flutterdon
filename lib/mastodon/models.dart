part of mastodon;

class RegisterResponse {
  String id;
  String name;
  String website;
  String redirectUri;
  String clientId;
  String clientSecret;
  
  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    website = json["website"];
    redirectUri = json["redirect_uri"];
    clientId = json["client_id"];
    clientSecret = json["client_secret"];
  }
}

class ClientInfo {
  String instanceName;
  String clientId;
  String clientSecret;

  ClientInfo(this.instanceName, this.clientId, this.clientSecret);

  static ClientInfo fromSharedPreferences(SharedPreferences sp, String instanceName) {
    ClientInfo clientInfo = null;
    final encoded = sp.getString("mastodon:instance:data:${instanceName}");
    if(encoded != null) {
      final json = JSON.decode(encoded);
    
      clientInfo = new ClientInfo(json['instance_name'], json['client_id'], json['client_secret']);
    }
    return clientInfo;
  }
  
  Future saveToSharedPreferences(SharedPreferences sp) async {
    var encoded = JSON.encode({ 
      'instance_name': instanceName,
      'client_id': clientId,
      'client_secret': clientSecret 
    });
  
    sp.setString("mastodon:instance:data:${instanceName}", encoded);
    await sp.commit();
  }

}