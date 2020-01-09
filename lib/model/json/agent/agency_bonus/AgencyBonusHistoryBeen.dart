

import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'package:json_annotation/json_annotation.dart';

import 'AgencyBonusHistoryDataBeen.dart';
part 'AgencyBonusHistoryBeen.g.dart';

@JsonSerializable()
class AgencyBonusHistoryBeen extends BaseJson {

  AgencyBonusHistoryDataBeen data;


  AgencyBonusHistoryBeen(this.data);

  factory AgencyBonusHistoryBeen.fromJson(Map<String, dynamic> json) => _$AgencyBonusHistoryBeenFromJson(json);
}