// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenLotteryListTwoDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenLotteryListTwoDataBeen _$OpenLotteryListTwoDataBeenFromJson(
    Map<String, dynamic> json) {
  return OpenLotteryListTwoDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : OpenLotteryListTwoDataListBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OpenLotteryListTwoDataBeenToJson(
        OpenLotteryListTwoDataBeen instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
