// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfoCenterHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoCenterHttpBeen _$UserInfoCenterHttpBeenFromJson(
    Map<String, dynamic> json) {
  return UserInfoCenterHttpBeen(
    json['new_pwd'] as String,
    json['old_pwd'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$UserInfoCenterHttpBeenToJson(
        UserInfoCenterHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'new_pwd': instance.new_pwd,
      'old_pwd': instance.old_pwd,
    };
