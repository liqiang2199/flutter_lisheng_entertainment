// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WithdrawListDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawListDataBeen _$WithdrawListDataBeenFromJson(Map<String, dynamic> json) {
  return WithdrawListDataBeen(
    json['data'] == null
        ? null
        : WithdrawListBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$WithdrawListDataBeenToJson(
        WithdrawListDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
