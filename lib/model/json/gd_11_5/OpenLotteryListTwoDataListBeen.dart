import 'package:json_annotation/json_annotation.dart';

part 'OpenLotteryListTwoDataListBeen.g.dart';

@JsonSerializable()
class OpenLotteryListTwoDataListBeen {

  int id;
  int lottery_id;
  String pre_draw_issue;
  String is_jiesuan;
  String pre_draw_time;
  String pre_draw_code;
  int createtime;
  String drawTime;
  int drawIssue;//开奖期数
  String play;// 河内一分彩

  OpenLotteryListTwoDataListBeen(this.id, this.lottery_id, this.pre_draw_issue,
      this.is_jiesuan, this.pre_draw_time, this.pre_draw_code, this.createtime);

  factory OpenLotteryListTwoDataListBeen.fromJson(Map<String, dynamic> json) => _$OpenLotteryListTwoDataListBeenFromJson(json);
}