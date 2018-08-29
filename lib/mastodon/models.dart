import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponse {
  final String id;
  final String name;
  final String website;
  final String redirectUri;
  final String clientId;
  final String clientSecret;
  
  RegisterResponse({this.id, this.name, this.website, this.redirectUri, this.clientId, this.clientSecret});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Account {
  final String id;
  final String username;
  final String acct;
  final String displayName;
  final bool locked;
  final int followersCount;
  final int followingCount;
  final int statusesCount;
  final String note;
  final String url;
  final String avatar;
  final String avatarStatic;
  final String header;
  final String headerStatic;

  Account({
    this.id,
    this.username,
    this.acct,
    this.displayName,
    this.locked,
    this.followersCount,
    this.followingCount,
    this.statusesCount,
    this.note,
    this.url,
    this.avatar,
    this.avatarStatic,
    this.header,
    this.headerStatic
  });
  
  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Toot {
  final String id;
  final String uri;
  final String url;
  final Account account;

  final String inReplyToId;
  final String inReplyToAccountId;
  final String reblog;
  final String content;
  final String createdAt;
  
  final int reblogsCount;
  final int favoritesCount;
  final bool reblogged;
  final bool favourited;
  final bool muted;
  final bool sensitive;
  final String spoilerText;
  final String visibility;
  final String language;

  Toot({
    this.id,
    this.uri,
    this.url,
    this.account,
    this.inReplyToId,
    this.inReplyToAccountId,
    this.reblog,
    this.content,
    this.createdAt,
    this.reblogsCount,
    this.favoritesCount,
    this.reblogged,
    this.favourited,
    this.muted,
    this.sensitive,
    this.spoilerText,
    this.visibility,
    this.language
  });
  
  factory Toot.fromJson(Map<String, dynamic> json) => _$TootFromJson(json);
  Map<String, dynamic> toJson() => _$TootToJson(this);
}

@JsonSerializable()
class Context {
  final List<Toot> ancestors;
  final List<Toot> descendants;

  Context({this.ancestors, this.descendants});
  
  factory Context.fromJson(Map<String, dynamic> json) => _$ContextFromJson(json);
  Map<String, dynamic> toJson() => _$ContextToJson(this);
}