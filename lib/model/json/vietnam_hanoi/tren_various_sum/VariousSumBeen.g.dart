// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VariousSumBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariousSumBeen _$VariousSumBeenFromJson(Map<String, dynamic> json) {
  return VariousSumBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : VariousSumDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$VariousSumBeenToJson(VariousSumBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
