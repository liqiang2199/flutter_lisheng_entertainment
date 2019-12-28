// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotteryTypeDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryTypeDataListBeen _$LotteryTypeDataListBeenFromJson(
    Map<String, dynamic> json) {
  return LotteryTypeDataListBeen(
    json['id'] as int,
    json['name'] as String,
    (json['lottery'] as List)
        ?.map((e) => e == null
            ? null
            : LotteryTypeDataListLotteryBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LotteryTypeDataListBeenToJson(
        LotteryTypeDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lottery': instance.lottery,
    };
