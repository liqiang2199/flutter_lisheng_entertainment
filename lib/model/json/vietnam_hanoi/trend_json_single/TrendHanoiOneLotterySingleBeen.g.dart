// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendHanoiOneLotterySingleBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendHanoiOneLotterySingleBeen _$TrendHanoiOneLotterySingleBeenFromJson(
    Map<String, dynamic> json) {
  return TrendHanoiOneLotterySingleBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TrendHanoiOneLotterySingleReDataBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TrendHanoiOneLotterySingleBeenToJson(
        TrendHanoiOneLotterySingleBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
