// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_models;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<RegisterResponse> _$registerResponseSerializer =
    new _$RegisterResponseSerializer();
Serializer<Account> _$accountSerializer = new _$AccountSerializer();
Serializer<Status> _$statusSerializer = new _$StatusSerializer();
Serializer<Context> _$contextSerializer = new _$ContextSerializer();

class _$RegisterResponseSerializer
    implements StructuredSerializer<RegisterResponse> {
  @override
  final Iterable<Type> types = const [RegisterResponse, _$RegisterResponse];
  @override
  final String wireName = 'RegisterResponse';

  @override
  Iterable serialize(Serializers serializers, RegisterResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'redirect_uri',
      serializers.serialize(object.redirectUri,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'client_secret',
      serializers.serialize(object.clientSecret,
          specifiedType: const FullType(String)),
    ];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.website != null) {
      result
        ..add('website')
        ..add(serializers.serialize(object.website,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  RegisterResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new RegisterResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'redirect_uri':
          result.redirectUri = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_secret':
          result.clientSecret = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AccountSerializer implements StructuredSerializer<Account> {
  @override
  final Iterable<Type> types = const [Account, _$Account];
  @override
  final String wireName = 'Account';

  @override
  Iterable serialize(Serializers serializers, Account object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'acct',
      serializers.serialize(object.acct, specifiedType: const FullType(String)),
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'locked',
      serializers.serialize(object.locked, specifiedType: const FullType(bool)),
      'followers_count',
      serializers.serialize(object.followersCount,
          specifiedType: const FullType(int)),
      'following_count',
      serializers.serialize(object.followingCount,
          specifiedType: const FullType(int)),
      'statuses_count',
      serializers.serialize(object.statusesCount,
          specifiedType: const FullType(int)),
      'note',
      serializers.serialize(object.note, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
    ];
    if (object.avatar != null) {
      result
        ..add('avatar')
        ..add(serializers.serialize(object.avatar,
            specifiedType: const FullType(String)));
    }
    if (object.avatarStatic != null) {
      result
        ..add('avatar_static')
        ..add(serializers.serialize(object.avatarStatic,
            specifiedType: const FullType(String)));
    }
    if (object.header != null) {
      result
        ..add('header')
        ..add(serializers.serialize(object.header,
            specifiedType: const FullType(String)));
    }
    if (object.headerStatic != null) {
      result
        ..add('header_static')
        ..add(serializers.serialize(object.headerStatic,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Account deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new AccountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'acct':
          result.acct = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locked':
          result.locked = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'followers_count':
          result.followersCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'following_count':
          result.followingCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'statuses_count':
          result.statusesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'note':
          result.note = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar':
          result.avatar = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar_static':
          result.avatarStatic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'header':
          result.header = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'header_static':
          result.headerStatic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$StatusSerializer implements StructuredSerializer<Status> {
  @override
  final Iterable<Type> types = const [Status, _$Status];
  @override
  final String wireName = 'Status';

  @override
  Iterable serialize(Serializers serializers, Status object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'uri',
      serializers.serialize(object.uri, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'account',
      serializers.serialize(object.account,
          specifiedType: const FullType(Account)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'reblogs_count',
      serializers.serialize(object.reblogsCount,
          specifiedType: const FullType(int)),
      'favourites_count',
      serializers.serialize(object.favouritesCount,
          specifiedType: const FullType(int)),
      'sensitive',
      serializers.serialize(object.sensitive,
          specifiedType: const FullType(bool)),
      'spoiler_text',
      serializers.serialize(object.spoilerText,
          specifiedType: const FullType(String)),
      'visibility',
      serializers.serialize(object.visibility,
          specifiedType: const FullType(String)),
    ];
    if (object.inReplyToId != null) {
      result
        ..add('in_reply_to_id')
        ..add(serializers.serialize(object.inReplyToId,
            specifiedType: const FullType(String)));
    }
    if (object.inReplyToAccountId != null) {
      result
        ..add('in_reply_to_account_id')
        ..add(serializers.serialize(object.inReplyToAccountId,
            specifiedType: const FullType(String)));
    }
    if (object.reblog != null) {
      result
        ..add('reblog')
        ..add(serializers.serialize(object.reblog,
            specifiedType: const FullType(Status)));
    }
    if (object.reblogged != null) {
      result
        ..add('reblogged')
        ..add(serializers.serialize(object.reblogged,
            specifiedType: const FullType(bool)));
    }
    if (object.favourited != null) {
      result
        ..add('favourited')
        ..add(serializers.serialize(object.favourited,
            specifiedType: const FullType(bool)));
    }
    if (object.muted != null) {
      result
        ..add('muted')
        ..add(serializers.serialize(object.muted,
            specifiedType: const FullType(bool)));
    }
    if (object.language != null) {
      result
        ..add('language')
        ..add(serializers.serialize(object.language,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Status deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new StatusBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uri':
          result.uri = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
              specifiedType: const FullType(Account)) as Account);
          break;
        case 'in_reply_to_id':
          result.inReplyToId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'in_reply_to_account_id':
          result.inReplyToAccountId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reblog':
          result.reblog.replace(serializers.deserialize(value,
              specifiedType: const FullType(Status)) as Status);
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reblogs_count':
          result.reblogsCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'favourites_count':
          result.favouritesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'reblogged':
          result.reblogged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'favourited':
          result.favourited = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'muted':
          result.muted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'sensitive':
          result.sensitive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'spoiler_text':
          result.spoilerText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'visibility':
          result.visibility = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'language':
          result.language = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ContextSerializer implements StructuredSerializer<Context> {
  @override
  final Iterable<Type> types = const [Context, _$Context];
  @override
  final String wireName = 'Context';

  @override
  Iterable serialize(Serializers serializers, Context object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'ancestors',
      serializers.serialize(object.ancestors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Status)])),
      'descendants',
      serializers.serialize(object.descendants,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Status)])),
    ];

    return result;
  }

  @override
  Context deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ContextBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ancestors':
          result.ancestors.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Status)]))
              as BuiltList<Status>);
          break;
        case 'descendants':
          result.descendants.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Status)]))
              as BuiltList<Status>);
          break;
      }
    }

    return result.build();
  }
}

class _$RegisterResponse extends RegisterResponse {
  @override
  final String id;
  @override
  final String name;
  @override
  final String website;
  @override
  final String redirectUri;
  @override
  final String clientId;
  @override
  final String clientSecret;

  factory _$RegisterResponse([void updates(RegisterResponseBuilder b)]) =>
      (new RegisterResponseBuilder()..update(updates)).build();

  _$RegisterResponse._(
      {this.id,
      this.name,
      this.website,
      this.redirectUri,
      this.clientId,
      this.clientSecret})
      : super._() {
    if (id == null)
      throw new BuiltValueNullFieldError('RegisterResponse', 'id');
    if (redirectUri == null)
      throw new BuiltValueNullFieldError('RegisterResponse', 'redirectUri');
    if (clientId == null)
      throw new BuiltValueNullFieldError('RegisterResponse', 'clientId');
    if (clientSecret == null)
      throw new BuiltValueNullFieldError('RegisterResponse', 'clientSecret');
  }

  @override
  RegisterResponse rebuild(void updates(RegisterResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterResponseBuilder toBuilder() =>
      new RegisterResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! RegisterResponse) return false;
    return id == other.id &&
        name == other.name &&
        website == other.website &&
        redirectUri == other.redirectUri &&
        clientId == other.clientId &&
        clientSecret == other.clientSecret;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), name.hashCode), website.hashCode),
                redirectUri.hashCode),
            clientId.hashCode),
        clientSecret.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RegisterResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('website', website)
          ..add('redirectUri', redirectUri)
          ..add('clientId', clientId)
          ..add('clientSecret', clientSecret))
        .toString();
  }
}

class RegisterResponseBuilder
    implements Builder<RegisterResponse, RegisterResponseBuilder> {
  _$RegisterResponse _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _redirectUri;
  String get redirectUri => _$this._redirectUri;
  set redirectUri(String redirectUri) => _$this._redirectUri = redirectUri;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  String _clientSecret;
  String get clientSecret => _$this._clientSecret;
  set clientSecret(String clientSecret) => _$this._clientSecret = clientSecret;

  RegisterResponseBuilder();

  RegisterResponseBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _website = _$v.website;
      _redirectUri = _$v.redirectUri;
      _clientId = _$v.clientId;
      _clientSecret = _$v.clientSecret;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$RegisterResponse;
  }

  @override
  void update(void updates(RegisterResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$RegisterResponse build() {
    final _$result = _$v ??
        new _$RegisterResponse._(
            id: id,
            name: name,
            website: website,
            redirectUri: redirectUri,
            clientId: clientId,
            clientSecret: clientSecret);
    replace(_$result);
    return _$result;
  }
}

class _$Account extends Account {
  @override
  final String id;
  @override
  final String username;
  @override
  final String acct;
  @override
  final String displayName;
  @override
  final bool locked;
  @override
  final int followersCount;
  @override
  final int followingCount;
  @override
  final int statusesCount;
  @override
  final String note;
  @override
  final String url;
  @override
  final String avatar;
  @override
  final String avatarStatic;
  @override
  final String header;
  @override
  final String headerStatic;

  factory _$Account([void updates(AccountBuilder b)]) =>
      (new AccountBuilder()..update(updates)).build();

  _$Account._(
      {this.id,
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
      this.headerStatic})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('Account', 'id');
    if (username == null)
      throw new BuiltValueNullFieldError('Account', 'username');
    if (acct == null) throw new BuiltValueNullFieldError('Account', 'acct');
    if (displayName == null)
      throw new BuiltValueNullFieldError('Account', 'displayName');
    if (locked == null) throw new BuiltValueNullFieldError('Account', 'locked');
    if (followersCount == null)
      throw new BuiltValueNullFieldError('Account', 'followersCount');
    if (followingCount == null)
      throw new BuiltValueNullFieldError('Account', 'followingCount');
    if (statusesCount == null)
      throw new BuiltValueNullFieldError('Account', 'statusesCount');
    if (note == null) throw new BuiltValueNullFieldError('Account', 'note');
    if (url == null) throw new BuiltValueNullFieldError('Account', 'url');
  }

  @override
  Account rebuild(void updates(AccountBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountBuilder toBuilder() => new AccountBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Account) return false;
    return id == other.id &&
        username == other.username &&
        acct == other.acct &&
        displayName == other.displayName &&
        locked == other.locked &&
        followersCount == other.followersCount &&
        followingCount == other.followingCount &&
        statusesCount == other.statusesCount &&
        note == other.note &&
        url == other.url &&
        avatar == other.avatar &&
        avatarStatic == other.avatarStatic &&
        header == other.header &&
        headerStatic == other.headerStatic;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc($jc(0, id.hashCode),
                                                        username.hashCode),
                                                    acct.hashCode),
                                                displayName.hashCode),
                                            locked.hashCode),
                                        followersCount.hashCode),
                                    followingCount.hashCode),
                                statusesCount.hashCode),
                            note.hashCode),
                        url.hashCode),
                    avatar.hashCode),
                avatarStatic.hashCode),
            header.hashCode),
        headerStatic.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Account')
          ..add('id', id)
          ..add('username', username)
          ..add('acct', acct)
          ..add('displayName', displayName)
          ..add('locked', locked)
          ..add('followersCount', followersCount)
          ..add('followingCount', followingCount)
          ..add('statusesCount', statusesCount)
          ..add('note', note)
          ..add('url', url)
          ..add('avatar', avatar)
          ..add('avatarStatic', avatarStatic)
          ..add('header', header)
          ..add('headerStatic', headerStatic))
        .toString();
  }
}

class AccountBuilder implements Builder<Account, AccountBuilder> {
  _$Account _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _acct;
  String get acct => _$this._acct;
  set acct(String acct) => _$this._acct = acct;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  bool _locked;
  bool get locked => _$this._locked;
  set locked(bool locked) => _$this._locked = locked;

  int _followersCount;
  int get followersCount => _$this._followersCount;
  set followersCount(int followersCount) =>
      _$this._followersCount = followersCount;

  int _followingCount;
  int get followingCount => _$this._followingCount;
  set followingCount(int followingCount) =>
      _$this._followingCount = followingCount;

  int _statusesCount;
  int get statusesCount => _$this._statusesCount;
  set statusesCount(int statusesCount) => _$this._statusesCount = statusesCount;

  String _note;
  String get note => _$this._note;
  set note(String note) => _$this._note = note;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _avatar;
  String get avatar => _$this._avatar;
  set avatar(String avatar) => _$this._avatar = avatar;

  String _avatarStatic;
  String get avatarStatic => _$this._avatarStatic;
  set avatarStatic(String avatarStatic) => _$this._avatarStatic = avatarStatic;

  String _header;
  String get header => _$this._header;
  set header(String header) => _$this._header = header;

  String _headerStatic;
  String get headerStatic => _$this._headerStatic;
  set headerStatic(String headerStatic) => _$this._headerStatic = headerStatic;

  AccountBuilder();

  AccountBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _username = _$v.username;
      _acct = _$v.acct;
      _displayName = _$v.displayName;
      _locked = _$v.locked;
      _followersCount = _$v.followersCount;
      _followingCount = _$v.followingCount;
      _statusesCount = _$v.statusesCount;
      _note = _$v.note;
      _url = _$v.url;
      _avatar = _$v.avatar;
      _avatarStatic = _$v.avatarStatic;
      _header = _$v.header;
      _headerStatic = _$v.headerStatic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Account other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Account;
  }

  @override
  void update(void updates(AccountBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Account build() {
    final _$result = _$v ??
        new _$Account._(
            id: id,
            username: username,
            acct: acct,
            displayName: displayName,
            locked: locked,
            followersCount: followersCount,
            followingCount: followingCount,
            statusesCount: statusesCount,
            note: note,
            url: url,
            avatar: avatar,
            avatarStatic: avatarStatic,
            header: header,
            headerStatic: headerStatic);
    replace(_$result);
    return _$result;
  }
}

class _$Status extends Status {
  @override
  final String id;
  @override
  final String uri;
  @override
  final String url;
  @override
  final Account account;
  @override
  final String inReplyToId;
  @override
  final String inReplyToAccountId;
  @override
  final Status reblog;
  @override
  final String content;
  @override
  final String createdAt;
  @override
  final int reblogsCount;
  @override
  final int favouritesCount;
  @override
  final bool reblogged;
  @override
  final bool favourited;
  @override
  final bool muted;
  @override
  final bool sensitive;
  @override
  final String spoilerText;
  @override
  final String visibility;
  @override
  final String language;

  factory _$Status([void updates(StatusBuilder b)]) =>
      (new StatusBuilder()..update(updates)).build();

  _$Status._(
      {this.id,
      this.uri,
      this.url,
      this.account,
      this.inReplyToId,
      this.inReplyToAccountId,
      this.reblog,
      this.content,
      this.createdAt,
      this.reblogsCount,
      this.favouritesCount,
      this.reblogged,
      this.favourited,
      this.muted,
      this.sensitive,
      this.spoilerText,
      this.visibility,
      this.language})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('Status', 'id');
    if (uri == null) throw new BuiltValueNullFieldError('Status', 'uri');
    if (url == null) throw new BuiltValueNullFieldError('Status', 'url');
    if (account == null)
      throw new BuiltValueNullFieldError('Status', 'account');
    if (content == null)
      throw new BuiltValueNullFieldError('Status', 'content');
    if (createdAt == null)
      throw new BuiltValueNullFieldError('Status', 'createdAt');
    if (reblogsCount == null)
      throw new BuiltValueNullFieldError('Status', 'reblogsCount');
    if (favouritesCount == null)
      throw new BuiltValueNullFieldError('Status', 'favouritesCount');
    if (sensitive == null)
      throw new BuiltValueNullFieldError('Status', 'sensitive');
    if (spoilerText == null)
      throw new BuiltValueNullFieldError('Status', 'spoilerText');
    if (visibility == null)
      throw new BuiltValueNullFieldError('Status', 'visibility');
  }

  @override
  Status rebuild(void updates(StatusBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusBuilder toBuilder() => new StatusBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Status) return false;
    return id == other.id &&
        uri == other.uri &&
        url == other.url &&
        account == other.account &&
        inReplyToId == other.inReplyToId &&
        inReplyToAccountId == other.inReplyToAccountId &&
        reblog == other.reblog &&
        content == other.content &&
        createdAt == other.createdAt &&
        reblogsCount == other.reblogsCount &&
        favouritesCount == other.favouritesCount &&
        reblogged == other.reblogged &&
        favourited == other.favourited &&
        muted == other.muted &&
        sensitive == other.sensitive &&
        spoilerText == other.spoilerText &&
        visibility == other.visibility &&
        language == other.language;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            0,
                                                                            id
                                                                                .hashCode),
                                                                        uri
                                                                            .hashCode),
                                                                    url
                                                                        .hashCode),
                                                                account
                                                                    .hashCode),
                                                            inReplyToId
                                                                .hashCode),
                                                        inReplyToAccountId
                                                            .hashCode),
                                                    reblog.hashCode),
                                                content.hashCode),
                                            createdAt.hashCode),
                                        reblogsCount.hashCode),
                                    favouritesCount.hashCode),
                                reblogged.hashCode),
                            favourited.hashCode),
                        muted.hashCode),
                    sensitive.hashCode),
                spoilerText.hashCode),
            visibility.hashCode),
        language.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Status')
          ..add('id', id)
          ..add('uri', uri)
          ..add('url', url)
          ..add('account', account)
          ..add('inReplyToId', inReplyToId)
          ..add('inReplyToAccountId', inReplyToAccountId)
          ..add('reblog', reblog)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('reblogsCount', reblogsCount)
          ..add('favouritesCount', favouritesCount)
          ..add('reblogged', reblogged)
          ..add('favourited', favourited)
          ..add('muted', muted)
          ..add('sensitive', sensitive)
          ..add('spoilerText', spoilerText)
          ..add('visibility', visibility)
          ..add('language', language))
        .toString();
  }
}

class StatusBuilder implements Builder<Status, StatusBuilder> {
  _$Status _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _uri;
  String get uri => _$this._uri;
  set uri(String uri) => _$this._uri = uri;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  AccountBuilder _account;
  AccountBuilder get account => _$this._account ??= new AccountBuilder();
  set account(AccountBuilder account) => _$this._account = account;

  String _inReplyToId;
  String get inReplyToId => _$this._inReplyToId;
  set inReplyToId(String inReplyToId) => _$this._inReplyToId = inReplyToId;

  String _inReplyToAccountId;
  String get inReplyToAccountId => _$this._inReplyToAccountId;
  set inReplyToAccountId(String inReplyToAccountId) =>
      _$this._inReplyToAccountId = inReplyToAccountId;

  StatusBuilder _reblog;
  StatusBuilder get reblog => _$this._reblog ??= new StatusBuilder();
  set reblog(StatusBuilder reblog) => _$this._reblog = reblog;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  int _reblogsCount;
  int get reblogsCount => _$this._reblogsCount;
  set reblogsCount(int reblogsCount) => _$this._reblogsCount = reblogsCount;

  int _favouritesCount;
  int get favouritesCount => _$this._favouritesCount;
  set favouritesCount(int favouritesCount) =>
      _$this._favouritesCount = favouritesCount;

  bool _reblogged;
  bool get reblogged => _$this._reblogged;
  set reblogged(bool reblogged) => _$this._reblogged = reblogged;

  bool _favourited;
  bool get favourited => _$this._favourited;
  set favourited(bool favourited) => _$this._favourited = favourited;

  bool _muted;
  bool get muted => _$this._muted;
  set muted(bool muted) => _$this._muted = muted;

  bool _sensitive;
  bool get sensitive => _$this._sensitive;
  set sensitive(bool sensitive) => _$this._sensitive = sensitive;

  String _spoilerText;
  String get spoilerText => _$this._spoilerText;
  set spoilerText(String spoilerText) => _$this._spoilerText = spoilerText;

  String _visibility;
  String get visibility => _$this._visibility;
  set visibility(String visibility) => _$this._visibility = visibility;

  String _language;
  String get language => _$this._language;
  set language(String language) => _$this._language = language;

  StatusBuilder();

  StatusBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _uri = _$v.uri;
      _url = _$v.url;
      _account = _$v.account?.toBuilder();
      _inReplyToId = _$v.inReplyToId;
      _inReplyToAccountId = _$v.inReplyToAccountId;
      _reblog = _$v.reblog?.toBuilder();
      _content = _$v.content;
      _createdAt = _$v.createdAt;
      _reblogsCount = _$v.reblogsCount;
      _favouritesCount = _$v.favouritesCount;
      _reblogged = _$v.reblogged;
      _favourited = _$v.favourited;
      _muted = _$v.muted;
      _sensitive = _$v.sensitive;
      _spoilerText = _$v.spoilerText;
      _visibility = _$v.visibility;
      _language = _$v.language;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Status other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Status;
  }

  @override
  void update(void updates(StatusBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Status build() {
    _$Status _$result;
    try {
      _$result = _$v ??
          new _$Status._(
              id: id,
              uri: uri,
              url: url,
              account: account.build(),
              inReplyToId: inReplyToId,
              inReplyToAccountId: inReplyToAccountId,
              reblog: _reblog?.build(),
              content: content,
              createdAt: createdAt,
              reblogsCount: reblogsCount,
              favouritesCount: favouritesCount,
              reblogged: reblogged,
              favourited: favourited,
              muted: muted,
              sensitive: sensitive,
              spoilerText: spoilerText,
              visibility: visibility,
              language: language);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'account';
        account.build();

        _$failedField = 'reblog';
        _reblog?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Status', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Context extends Context {
  @override
  final BuiltList<Status> ancestors;
  @override
  final BuiltList<Status> descendants;

  factory _$Context([void updates(ContextBuilder b)]) =>
      (new ContextBuilder()..update(updates)).build();

  _$Context._({this.ancestors, this.descendants}) : super._() {
    if (ancestors == null)
      throw new BuiltValueNullFieldError('Context', 'ancestors');
    if (descendants == null)
      throw new BuiltValueNullFieldError('Context', 'descendants');
  }

  @override
  Context rebuild(void updates(ContextBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ContextBuilder toBuilder() => new ContextBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Context) return false;
    return ancestors == other.ancestors && descendants == other.descendants;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ancestors.hashCode), descendants.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Context')
          ..add('ancestors', ancestors)
          ..add('descendants', descendants))
        .toString();
  }
}

class ContextBuilder implements Builder<Context, ContextBuilder> {
  _$Context _$v;

  ListBuilder<Status> _ancestors;
  ListBuilder<Status> get ancestors =>
      _$this._ancestors ??= new ListBuilder<Status>();
  set ancestors(ListBuilder<Status> ancestors) => _$this._ancestors = ancestors;

  ListBuilder<Status> _descendants;
  ListBuilder<Status> get descendants =>
      _$this._descendants ??= new ListBuilder<Status>();
  set descendants(ListBuilder<Status> descendants) =>
      _$this._descendants = descendants;

  ContextBuilder();

  ContextBuilder get _$this {
    if (_$v != null) {
      _ancestors = _$v.ancestors?.toBuilder();
      _descendants = _$v.descendants?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Context other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Context;
  }

  @override
  void update(void updates(ContextBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Context build() {
    _$Context _$result;
    try {
      _$result = _$v ??
          new _$Context._(
              ancestors: ancestors.build(), descendants: descendants.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ancestors';
        ancestors.build();
        _$failedField = 'descendants';
        descendants.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Context', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
