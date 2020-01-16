// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendSingleDoubleDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendSingleDoubleDataBeen _$TrendSingleDoubleDataBeenFromJson(
    Map<String, dynamic> json) {
  return TrendSingleDoubleDataBeen(
    json['pre_draw_issue'] as String,
  )
    ..pre_draw_time = json['pre_draw_time'] as String
    ..pre_draw_code = json['pre_draw_code'] as String
    ..num = (json['num'] as List)
        ?.map((e) => e == null
            ? null
            : TrendSingleDoubleDataNumBeen.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TrendSingleDoubleDataBeenToJson(
        TrendSingleDoubleDataBeen instance) =>
    <String, dynamic>{
      'pre_draw_issue': instance.pre_draw_issue,
      'pre_draw_time': instance.pre_draw_time,
      'pre_draw_code': instance.pre_draw_code,
      'num': instance.num,
    };
