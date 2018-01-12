library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'built_models.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  RegisterResponse,
  Account,
  Status,
])
final Serializers serialzers = _$serialzers;
final Serializers jsonSerializers = (_$serialzers.toBuilder()
  ..addPlugin(new StandardJsonPlugin()))
  .build();