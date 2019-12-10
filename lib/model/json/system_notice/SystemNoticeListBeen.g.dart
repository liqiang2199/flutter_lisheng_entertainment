// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SystemNoticeListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemNoticeListBeen _$SystemNoticeListBeenFromJson(Map<String, dynamic> json) {
  return SystemNoticeListBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SystemNoticeDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$SystemNoticeListBeenToJson(
        SystemNoticeListBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
