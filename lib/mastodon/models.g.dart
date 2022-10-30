// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      website: json['website'] as String?,
      redirectUri: json['redirect_uri'] as String,
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'website': instance.website,
      'redirect_uri': instance.redirectUri,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String,
      username: json['username'] as String,
      acct: json['acct'] as String,
      displayName: json['display_name'] as String,
      locked: json['locked'] as bool,
      followersCount: json['followers_count'] as int,
      followingCount: json['following_count'] as int,
      statusesCount: json['statuses_count'] as int,
      note: json['note'] as String,
      url: json['url'] as String,
      avatar: json['avatar'] as String,
      avatarStatic: json['avatar_static'] as String,
      header: json['header'] as String,
      headerStatic: json['header_static'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'acct': instance.acct,
      'display_name': instance.displayName,
      'locked': instance.locked,
      'followers_count': instance.followersCount,
      'following_count': instance.followingCount,
      'statuses_count': instance.statusesCount,
      'note': instance.note,
      'url': instance.url,
      'avatar': instance.avatar,
      'avatar_static': instance.avatarStatic,
      'header': instance.header,
      'header_static': instance.headerStatic,
    };

Toot _$TootFromJson(Map<String, dynamic> json) => Toot(
      id: json['id'] as String,
      uri: json['uri'] as String,
      url: json['url'] as String,
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      inReplyToId: json['in_reply_to_id'] as String,
      inReplyToAccountId: json['in_reply_to_account_id'] as String,
      reblog: json['reblog'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      reblogsCount: json['reblogs_count'] as int,
      favoritesCount: json['favorites_count'] as int,
      reblogged: json['reblogged'] as bool,
      favourited: json['favourited'] as bool,
      muted: json['muted'] as bool,
      sensitive: json['sensitive'] as bool,
      spoilerText: json['spoiler_text'] as String,
      visibility: json['visibility'] as String,
      language: json['language'] as String,
    );

Map<String, dynamic> _$TootToJson(Toot instance) => <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      'url': instance.url,
      'account': instance.account,
      'in_reply_to_id': instance.inReplyToId,
      'in_reply_to_account_id': instance.inReplyToAccountId,
      'reblog': instance.reblog,
      'content': instance.content,
      'created_at': instance.createdAt,
      'reblogs_count': instance.reblogsCount,
      'favorites_count': instance.favoritesCount,
      'reblogged': instance.reblogged,
      'favourited': instance.favourited,
      'muted': instance.muted,
      'sensitive': instance.sensitive,
      'spoiler_text': instance.spoilerText,
      'visibility': instance.visibility,
      'language': instance.language,
    };

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
      ancestors: (json['ancestors'] as List<dynamic>)
          .map((e) => Toot.fromJson(e as Map<String, dynamic>))
          .toList(),
      descendants: (json['descendants'] as List<dynamic>)
          .map((e) => Toot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
      'ancestors': instance.ancestors,
      'descendants': instance.descendants,
    };
