// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalculationBettingNumBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculationBettingNumBeen _$CalculationBettingNumBeenFromJson(
    Map<String, dynamic> json) {
  return CalculationBettingNumBeen(
    json['data'] == null
        ? null
        : CalculationBettingNumDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$CalculationBettingNumBeenToJson(
        CalculationBettingNumBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
