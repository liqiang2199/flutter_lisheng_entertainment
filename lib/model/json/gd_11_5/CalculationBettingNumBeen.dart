
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'CalculationBettingNumDataBeen.dart';
part 'CalculationBettingNumBeen.g.dart';

@JsonSerializable()
class CalculationBettingNumBeen extends BaseJson {

  CalculationBettingNumDataBeen data;

  CalculationBettingNumBeen(this.data);

  factory CalculationBettingNumBeen.fromJson(Map<String, dynamic> json) => _$CalculationBettingNumBeenFromJson(json);


}