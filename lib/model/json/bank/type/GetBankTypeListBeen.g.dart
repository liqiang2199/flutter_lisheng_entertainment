// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBankTypeListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBankTypeListBeen _$GetBankTypeListBeenFromJson(Map<String, dynamic> json) {
  return GetBankTypeListBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GetBankTypeDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$GetBankTypeListBeenToJson(
        GetBankTypeListBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
