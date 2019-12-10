// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LinkAccountListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkAccountListBeen _$LinkAccountListBeenFromJson(Map<String, dynamic> json) {
  return LinkAccountListBeen(
    json['id'] as int,
    json['voucher'] as String,
    json['url'] as String,
    json['day'] as int,
    json['ratio'] as String,
    json['is_dali'] as String,
    json['createtime'] as String,
    json['expirationtime'] as String,
  );
}

Map<String, dynamic> _$LinkAccountListBeenToJson(
        LinkAccountListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'voucher': instance.voucher,
      'url': instance.url,
      'day': instance.day,
      'ratio': instance.ratio,
      'is_dali': instance.is_dali,
      'createtime': instance.createtime,
      'expirationtime': instance.expirationtime,
    };
