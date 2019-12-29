// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamOverviewBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamOverviewBeen _$TeamOverviewBeenFromJson(Map<String, dynamic> json) {
  return TeamOverviewBeen(
    json['data'] == null
        ? null
        : TeamOverviewDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TeamOverviewBeenToJson(TeamOverviewBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
