
import 'package:json_annotation/json_annotation.dart';

part 'CpOpenLotteryInfoBeen.g.dart';

@JsonSerializable()
class CpOpenLotteryInfoBeen{

  String name;
  int id;
  String frequency;
  int preDrawIssue;
  String preDrawTime;
  String preDrawCode;
  int drawIssue;
  String drawTime;
  String serverTime;

  CpOpenLotteryInfoBeen(this.name, this.id, this.frequency, this.preDrawIssue,
      this.preDrawTime, this.preDrawCode, this.drawIssue, this.drawTime,
      this.serverTime);

  factory CpOpenLotteryInfoBeen.fromJson(Map<String, dynamic> json) => _$CpOpenLotteryInfoBeenFromJson(json);

}