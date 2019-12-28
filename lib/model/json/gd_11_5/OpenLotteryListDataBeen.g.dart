// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenLotteryListDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenLotteryListDataBeen _$OpenLotteryListDataBeenFromJson(
    Map<String, dynamic> json) {
  return OpenLotteryListDataBeen(
    json['data'] == null
        ? null
        : OpenLotteryListTwoDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$OpenLotteryListDataBeenToJson(
        OpenLotteryListDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
