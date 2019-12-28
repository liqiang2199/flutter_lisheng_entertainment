import 'package:json_annotation/json_annotation.dart';
part "UserAccountChangeRecordHttpBeen.g.dart";

/**
 * 账变记录 网络请求Been
 */
///
@JsonSerializable()
class UserAccountChangeRecordHttpBeen {
  String token;
  String type;///1=充值,2=提现,3=彩票游戏,4=活动,5=转账,6=资金修正,7=返点,8=团队分红,9=浮动工资 0为全部）
  String limit;
  String start_date;
  String end_date;
  int page;

  UserAccountChangeRecordHttpBeen(this.token, this.type, this.limit,
      this.start_date, this.end_date, this.page);
  factory UserAccountChangeRecordHttpBeen.fromJson(Map<String, dynamic> json) => _$UserAccountChangeRecordHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountChangeRecordHttpBeenToJson(this);

}