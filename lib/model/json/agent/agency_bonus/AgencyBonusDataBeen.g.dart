// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AgencyBonusDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyBonusDataBeen _$AgencyBonusDataBeenFromJson(Map<String, dynamic> json) {
  return AgencyBonusDataBeen(
    json['yxUserNum'] as int,
    json['ykMoney'] as String,
    json['bonus_money'] as String,
    json['fhMoney'] as String,
  );
}

Map<String, dynamic> _$AgencyBonusDataBeenToJson(
        AgencyBonusDataBeen instance) =>
    <String, dynamic>{
      'yxUserNum': instance.yxUserNum,
      'ykMoney': instance.ykMoney,
      'bonus_money': instance.bonus_money,
      'fhMoney': instance.fhMoney,
    };
