// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendHanoiOneLotteryMoreBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendHanoiOneLotteryMoreBeen _$TrendHanoiOneLotteryMoreBeenFromJson(
    Map<String, dynamic> json) {
  return TrendHanoiOneLotteryMoreBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TrendHanoiOneLotteryMoreDataBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TrendHanoiOneLotteryMoreBeenToJson(
        TrendHanoiOneLotteryMoreBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
