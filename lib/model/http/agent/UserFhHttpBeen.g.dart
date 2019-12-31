// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserFhHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFhHttpBeen _$UserFhHttpBeenFromJson(Map<String, dynamic> json) {
  return UserFhHttpBeen(
    json['token'] as String,
    json['limit'] as String,
    json['page'] as String,
  );
}

Map<String, dynamic> _$UserFhHttpBeenToJson(UserFhHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'limit': instance.limit,
      'page': instance.page,
    };
