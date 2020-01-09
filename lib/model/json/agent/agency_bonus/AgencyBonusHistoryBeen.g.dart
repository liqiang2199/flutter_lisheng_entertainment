// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AgencyBonusHistoryBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyBonusHistoryBeen _$AgencyBonusHistoryBeenFromJson(
    Map<String, dynamic> json) {
  return AgencyBonusHistoryBeen(
    json['data'] == null
        ? null
        : AgencyBonusHistoryDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$AgencyBonusHistoryBeenToJson(
        AgencyBonusHistoryBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
