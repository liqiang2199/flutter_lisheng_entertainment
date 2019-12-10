// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDataBeen _$BankDataBeenFromJson(Map<String, dynamic> json) {
  return BankDataBeen(
    json['id'] as int,
    json['user_id'] as int,
    json['banktype_id'] as int,
    json['realname'] as String,
    json['card_number'] as String,
    json['branch_name'] as String,
    json['bank_name'] as String,
  );
}

Map<String, dynamic> _$BankDataBeenToJson(BankDataBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'banktype_id': instance.banktype_id,
      'realname': instance.realname,
      'card_number': instance.card_number,
      'branch_name': instance.branch_name,
      'bank_name': instance.bank_name,
    };
