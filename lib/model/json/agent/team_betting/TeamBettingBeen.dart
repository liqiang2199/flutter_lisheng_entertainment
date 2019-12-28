
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TeamBettingDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamBettingBeen.g.dart';

@JsonSerializable()
class TeamBettingBeen extends BaseJson{
  TeamBettingDataBeen data;

  TeamBettingBeen(this.data);
  factory TeamBettingBeen.fromJson(Map<String, dynamic> json) => _$TeamBettingBeenFromJson(json);
}