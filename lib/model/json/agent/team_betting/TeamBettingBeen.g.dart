// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamBettingBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamBettingBeen _$TeamBettingBeenFromJson(Map<String, dynamic> json) {
  return TeamBettingBeen(
    json['data'] == null
        ? null
        : TeamBettingDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TeamBettingBeenToJson(TeamBettingBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
