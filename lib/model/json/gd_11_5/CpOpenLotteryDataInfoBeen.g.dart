// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CpOpenLotteryDataInfoBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CpOpenLotteryDataInfoBeen _$CpOpenLotteryDataInfoBeenFromJson(
    Map<String, dynamic> json) {
  return CpOpenLotteryDataInfoBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time']
    ..data = json['data'] == null
        ? null
        : CpOpenLotteryInfoBeen.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CpOpenLotteryDataInfoBeenToJson(
        CpOpenLotteryDataInfoBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
