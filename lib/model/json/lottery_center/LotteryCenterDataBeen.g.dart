// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotteryCenterDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryCenterDataBeen _$LotteryCenterDataBeenFromJson(
    Map<String, dynamic> json) {
  return LotteryCenterDataBeen()
    ..name = json['name'] as String
    ..id = json['id'] as int
    ..frequency = json['frequency'] as String
    ..preDrawIssue = json['preDrawIssue'] as int
    ..preDrawTime = json['preDrawTime'] as String
    ..preDrawCode = json['preDrawCode'] as String
    ..drawTime = json['drawTime'] as String
    ..drawIssue = json['drawIssue'] as int
    ..serverTime = json['serverTime'] as String;
}

Map<String, dynamic> _$LotteryCenterDataBeenToJson(
        LotteryCenterDataBeen instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'frequency': instance.frequency,
      'preDrawIssue': instance.preDrawIssue,
      'preDrawTime': instance.preDrawTime,
      'preDrawCode': instance.preDrawCode,
      'drawTime': instance.drawTime,
      'drawIssue': instance.drawIssue,
      'serverTime': instance.serverTime,
    };
