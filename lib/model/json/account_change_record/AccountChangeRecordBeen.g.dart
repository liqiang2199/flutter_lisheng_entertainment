// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountChangeRecordBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountChangeRecordBeen _$AccountChangeRecordBeenFromJson(
    Map<String, dynamic> json) {
  return AccountChangeRecordBeen(
    json['data'] == null
        ? null
        : AccountChangeRecordDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$AccountChangeRecordBeenToJson(
        AccountChangeRecordBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
