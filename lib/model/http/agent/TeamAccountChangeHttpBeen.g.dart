// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamAccountChangeHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAccountChangeHttpBeen _$TeamAccountChangeHttpBeenFromJson(
    Map<String, dynamic> json) {
  return TeamAccountChangeHttpBeen()
    ..token = json['token'] as String
    ..username = json['username'] as String
    ..limit = json['limit'] as String
    ..page = json['page'] as String
    ..type = json['type'] as String
    ..date = json['date'] as String;
}

Map<String, dynamic> _$TeamAccountChangeHttpBeenToJson(
        TeamAccountChangeHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'limit': instance.limit,
      'page': instance.page,
      'type': instance.type,
      'date': instance.date,
    };
