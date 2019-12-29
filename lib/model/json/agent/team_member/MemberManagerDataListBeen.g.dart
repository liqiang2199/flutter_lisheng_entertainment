// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MemberManagerDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberManagerDataListBeen _$MemberManagerDataListBeenFromJson(
    Map<String, dynamic> json) {
  return MemberManagerDataListBeen(
    json['id'] as int,
    json['avatar'] as String,
    json['is_dali'] as String,
    json['username'] as String,
    json['account'] as String,
    json['level'] as int,
    json['user_id'] as int,
    json['status'] as String,
    json['all_subsidy_money'] as String,
    json['all_money'] as String,
    json['ratio'] as String,
    json['login_time'] as String,
    json['login_ip'] as String,
    json['createtime'] as String,
    json['updatetime'] as String,
    json['level_name'] as String,
  );
}

Map<String, dynamic> _$MemberManagerDataListBeenToJson(
        MemberManagerDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'is_dali': instance.is_dali,
      'username': instance.username,
      'account': instance.account,
      'level': instance.level,
      'user_id': instance.user_id,
      'status': instance.status,
      'all_subsidy_money': instance.all_subsidy_money,
      'all_money': instance.all_money,
      'ratio': instance.ratio,
      'login_time': instance.login_time,
      'login_ip': instance.login_ip,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'level_name': instance.level_name,
    };
