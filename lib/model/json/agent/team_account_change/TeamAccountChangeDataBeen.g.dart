// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamAccountChangeDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAccountChangeDataBeen _$TeamAccountChangeDataBeenFromJson(
    Map<String, dynamic> json) {
  return TeamAccountChangeDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TeamAccountChangeDataListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$TeamAccountChangeDataBeenToJson(
        TeamAccountChangeDataBeen instance) =>
    <String, dynamic>{
      'data': instance.data,
      'count': instance.count,
    };
