// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamAccountChangeBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAccountChangeBeen _$TeamAccountChangeBeenFromJson(
    Map<String, dynamic> json) {
  return TeamAccountChangeBeen()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time']
    ..data = json['data'] == null
        ? null
        : TeamAccountChangeDataBeen.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TeamAccountChangeBeenToJson(
        TeamAccountChangeBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
