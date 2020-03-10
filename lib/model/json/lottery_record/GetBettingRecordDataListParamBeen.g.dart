// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBettingRecordDataListParamBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBettingRecordDataListParamBeen _$GetBettingRecordDataListParamBeenFromJson(
    Map<String, dynamic> json) {
  return GetBettingRecordDataListParamBeen(
    json['one_num'] as String,
    json['two_num'] as String,
    json['three_num'] as String,
    json['data_num'] as String,
  )
    ..four_num = json['four_num'] as String
    ..five_num = json['five_num'] as String;
}

Map<String, dynamic> _$GetBettingRecordDataListParamBeenToJson(
        GetBettingRecordDataListParamBeen instance) =>
    <String, dynamic>{
      'one_num': instance.one_num,
      'two_num': instance.two_num,
      'three_num': instance.three_num,
      'four_num': instance.four_num,
      'five_num': instance.five_num,
      'data_num': instance.data_num,
    };
