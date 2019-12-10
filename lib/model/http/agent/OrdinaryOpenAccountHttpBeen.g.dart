// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdinaryOpenAccountHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdinaryOpenAccountHttpBeen _$OrdinaryOpenAccountHttpBeenFromJson(
    Map<String, dynamic> json) {
  return OrdinaryOpenAccountHttpBeen(
    json['is_dali'] as String,
    json['account'] as String,
    json['username'] as String,
    json['pwd'] as String,
    json['ratio'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$OrdinaryOpenAccountHttpBeenToJson(
        OrdinaryOpenAccountHttpBeen instance) =>
    <String, dynamic>{
      'is_dali': instance.is_dali,
      'account': instance.account,
      'username': instance.username,
      'pwd': instance.pwd,
      'ratio': instance.ratio,
      'token': instance.token,
    };
