// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamReportFormDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamReportFormDataBeen _$TeamReportFormDataBeenFromJson(
    Map<String, dynamic> json) {
  return TeamReportFormDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TeamReportFormDataListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$TeamReportFormDataBeenToJson(
        TeamReportFormDataBeen instance) =>
    <String, dynamic>{
      'data': instance.data,
      'count': instance.count,
    };
