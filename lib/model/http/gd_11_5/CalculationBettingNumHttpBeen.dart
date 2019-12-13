/**
 * 广东11 选5 的计算注数
 */
import 'package:json_annotation/json_annotation.dart';
part 'CalculationBettingNumHttpBeen.g.dart';

@JsonSerializable()
class CalculationBettingNumHttpBeen{
  String token;
  String play_id;

  /// 三码/前三直选/复式（计算注数）
  String one_num;
  String two_num;
  String three_num;

  /// 三码/前三组合/复式（计算注数）(任选， 定胆位 不定胆位)
  String data_num;

  /// 下注接口 （计算注数）
  int multiple;

  CalculationBettingNumHttpBeen(this.token, this.play_id);

  factory CalculationBettingNumHttpBeen.fromJson(Map<String, dynamic> json) => _$CalculationBettingNumHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$CalculationBettingNumHttpBeenToJson(this);


}