// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendSingleDoubleBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendSingleDoubleBeen _$TrendSingleDoubleBeenFromJson(
    Map<String, dynamic> json) {
  return TrendSingleDoubleBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TrendSingleDoubleDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TrendSingleDoubleBeenToJson(
        TrendSingleDoubleBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
