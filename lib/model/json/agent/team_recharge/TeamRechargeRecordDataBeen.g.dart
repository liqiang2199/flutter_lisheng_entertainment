// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamRechargeRecordDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRechargeRecordDataBeen _$TeamRechargeRecordDataBeenFromJson(
    Map<String, dynamic> json) {
  return TeamRechargeRecordDataBeen(
    (json['userlist'] as List)
        ?.map((e) => e == null
            ? null
            : TeamRechargeRecordDataListBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$TeamRechargeRecordDataBeenToJson(
        TeamRechargeRecordDataBeen instance) =>
    <String, dynamic>{
      'userlist': instance.userlist,
      'count': instance.count,
    };
