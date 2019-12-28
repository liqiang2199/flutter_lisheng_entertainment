// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountChangeRecordDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountChangeRecordDataBeen _$AccountChangeRecordDataBeenFromJson(
    Map<String, dynamic> json) {
  return AccountChangeRecordDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AccountChangeRecordDataListBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$AccountChangeRecordDataBeenToJson(
        AccountChangeRecordDataBeen instance) =>
    <String, dynamic>{
      'data': instance.data,
      'count': instance.count,
    };
