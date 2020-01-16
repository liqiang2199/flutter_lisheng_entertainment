// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendFiveSumDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendFiveSumDataBeen _$TrendFiveSumDataBeenFromJson(Map<String, dynamic> json) {
  return TrendFiveSumDataBeen(
    json['pre_draw_issue'] as String,
    json['sum'] as int,
    json['ds'] as String,
    json['dx'] as String,
    json['pre_draw_time'] as String,
    json['pre_draw_code'] as String,
  );
}

Map<String, dynamic> _$TrendFiveSumDataBeenToJson(
        TrendFiveSumDataBeen instance) =>
    <String, dynamic>{
      'pre_draw_issue': instance.pre_draw_issue,
      'sum': instance.sum,
      'ds': instance.ds,
      'dx': instance.dx,
      'pre_draw_time': instance.pre_draw_time,
      'pre_draw_code': instance.pre_draw_code,
    };
