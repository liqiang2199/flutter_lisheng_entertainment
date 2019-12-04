// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataBeen _$LoginDataBeenFromJson(Map<String, dynamic> json) {
  return LoginDataBeen(
    json['token'] as String,
    json['userInfo'] == null
        ? null
        : LoginUserInfoBeen.fromJson(json['userInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginDataBeenToJson(LoginDataBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userInfo': instance.userInfo,
    };
