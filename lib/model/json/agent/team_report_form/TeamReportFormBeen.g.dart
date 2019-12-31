// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamReportFormBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamReportFormBeen _$TeamReportFormBeenFromJson(Map<String, dynamic> json) {
  return TeamReportFormBeen(
    json['data'] == null
        ? null
        : TeamReportFormDataBeen.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$TeamReportFormBeenToJson(TeamReportFormBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
