// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendHanoiOneLotterySingleDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendHanoiOneLotterySingleDataBeen _$TrendHanoiOneLotterySingleDataBeenFromJson(
    Map<String, dynamic> json) {
  return TrendHanoiOneLotterySingleDataBeen(
    (json['re_data'] as List)
        ?.map((e) => e == null
            ? null
            : TrendHanoiOneLotterySingleReDataBeen.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TrendHanoiOneLotterySingleDataBeenToJson(
        TrendHanoiOneLotterySingleDataBeen instance) =>
    <String, dynamic>{
      're_data': instance.re_data,
    };
