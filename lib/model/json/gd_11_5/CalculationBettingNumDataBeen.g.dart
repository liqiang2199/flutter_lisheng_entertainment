// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalculationBettingNumDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculationBettingNumDataBeen _$CalculationBettingNumDataBeenFromJson(
    Map<String, dynamic> json) {
  return CalculationBettingNumDataBeen(
    (json['data_num'] as List)?.map((e) => e as String)?.toList(),
    json['count'] as int,
    json['play_name'] as String,
    json['money_award'] as String,
    json['money'] as String,
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time']
    ..fd = json['fd'] as String;
}

Map<String, dynamic> _$CalculationBettingNumDataBeenToJson(
        CalculationBettingNumDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data_num': instance.data_num,
      'count': instance.count,
      'play_name': instance.play_name,
      'money_award': instance.money_award,
      'money': instance.money,
      'fd': instance.fd,
    };
