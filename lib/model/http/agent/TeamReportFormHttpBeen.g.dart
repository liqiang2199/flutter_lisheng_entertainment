// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamReportFormHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamReportFormHttpBeen _$TeamReportFormHttpBeenFromJson(
    Map<String, dynamic> json) {
  return TeamReportFormHttpBeen()
    ..token = json['token'] as String
    ..user_id = json['user_id'] as String
    ..username = json['username'] as String
    ..limit = json['limit'] as String
    ..page = json['page'] as String;
}

Map<String, dynamic> _$TeamReportFormHttpBeenToJson(
        TeamReportFormHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_id': instance.user_id,
      'username': instance.username,
      'limit': instance.limit,
      'page': instance.page,
    };
