// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendHanoiOneLotterySingleReDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendHanoiOneLotterySingleReDataBeen
    _$TrendHanoiOneLotterySingleReDataBeenFromJson(Map<String, dynamic> json) {
  return TrendHanoiOneLotterySingleReDataBeen()
    ..pre_draw_issue = json['pre_draw_issue'] as String
    ..num = json['num'] as String
    ..pre_draw_time = json['pre_draw_time'] as String
    ..pre_draw_code = json['pre_draw_code'] as String
    ..moreNum = (json['moreNum'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TrendHanoiOneLotterySingleReDataBeenToJson(
        TrendHanoiOneLotterySingleReDataBeen instance) =>
    <String, dynamic>{
      'pre_draw_issue': instance.pre_draw_issue,
      'num': instance.num,
      'pre_draw_time': instance.pre_draw_time,
      'pre_draw_code': instance.pre_draw_code,
      'moreNum': instance.moreNum,
    };
