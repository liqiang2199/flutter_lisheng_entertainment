

import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'AgencyBonusDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AgencyBonusBeen.g.dart';

@JsonSerializable()
class AgencyBonusBeen extends BaseJson {
  AgencyBonusDataBeen data;

  AgencyBonusBeen(this.data);

  factory AgencyBonusBeen.fromJson(Map<String, dynamic> json) => _$AgencyBonusBeenFromJson(json);
}