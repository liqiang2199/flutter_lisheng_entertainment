// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamOverviewDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamOverviewDataBeen _$TeamOverviewDataBeenFromJson(Map<String, dynamic> json) {
  return TeamOverviewDataBeen(
    json['teamAllMoney'] as String,
    json['userCount'] as int,
    json['onlineUserCount'] as int,
    json['teamCzMoney'] as String,
    json['teamTxMoney'] as String,
    json['teamXzMoney'] as String,
    json['teamZjMoney'] as String,
  );
}

Map<String, dynamic> _$TeamOverviewDataBeenToJson(
        TeamOverviewDataBeen instance) =>
    <String, dynamic>{
      'teamAllMoney': instance.teamAllMoney,
      'userCount': instance.userCount,
      'onlineUserCount': instance.onlineUserCount,
      'teamCzMoney': instance.teamCzMoney,
      'teamTxMoney': instance.teamTxMoney,
      'teamXzMoney': instance.teamXzMoney,
      'teamZjMoney': instance.teamZjMoney,
    };
