// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenAccountIntervalBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAccountIntervalBeen _$OpenAccountIntervalBeenFromJson(
    Map<String, dynamic> json) {
  return OpenAccountIntervalBeen(
    json['data'] == null
        ? null
        : OpenAccountIntervalDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$OpenAccountIntervalBeenToJson(
        OpenAccountIntervalBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
