// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamRechargeRecordDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRechargeRecordDataListBeen _$TeamRechargeRecordDataListBeenFromJson(
    Map<String, dynamic> json) {
  return TeamRechargeRecordDataListBeen(
    json['id'] as int,
    json['user_id'] as int,
    json['paytype_id'] as int,
    json['status'] as String,
    json['money'] as String,
    json['name'] as String,
    json['remark'] as String,
    json['reason'] as String,
    json['createtime'] as String,
    json['updatetime'] as String,
    json['username'] as String,
  );
}

Map<String, dynamic> _$TeamRechargeRecordDataListBeenToJson(
        TeamRechargeRecordDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'paytype_id': instance.paytype_id,
      'status': instance.status,
      'money': instance.money,
      'name': instance.name,
      'remark': instance.remark,
      'reason': instance.reason,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'username': instance.username,
    };
