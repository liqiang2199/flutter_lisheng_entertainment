// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdinaryOpenAccountBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdinaryOpenAccountBeen _$OrdinaryOpenAccountBeenFromJson(
    Map<String, dynamic> json) {
  return OrdinaryOpenAccountBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$OrdinaryOpenAccountBeenToJson(
        OrdinaryOpenAccountBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
    };
