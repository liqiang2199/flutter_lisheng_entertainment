// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBettingRecordDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBettingRecordDataListBeen _$GetBettingRecordDataListBeenFromJson(
    Map<String, dynamic> json) {
  return GetBettingRecordDataListBeen()
    ..id = json['id'] as int
    ..user_id = json['user_id'] as int
    ..lottery_id = json['lottery_id'] as int
    ..paly_id = json['paly_id'] as int
    ..multiple = json['multiple'] as int
    ..ordercode = json['ordercode'] as String
    ..jg_money = json['jg_money'] as String
    ..pre_draw_issue = json['pre_draw_issue'] as String
    ..xz_money = json['xz_money'] as String
    ..kj_time = json['kj_time'] as String
    ..remark = json['remark'] as String
    ..status = json['status'] as String
    ..createtime = json['createtime'] as String
    ..play = json['play'] as String
    ..kj_num = json['kj_num'] as String
    ..num = json['num'] as int
    ..lottery_name = json['lottery_name'] as String
    ..param = json['param'] == null
        ? null
        : GetBettingRecordDataListParamBeen.fromJson(
            json['param'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetBettingRecordDataListBeenToJson(
        GetBettingRecordDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'lottery_id': instance.lottery_id,
      'paly_id': instance.paly_id,
      'multiple': instance.multiple,
      'ordercode': instance.ordercode,
      'jg_money': instance.jg_money,
      'pre_draw_issue': instance.pre_draw_issue,
      'xz_money': instance.xz_money,
      'kj_time': instance.kj_time,
      'remark': instance.remark,
      'status': instance.status,
      'createtime': instance.createtime,
      'play': instance.play,
      'kj_num': instance.kj_num,
      'num': instance.num,
      'lottery_name': instance.lottery_name,
      'param': instance.param,
    };
