// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AgencyBonusHistoryDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyBonusHistoryDataBeen _$AgencyBonusHistoryDataBeenFromJson(
    Map<String, dynamic> json) {
  return AgencyBonusHistoryDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AgencyBonusHistoryDataListBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  )..count = json['count'] as int;
}

Map<String, dynamic> _$AgencyBonusHistoryDataBeenToJson(
        AgencyBonusHistoryDataBeen instance) =>
    <String, dynamic>{
      'data': instance.data,
      'count': instance.count,
    };
