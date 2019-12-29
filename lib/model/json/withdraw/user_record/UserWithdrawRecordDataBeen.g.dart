// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWithdrawRecordDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithdrawRecordDataBeen _$UserWithdrawRecordDataBeenFromJson(
    Map<String, dynamic> json) {
  return UserWithdrawRecordDataBeen(
    json['count'] as int,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : UserWithdrawRecordDataListBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserWithdrawRecordDataBeenToJson(
        UserWithdrawRecordDataBeen instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };
