// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotteryCenterBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryCenterBeen _$LotteryCenterBeenFromJson(Map<String, dynamic> json) {
  return LotteryCenterBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : LotteryCenterDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$LotteryCenterBeenToJson(LotteryCenterBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
