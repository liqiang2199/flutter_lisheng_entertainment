// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWithdrawRecordHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithdrawRecordHttpBeen _$UserWithdrawRecordHttpBeenFromJson(
    Map<String, dynamic> json) {
  return UserWithdrawRecordHttpBeen(
    json['token'] as String,
    json['limit'] as String,
    json['status'] as String,
    json['start_date'] as String,
    json['end_date'] as String,
  )..page = json['page'] as int;
}

Map<String, dynamic> _$UserWithdrawRecordHttpBeenToJson(
        UserWithdrawRecordHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'limit': instance.limit,
      'page': instance.page,
      'status': instance.status,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
    };
