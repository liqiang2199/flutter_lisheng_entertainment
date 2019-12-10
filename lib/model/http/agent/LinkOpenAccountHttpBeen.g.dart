// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LinkOpenAccountHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkOpenAccountHttpBeen _$LinkOpenAccountHttpBeenFromJson(
    Map<String, dynamic> json) {
  return LinkOpenAccountHttpBeen(
    json['token'] as String,
    json['is_dali'] as String,
    json['day'] as String,
    json['ratio'] as String,
  );
}

Map<String, dynamic> _$LinkOpenAccountHttpBeenToJson(
        LinkOpenAccountHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'is_dali': instance.is_dali,
      'day': instance.day,
      'ratio': instance.ratio,
    };
