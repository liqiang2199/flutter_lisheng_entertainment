// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RechargeTypeListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RechargeTypeListBeen _$RechargeTypeListBeenFromJson(Map<String, dynamic> json) {
  return RechargeTypeListBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : RechargeTypeDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$RechargeTypeListBeenToJson(
        RechargeTypeListBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
