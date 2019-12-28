// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CpOpenLotteryInfoHttp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CpOpenLotteryInfoHttp _$CpOpenLotteryInfoHttpFromJson(
    Map<String, dynamic> json) {
  return CpOpenLotteryInfoHttp(
    json['token'] as String,
    json['lottery'] as String,
  );
}

Map<String, dynamic> _$CpOpenLotteryInfoHttpToJson(
        CpOpenLotteryInfoHttp instance) =>
    <String, dynamic>{
      'token': instance.token,
      'lottery': instance.lottery,
    };
