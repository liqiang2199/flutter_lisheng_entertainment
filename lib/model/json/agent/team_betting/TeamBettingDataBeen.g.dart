// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamBettingDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamBettingDataBeen _$TeamBettingDataBeenFromJson(Map<String, dynamic> json) {
  return TeamBettingDataBeen(
    json['count'] as int,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TeamBettingDataListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TeamBettingDataBeenToJson(
        TeamBettingDataBeen instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };
