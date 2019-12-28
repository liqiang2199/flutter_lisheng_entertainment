// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBettingRecordDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBettingRecordDataBeen _$GetBettingRecordDataBeenFromJson(
    Map<String, dynamic> json) {
  return GetBettingRecordDataBeen(
    json['count'] as int,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GetBettingRecordDataListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$GetBettingRecordDataBeenToJson(
        GetBettingRecordDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'count': instance.count,
      'data': instance.data,
    };
