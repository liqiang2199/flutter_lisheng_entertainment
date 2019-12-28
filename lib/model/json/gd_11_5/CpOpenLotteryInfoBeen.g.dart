// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CpOpenLotteryInfoBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CpOpenLotteryInfoBeen _$CpOpenLotteryInfoBeenFromJson(
    Map<String, dynamic> json) {
  return CpOpenLotteryInfoBeen(
    json['name'] as String,
    json['id'] as int,
    json['frequency'] as String,
    json['preDrawIssue'] as int,
    json['preDrawTime'] as String,
    json['preDrawCode'] as String,
    json['drawIssue'] as int,
    json['drawTime'] as String,
    json['serverTime'] as String,
  );
}

Map<String, dynamic> _$CpOpenLotteryInfoBeenToJson(
        CpOpenLotteryInfoBeen instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'frequency': instance.frequency,
      'preDrawIssue': instance.preDrawIssue,
      'preDrawTime': instance.preDrawTime,
      'preDrawCode': instance.preDrawCode,
      'drawIssue': instance.drawIssue,
      'drawTime': instance.drawTime,
      'serverTime': instance.serverTime,
    };
