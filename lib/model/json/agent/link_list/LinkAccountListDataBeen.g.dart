// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LinkAccountListDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkAccountListDataBeen _$LinkAccountListDataBeenFromJson(
    Map<String, dynamic> json) {
  return LinkAccountListDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : LinkAccountListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$LinkAccountListDataBeenToJson(
        LinkAccountListDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
