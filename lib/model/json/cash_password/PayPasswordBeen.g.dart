// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayPasswordBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPasswordBeen _$PayPasswordBeenFromJson(Map<String, dynamic> json) {
  return PayPasswordBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$PayPasswordBeenToJson(PayPasswordBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
    };
