// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenLotteryListTwoDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenLotteryListTwoDataListBeen _$OpenLotteryListTwoDataListBeenFromJson(
    Map<String, dynamic> json) {
  return OpenLotteryListTwoDataListBeen(
    json['id'] as int,
    json['lottery_id'] as int,
    json['pre_draw_issue'] as String,
    json['is_jiesuan'] as String,
    json['pre_draw_time'] as String,
    json['pre_draw_code'] as String,
    json['createtime'] as int,
  )
    ..drawTime = json['drawTime'] as String
    ..drawIssue = json['drawIssue'] as int;
}

Map<String, dynamic> _$OpenLotteryListTwoDataListBeenToJson(
        OpenLotteryListTwoDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lottery_id': instance.lottery_id,
      'pre_draw_issue': instance.pre_draw_issue,
      'is_jiesuan': instance.is_jiesuan,
      'pre_draw_time': instance.pre_draw_time,
      'pre_draw_code': instance.pre_draw_code,
      'createtime': instance.createtime,
      'drawTime': instance.drawTime,
      'drawIssue': instance.drawIssue,
    };
