// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SystemNoticeDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemNoticeDataBeen _$SystemNoticeDataBeenFromJson(Map<String, dynamic> json) {
  return SystemNoticeDataBeen(
    json['id'] as int,
    json['status'] as String,
    json['title'] as String,
    json['content'] as String,
    json['createtime'] as String,
    json['updatetime'] as String,
  );
}

Map<String, dynamic> _$SystemNoticeDataBeenToJson(
        SystemNoticeDataBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
      'content': instance.content,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
    };
