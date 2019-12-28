// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBettingRecordBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBettingRecordBeen _$GetBettingRecordBeenFromJson(Map<String, dynamic> json) {
  return GetBettingRecordBeen(
    json['data'] == null
        ? null
        : GetBettingRecordDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$GetBettingRecordBeenToJson(
        GetBettingRecordBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
