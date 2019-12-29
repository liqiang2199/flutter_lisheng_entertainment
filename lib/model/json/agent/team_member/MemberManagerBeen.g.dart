// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MemberManagerBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberManagerBeen _$MemberManagerBeenFromJson(Map<String, dynamic> json) {
  return MemberManagerBeen(
    json['data'] == null
        ? null
        : MemberManagerDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$MemberManagerBeenToJson(MemberManagerBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
