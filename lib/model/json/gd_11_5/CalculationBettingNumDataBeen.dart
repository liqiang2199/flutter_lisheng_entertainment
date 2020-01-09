
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'CalculationBettingNumDataBeen.g.dart';

@JsonSerializable()
class CalculationBettingNumDataBeen extends BaseJson {

  List<String> data_num;
  int count;
  String play_name;
  String money_award;
  String money;
  String fd;// 返点

  CalculationBettingNumDataBeen(this.data_num, this.count, this.play_name,
      this.money_award, this.money);

  factory CalculationBettingNumDataBeen.fromJson(Map<String, dynamic> json) => _$CalculationBettingNumDataBeenFromJson(json);

}