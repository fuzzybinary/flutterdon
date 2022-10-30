import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponse {
  final String id;
  final String name;
  final String? website;
  final String redirectUri;
  final String clientId;
  final String clientSecret;

  RegisterResponse({
    required this.id,
    required this.name,
    required this.website,
    required this.redirectUri,
    required this.clientId,
    required this.clientSecret,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
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
    required this.id,
    required this.username,
    required this.acct,
    required this.displayName,
    required this.locked,
    required this.followersCount,
    required this.followingCount,
    required this.statusesCount,
    required this.note,
    required this.url,
    required this.avatar,
    required this.avatarStatic,
    required this.header,
    required this.headerStatic,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
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
    required this.id,
    required this.uri,
    required this.url,
    required this.account,
    required this.inReplyToId,
    required this.inReplyToAccountId,
    required this.reblog,
    required this.content,
    required this.createdAt,
    required this.reblogsCount,
    required this.favoritesCount,
    required this.reblogged,
    required this.favourited,
    required this.muted,
    required this.sensitive,
    required this.spoilerText,
    required this.visibility,
    required this.language,
  });

  factory Toot.fromJson(Map<String, dynamic> json) => _$TootFromJson(json);
  Map<String, dynamic> toJson() => _$TootToJson(this);
}

@JsonSerializable()
class Context {
  final List<Toot> ancestors;
  final List<Toot> descendants;

  Context({
    required this.ancestors,
    required this.descendants,
  });

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);
  Map<String, dynamic> toJson() => _$ContextToJson(this);
}
