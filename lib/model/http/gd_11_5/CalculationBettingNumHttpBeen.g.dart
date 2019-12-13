// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalculationBettingNumHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculationBettingNumHttpBeen _$CalculationBettingNumHttpBeenFromJson(
    Map<String, dynamic> json) {
  return CalculationBettingNumHttpBeen(
    json['token'] as String,
    json['play_id'] as String,
  )
    ..one_num = json['one_num'] as String
    ..two_num = json['two_num'] as String
    ..three_num = json['three_num'] as String
    ..data_num = json['data_num'] as String
    ..multiple = json['multiple'] as int;
}

Map<String, dynamic> _$CalculationBettingNumHttpBeenToJson(
        CalculationBettingNumHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'play_id': instance.play_id,
      'one_num': instance.one_num,
      'two_num': instance.two_num,
      'three_num': instance.three_num,
      'data_num': instance.data_num,
      'multiple': instance.multiple,
    };
