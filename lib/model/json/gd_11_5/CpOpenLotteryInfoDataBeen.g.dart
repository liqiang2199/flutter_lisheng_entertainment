// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CpOpenLotteryInfoDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CpOpenLotteryInfoDataBeen _$CpOpenLotteryInfoDataBeenFromJson(
    Map<String, dynamic> json) {
  return CpOpenLotteryInfoDataBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time']
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CpOpenLotteryInfoBeen.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CpOpenLotteryInfoDataBeenToJson(
        CpOpenLotteryInfoDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
