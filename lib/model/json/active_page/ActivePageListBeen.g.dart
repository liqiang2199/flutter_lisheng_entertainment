// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivePageListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivePageListBeen _$ActivePageListBeenFromJson(Map<String, dynamic> json) {
  return ActivePageListBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ActivePageDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$ActivePageListBeenToJson(ActivePageListBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
