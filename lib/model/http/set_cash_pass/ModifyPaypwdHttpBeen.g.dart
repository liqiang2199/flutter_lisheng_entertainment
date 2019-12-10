// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModifyPaypwdHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModifyPaypwdHttpBeen _$ModifyPaypwdHttpBeenFromJson(Map<String, dynamic> json) {
  return ModifyPaypwdHttpBeen(
    json['new_paypwd'] as String,
    json['old_paypwd'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$ModifyPaypwdHttpBeenToJson(
        ModifyPaypwdHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'new_paypwd': instance.new_paypwd,
      'old_paypwd': instance.old_paypwd,
    };
