// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamRechargeRecordBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRechargeRecordBeen _$TeamRechargeRecordBeenFromJson(
    Map<String, dynamic> json) {
  return TeamRechargeRecordBeen(
    json['data'] == null
        ? null
        : TeamRechargeRecordDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TeamRechargeRecordBeenToJson(
        TeamRechargeRecordBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
