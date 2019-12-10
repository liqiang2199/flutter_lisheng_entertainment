// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BindBankHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BindBankHttpBeen _$BindBankHttpBeenFromJson(Map<String, dynamic> json) {
  return BindBankHttpBeen(
    json['token'] as String,
    json['banktype_id'] as String,
    json['realname'] as String,
    json['card_number'] as String,
    json['branch_name'] as String,
    json['capital_pwd'] as String,
  );
}

Map<String, dynamic> _$BindBankHttpBeenToJson(BindBankHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'banktype_id': instance.banktype_id,
      'realname': instance.realname,
      'card_number': instance.card_number,
      'branch_name': instance.branch_name,
      'capital_pwd': instance.capital_pwd,
    };
