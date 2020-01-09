// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserReportHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReportHttpBeen _$UserReportHttpBeenFromJson(Map<String, dynamic> json) {
  return UserReportHttpBeen()
    ..token = json['token'] as String
    ..start_date = json['start_date'] as String
    ..end_date = json['end_date'] as String;
}

Map<String, dynamic> _$UserReportHttpBeenToJson(UserReportHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
    };
