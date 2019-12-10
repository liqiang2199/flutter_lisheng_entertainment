// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBannerDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannerDataBeen _$GetBannerDataBeenFromJson(Map<String, dynamic> json) {
  return GetBannerDataBeen(
    json['id'] as int,
    json['image'] as String,
    json['title'] as String,
    json['url'] as String,
    json['weigh'] as int,
  );
}

Map<String, dynamic> _$GetBannerDataBeenToJson(GetBannerDataBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'url': instance.url,
      'weigh': instance.weigh,
    };
