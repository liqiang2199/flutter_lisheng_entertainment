// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBeen _$JsonBeenFromJson(Map<String, dynamic> json) {
  return JsonBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$JsonBeenToJson(JsonBeen instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
    };
