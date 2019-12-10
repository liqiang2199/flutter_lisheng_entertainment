// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBannerListDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannerListDataBeen _$GetBannerListDataBeenFromJson(
    Map<String, dynamic> json) {
  return GetBannerListDataBeen(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GetBannerDataBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..time = json['time'];
}

Map<String, dynamic> _$GetBannerListDataBeenToJson(
        GetBannerListDataBeen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
    };
