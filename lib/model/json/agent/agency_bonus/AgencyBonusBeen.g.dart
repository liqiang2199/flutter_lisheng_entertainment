// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AgencyBonusBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyBonusBeen _$AgencyBonusBeenFromJson(Map<String, dynamic> json) {
  return AgencyBonusBeen(
    json['data'] == null
        ? null
        : AgencyBonusDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$AgencyBonusBeenToJson(AgencyBonusBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
