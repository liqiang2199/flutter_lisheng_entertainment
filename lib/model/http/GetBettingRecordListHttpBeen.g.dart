// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBettingRecordListHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBettingRecordListHttpBeen _$GetBettingRecordListHttpBeenFromJson(
    Map<String, dynamic> json) {
  return GetBettingRecordListHttpBeen()
    ..token = json['token'] as String
    ..username = json['username'] as String
    ..limit = json['limit'] as String
    ..lottery_id = json['lottery_id'] as String
    ..status = json['status'] as String
    ..stare_time = json['stare_time'] as String
    ..end_time = json['end_time'] as String
    ..page = json['page'] as String;
}

Map<String, dynamic> _$GetBettingRecordListHttpBeenToJson(
        GetBettingRecordListHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'limit': instance.limit,
      'lottery_id': instance.lottery_id,
      'status': instance.status,
      'stare_time': instance.stare_time,
      'end_time': instance.end_time,
      'page': instance.page,
    };
