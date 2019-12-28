// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWithdrawHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithdrawHttpBeen _$UserWithdrawHttpBeenFromJson(Map<String, dynamic> json) {
  return UserWithdrawHttpBeen(
    json['token'] as String,
    json['money'] as String,
    json['bank_id'] as String,
    json['pay_pwd'] as String,
  );
}

Map<String, dynamic> _$UserWithdrawHttpBeenToJson(
        UserWithdrawHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'money': instance.money,
      'bank_id': instance.bank_id,
      'pay_pwd': instance.pay_pwd,
    };
