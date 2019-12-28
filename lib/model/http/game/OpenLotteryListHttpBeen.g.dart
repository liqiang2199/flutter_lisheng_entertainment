// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenLotteryListHttpBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenLotteryListHttpBeen _$OpenLotteryListHttpBeenFromJson(
    Map<String, dynamic> json) {
  return OpenLotteryListHttpBeen(
    json['token'] as String,
    json['lottery_id'] as String,
    json['limit'] as String,
    json['page'] as String,
  );
}

Map<String, dynamic> _$OpenLotteryListHttpBeenToJson(
        OpenLotteryListHttpBeen instance) =>
    <String, dynamic>{
      'token': instance.token,
      'lottery_id': instance.lottery_id,
      'limit': instance.limit,
      'page': instance.page,
    };
