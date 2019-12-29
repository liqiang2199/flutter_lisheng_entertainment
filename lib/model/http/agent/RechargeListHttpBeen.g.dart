// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RechargeListHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RechargeListHttpBeen _$RechargeListHttpBeenFromJson(Map<String, dynamic> json) {
  return RechargeListHttpBeen(
    json['token'] as String,
    json['username'] as String,
    json['limit'] as String,
    json['page'] as String,
  )
    ..start_date = json['start_date'] as String
    ..end_date = json['end_date'] as String;
}

Map<String, dynamic> _$RechargeListHttpBeenToJson(
        RechargeListHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'limit': instance.limit,
      'page': instance.page,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
    };
