// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamBettingDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamBettingDataListBeen _$TeamBettingDataListBeenFromJson(
    Map<String, dynamic> json) {
  return TeamBettingDataListBeen()
    ..id = json['id'] as int
    ..user_id = json['user_id'] as int
    ..lottery_id = json['lottery_id'] as int
    ..paly_id = json['paly_id'] as int
    ..ordercode = json['ordercode'] as String
    ..pre_draw_issue = json['pre_draw_issue'] as String
    ..jg_money = json['jg_money'] as String
    ..xz_money = json['xz_money'] as String
    ..multiple = json['multiple'] as int
    ..kj_time = json['kj_time'] as String
    ..remark = json['remark'] as String
    ..status = json['status'] as String
    ..createtime = json['createtime'] as String
    ..username = json['username'] as String
    ..play = json['play'] as String;
}

Map<String, dynamic> _$TeamBettingDataListBeenToJson(
        TeamBettingDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'lottery_id': instance.lottery_id,
      'paly_id': instance.paly_id,
      'ordercode': instance.ordercode,
      'pre_draw_issue': instance.pre_draw_issue,
      'jg_money': instance.jg_money,
      'xz_money': instance.xz_money,
      'multiple': instance.multiple,
      'kj_time': instance.kj_time,
      'remark': instance.remark,
      'status': instance.status,
      'createtime': instance.createtime,
      'username': instance.username,
      'play': instance.play,
    };
