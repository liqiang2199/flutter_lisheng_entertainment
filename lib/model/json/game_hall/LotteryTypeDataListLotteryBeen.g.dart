// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotteryTypeDataListLotteryBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryTypeDataListLotteryBeen _$LotteryTypeDataListLotteryBeenFromJson(
    Map<String, dynamic> json) {
  return LotteryTypeDataListLotteryBeen(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String,
  )..isChoice = json['isChoice'] as bool;
}

Map<String, dynamic> _$LotteryTypeDataListLotteryBeenToJson(
        LotteryTypeDataListLotteryBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'isChoice': instance.isChoice,
    };
