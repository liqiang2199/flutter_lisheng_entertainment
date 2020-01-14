// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VietnamHanoiLotteryTimeBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VietnamHanoiLotteryTimeBeen _$VietnamHanoiLotteryTimeBeenFromJson(
    Map<String, dynamic> json) {
  return VietnamHanoiLotteryTimeBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time']
    ..data = json['data'] == null
        ? null
        : VietnamHanoiLotteryTimeDataBeen.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VietnamHanoiLotteryTimeBeenToJson(
        VietnamHanoiLotteryTimeBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
