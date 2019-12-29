// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWithdrawRecordDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithdrawRecordDataListBeen _$UserWithdrawRecordDataListBeenFromJson(
    Map<String, dynamic> json) {
  return UserWithdrawRecordDataListBeen()
    ..id = json['id'] as int
    ..user_id = json['user_id'] as int
    ..bank_id = json['bank_id'] as int
    ..money = json['money'] as String
    ..service_money = json['service_money'] as String
    ..status = json['status'] as String
    ..remark = json['remark'] as String
    ..createtime = json['createtime'] as String
    ..updatetime = json['updatetime'] as String
    ..realname = json['realname'] as String
    ..card_number = json['card_number'] as String
    ..branch_name = json['branch_name'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$UserWithdrawRecordDataListBeenToJson(
        UserWithdrawRecordDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'bank_id': instance.bank_id,
      'money': instance.money,
      'service_money': instance.service_money,
      'status': instance.status,
      'remark': instance.remark,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'realname': instance.realname,
      'card_number': instance.card_number,
      'branch_name': instance.branch_name,
      'name': instance.name,
    };
