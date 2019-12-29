// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MemberManagerHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberManagerHttpBeen _$MemberManagerHttpBeenFromJson(
    Map<String, dynamic> json) {
  return MemberManagerHttpBeen()
    ..token = json['token'] as String
    ..username = json['username'] as String
    ..limit = json['limit'] as String
    ..page = json['page'] as String;
}

Map<String, dynamic> _$MemberManagerHttpBeenToJson(
        MemberManagerHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'limit': instance.limit,
      'page': instance.page,
    };
