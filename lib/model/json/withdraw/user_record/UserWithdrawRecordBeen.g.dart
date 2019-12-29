// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWithdrawRecordBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithdrawRecordBeen _$UserWithdrawRecordBeenFromJson(
    Map<String, dynamic> json) {
  return UserWithdrawRecordBeen(
    json['data'] == null
        ? null
        : UserWithdrawRecordDataBeen.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$UserWithdrawRecordBeenToJson(
        UserWithdrawRecordBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
