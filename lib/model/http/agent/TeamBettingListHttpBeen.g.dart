// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamBettingListHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamBettingListHttpBeen _$TeamBettingListHttpBeenFromJson(
    Map<String, dynamic> json) {
  return TeamBettingListHttpBeen(
    json['token'] as String,
    json['username'] as String,
    json['limit'] as String,
    json['page'] as String,
    json['lottery_id'] as String,
    json['status'] as String,
    json['pre_draw_issue'] as String,
    json['kj_time'] as String,
  )
    ..start_date = json['start_date'] as String
    ..end_date = json['end_date'] as String;
}

Map<String, dynamic> _$TeamBettingListHttpBeenToJson(
        TeamBettingListHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'limit': instance.limit,
      'page': instance.page,
      'lottery_id': instance.lottery_id,
      'status': instance.status,
      'pre_draw_issue': instance.pre_draw_issue,
      'kj_time': instance.kj_time,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
    };
