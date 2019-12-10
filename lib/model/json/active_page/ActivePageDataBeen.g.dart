// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivePageDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivePageDataBeen _$ActivePageDataBeenFromJson(Map<String, dynamic> json) {
  return ActivePageDataBeen(
    json['id'] as int,
    json['status'] as String,
    json['title'] as String,
    json['image'] as String,
    json['content'] as String,
    json['createtime'] as String,
    json['updatetime'] as String,
  );
}

Map<String, dynamic> _$ActivePageDataBeenToJson(ActivePageDataBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
      'image': instance.image,
      'content': instance.content,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
    };
