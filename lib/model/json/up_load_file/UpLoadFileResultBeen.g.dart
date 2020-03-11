// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpLoadFileResultBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpLoadFileResultBeen _$UpLoadFileResultBeenFromJson(Map<String, dynamic> json) {
  return UpLoadFileResultBeen(
    json['data'] == null
        ? null
        : UpLoadFileResultDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$UpLoadFileResultBeenToJson(
        UpLoadFileResultBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
