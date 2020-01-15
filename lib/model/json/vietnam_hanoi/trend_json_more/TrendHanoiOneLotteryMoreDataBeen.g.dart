// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendHanoiOneLotteryMoreDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendHanoiOneLotteryMoreDataBeen _$TrendHanoiOneLotteryMoreDataBeenFromJson(
    Map<String, dynamic> json) {
  return TrendHanoiOneLotteryMoreDataBeen()
    ..pre_draw_issue = json['pre_draw_issue'] as String
    ..pre_draw_code = json['pre_draw_code'] as String
    ..pre_draw_time = json['pre_draw_time'] as String
    ..num = (json['num'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TrendHanoiOneLotteryMoreDataBeenToJson(
        TrendHanoiOneLotteryMoreDataBeen instance) =>
    <String, dynamic>{
      'pre_draw_issue': instance.pre_draw_issue,
      'pre_draw_code': instance.pre_draw_code,
      'pre_draw_time': instance.pre_draw_time,
      'num': instance.num,
    };
