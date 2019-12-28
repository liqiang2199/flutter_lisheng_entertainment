// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountChangeRecordDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountChangeRecordDataListBeen _$AccountChangeRecordDataListBeenFromJson(
    Map<String, dynamic> json) {
  return AccountChangeRecordDataListBeen(
    json['id'] as int,
    json['user_id'] as int,
    json['t'] as String,
    json['money'] as String,
    json['all_money'] as String,
    json['type'] as String,
    json['relation'] as String,
    json['createtime'] as String,
    json['remark'] as String,
  );
}

Map<String, dynamic> _$AccountChangeRecordDataListBeenToJson(
        AccountChangeRecordDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      't': instance.t,
      'money': instance.money,
      'all_money': instance.all_money,
      'type': instance.type,
      'relation': instance.relation,
      'createtime': instance.createtime,
      'remark': instance.remark,
    };
