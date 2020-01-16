// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendFiveSumBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendFiveSumBeen _$TrendFiveSumBeenFromJson(Map<String, dynamic> json) {
  return TrendFiveSumBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TrendFiveSumDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TrendFiveSumBeenToJson(TrendFiveSumBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
