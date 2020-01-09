// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserReportBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReportBeen _$UserReportBeenFromJson(Map<String, dynamic> json) {
  return UserReportBeen(
    json['data'] == null
        ? null
        : UserReportDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$UserReportBeenToJson(UserReportBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
