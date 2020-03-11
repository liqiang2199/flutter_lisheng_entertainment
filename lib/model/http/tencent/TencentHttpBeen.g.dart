// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TencentHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TencentHttpBeen _$TencentHttpBeenFromJson(Map<String, dynamic> json) {
  return TencentHttpBeen()
    ..token = json['token'] as String
    ..play_id = json['play_id'] as String
    ..one_num = json['one_num'] as String
    ..two_num = json['two_num'] as String
    ..three_num = json['three_num'] as String
    ..four_num = json['four_num'] as String
    ..five_num = json['five_num'] as String
    ..sum_type = json['sum_type'] as String
    ..data_num = json['data_num'] as String
    ..data_address = json['data_address'] as String
    ..double_num = json['double_num'] as String
    ..sc_num = json['sc_num'] as String
    ..multiple = json['multiple'] as int;
}

Map<String, dynamic> _$TencentHttpBeenToJson(TencentHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'play_id': instance.play_id,
      'one_num': instance.one_num,
      'two_num': instance.two_num,
      'three_num': instance.three_num,
      'four_num': instance.four_num,
      'five_num': instance.five_num,
      'sum_type': instance.sum_type,
      'data_num': instance.data_num,
      'data_address': instance.data_address,
      'double_num': instance.double_num,
      'sc_num': instance.sc_num,
      'multiple': instance.multiple,
    };
