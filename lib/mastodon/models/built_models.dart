library built_models;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'built_models.g.dart';

abstract class RegisterResponse 
  extends Built<RegisterResponse, RegisterResponseBuilder> {

  String get id;
  @nullable
  String get name;
  @nullable
  String get website;
  @BuiltValueField(wireName: "redirect_uri")
  String get redirectUri;
  @BuiltValueField(wireName: "client_id")
  String get clientId;
  @BuiltValueField(wireName: "client_secret")
  String get clientSecret;

  RegisterResponse._();
  factory RegisterResponse([updates(RegisterResponseBuilder b)]) = _$RegisterResponse;
  
  static Serializer<RegisterResponse> get serializer => _$registerResponseSerializer;
}

abstract class Account
  extends Built<Account, AccountBuilder> {

  String get id;
  String get username;
  String get acct;
  @BuiltValueField(wireName: 'display_name')
  String get displayName;
  
  bool get locked;
  
  @BuiltValueField(wireName: 'followers_count')
  int get followersCount;
  
  @BuiltValueField(wireName: 'following_count')
  int get followingCount;
  
  @BuiltValueField(wireName: 'statuses_count')
  int get statusesCount;
  String get note;
  String get url;
  
  @nullable
  String get avatar;
  
  @BuiltValueField(wireName: 'avatar_static')
  @nullable
  String get avatarStatic;
  
  @nullable
  String get header;
  
  @BuiltValueField(wireName: 'header_static')
  @nullable
  String get headerStatic;

  Account._();
  factory Account([updates(AccountBuilder b)]) = _$Account;
  
  static Serializer<Account> get serializer => _$accountSerializer;
}

abstract class Status extends Built<Status, StatusBuilder> {
  String get id;
  String get uri;
  String get url;
  Account get account;
  
  @nullable
  @BuiltValueField(wireName: 'in_reply_to_id')
  String get inReplyToId;
  
  @nullable
  @BuiltValueField(wireName: 'in_reply_to_account_id')
  String get inReplyToAccountId;

  @nullable
  Status get reblog;

  String get content;

  @BuiltValueField(wireName: 'created_at')
  String get createdAt;

  //List<Emoji> emojis;

  @BuiltValueField(wireName: 'reblogs_count')
  int get reblogsCount;
  
  @BuiltValueField(wireName: 'favourites_count')
  int get favouritesCount;

  @nullable
  bool get reblogged;

  @nullable
  bool get favourited;

  @nullable
  bool get muted;

  bool get sensitive;
  
  @BuiltValueField(wireName: 'spoiler_text')
  String get spoilerText;

  String get visibility;

  //List<Attachment> attachments;
  //List<Mention> mentions;
  //List<Tag> tags;
  //Application application;
  @nullable
  String get language;

  Status._();
  factory Status([updates(StatusBuilder b)]) = _$Status;
  
  static Serializer<Status> get serializer => _$statusSerializer;
}

abstract class Context extends Built<Context, ContextBuilder> {
  BuiltList<Status> get ancestors;
  BuiltList<Status> get descendants;

  Context._();
  factory Context([updates(ContextBuilder b)]) = _$Context;
  static Serializer<Context> get serializer => _$contextSerializer;
}
