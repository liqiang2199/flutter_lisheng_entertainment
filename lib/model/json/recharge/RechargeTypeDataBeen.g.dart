// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RechargeTypeDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RechargeTypeDataBeen _$RechargeTypeDataBeenFromJson(Map<String, dynamic> json) {
  return RechargeTypeDataBeen(
    json['id'] as int,
    json['type'] as String,
    json['image'] as String,
    json['name'] as String,
    json['min_money'] as String,
    json['code'] as String,
    json['pay_name'] as String,
  );
}

Map<String, dynamic> _$RechargeTypeDataBeenToJson(
        RechargeTypeDataBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'image': instance.image,
      'name': instance.name,
      'min_money': instance.min_money,
      'code': instance.code,
      'pay_name': instance.pay_name,
    };
