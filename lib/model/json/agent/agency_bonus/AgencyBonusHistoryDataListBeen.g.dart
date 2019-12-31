// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AgencyBonusHistoryDataListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyBonusHistoryDataListBeen _$AgencyBonusHistoryDataListBeenFromJson(
    Map<String, dynamic> json) {
  return AgencyBonusHistoryDataListBeen()
    ..id = json['id'] as int
    ..user_id = json['user_id'] as int
    ..cycle_id = json['cycle_id'] as int
    ..yxusernum = json['yxusernum'] as int
    ..num = json['num'] as int
    ..xzallmoney = json['xzallmoney'] as String
    ..zjallmoney = json['zjallmoney'] as String
    ..fdallmoney = json['fdallmoney'] as String
    ..moneytype = json['moneytype'] as String
    ..bili = json['bili'] as String
    ..money = json['money'] as String
    ..subsidy_money = json['subsidy_money'] as String
    ..bonus_money = json['bonus_money'] as String
    ..rmark = json['rmark'] as String
    ..status = json['status'] as String
    ..createtime = json['createtime'] as String
    ..startdate = json['startdate'] as String
    ..enddate = json['enddate'] as String
    ..cycle_status = json['cycle_status'] as String
    ..isOpenList = json['isOpenList'] as bool;
}

Map<String, dynamic> _$AgencyBonusHistoryDataListBeenToJson(
        AgencyBonusHistoryDataListBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'cycle_id': instance.cycle_id,
      'yxusernum': instance.yxusernum,
      'num': instance.num,
      'xzallmoney': instance.xzallmoney,
      'zjallmoney': instance.zjallmoney,
      'fdallmoney': instance.fdallmoney,
      'moneytype': instance.moneytype,
      'bili': instance.bili,
      'money': instance.money,
      'subsidy_money': instance.subsidy_money,
      'bonus_money': instance.bonus_money,
      'rmark': instance.rmark,
      'status': instance.status,
      'createtime': instance.createtime,
      'startdate': instance.startdate,
      'enddate': instance.enddate,
      'cycle_status': instance.cycle_status,
      'isOpenList': instance.isOpenList,
    };
