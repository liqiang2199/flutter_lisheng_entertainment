// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserAccountChangeRecordHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountChangeRecordHttpBeen _$UserAccountChangeRecordHttpBeenFromJson(
    Map<String, dynamic> json) {
  return UserAccountChangeRecordHttpBeen(
    json['token'] as String,
    json['type'] as String,
    json['limit'] as String,
    json['start_date'] as String,
    json['end_date'] as String,
    json['page'] as int,
  );
}

Map<String, dynamic> _$UserAccountChangeRecordHttpBeenToJson(
        UserAccountChangeRecordHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'limit': instance.limit,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'page': instance.page,
    };
