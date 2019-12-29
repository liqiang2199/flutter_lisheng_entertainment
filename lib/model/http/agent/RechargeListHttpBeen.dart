import 'package:json_annotation/json_annotation.dart';
part 'RechargeListHttpBeen.g.dart';
/// 团队充值记录
@JsonSerializable()
class RechargeListHttpBeen {

  String token;
  String username;
  String limit;
  String page;
  String start_date;
  String end_date;

  RechargeListHttpBeen(this.token, this.username, this.limit, this.page);

  factory RechargeListHttpBeen.fromJson(Map<String, dynamic> json) => _$RechargeListHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$RechargeListHttpBeenToJson(this);

}