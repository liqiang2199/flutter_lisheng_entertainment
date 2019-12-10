// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankListBeen _$BankListBeenFromJson(Map<String, dynamic> json) {
  return BankListBeen(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BankDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$BankListBeenToJson(BankListBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
