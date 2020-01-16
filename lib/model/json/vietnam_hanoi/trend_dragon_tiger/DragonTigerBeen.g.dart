// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DragonTigerBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DragonTigerBeen _$DragonTigerBeenFromJson(Map<String, dynamic> json) {
  return DragonTigerBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DragonTigerDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$DragonTigerBeenToJson(DragonTigerBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
