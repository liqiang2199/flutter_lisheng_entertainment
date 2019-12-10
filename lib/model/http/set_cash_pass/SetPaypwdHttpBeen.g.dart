// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SetPaypwdHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetPaypwdHttpBeen _$SetPaypwdHttpBeenFromJson(Map<String, dynamic> json) {
  return SetPaypwdHttpBeen(
    json['new_paypwd'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$SetPaypwdHttpBeenToJson(SetPaypwdHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'new_paypwd': instance.new_paypwd,
    };
