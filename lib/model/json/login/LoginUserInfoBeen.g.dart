// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginUserInfoBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserInfoBeen _$LoginUserInfoBeenFromJson(Map<String, dynamic> json) {
  return LoginUserInfoBeen(
    json['id'] as int,
    json['avatar'] as String,
    json['is_dali'] as String,
    json['username'] as String,
    json['account'] as String,
    json['level'] as int,
    json['status'] as String,
    json['pay_pwd'] as String,
    json['pwd'] as String,
    json['user_id'] as int,
    json['all_money'] as String,
    json['ratio'] as String,
    json['login_time'] as int,
    json['login_ip'] as String,
    json['createtime'] as int,
    json['updatetime'] as int,
  );
}

Map<String, dynamic> _$LoginUserInfoBeenToJson(LoginUserInfoBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'is_dali': instance.is_dali,
      'username': instance.username,
      'account': instance.account,
      'level': instance.level,
      'status': instance.status,
      'pay_pwd': instance.pay_pwd,
      'pwd': instance.pwd,
      'user_id': instance.user_id,
      'all_money': instance.all_money,
      'ratio': instance.ratio,
      'login_time': instance.login_time,
      'login_ip': instance.login_ip,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
    };
