// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBeen _$LoginBeenFromJson(Map<String, dynamic> json) {
  return LoginBeen(
    json['data'] == null
        ? null
        : LoginDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$LoginBeenToJson(LoginBeen instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
