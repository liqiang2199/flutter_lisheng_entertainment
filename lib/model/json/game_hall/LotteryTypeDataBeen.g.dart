// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotteryTypeDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryTypeDataBeen _$LotteryTypeDataBeenFromJson(Map<String, dynamic> json) {
  return LotteryTypeDataBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time']
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : LotteryTypeDataListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$LotteryTypeDataBeenToJson(
        LotteryTypeDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
