/**
 * 开奖列表
 */
import 'package:json_annotation/json_annotation.dart';
part 'OpenLotteryListHttpBeen.g.dart';

@JsonSerializable()
class OpenLotteryListHttpBeen {

  String token;
  String lottery_id;
  String limit;
  String page;

  OpenLotteryListHttpBeen(this.token, this.lottery_id, this.limit, this.page);

  factory OpenLotteryListHttpBeen.fromJson(Map<String, dynamic> json) => _$OpenLotteryListHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$OpenLotteryListHttpBeenToJson(this);


}