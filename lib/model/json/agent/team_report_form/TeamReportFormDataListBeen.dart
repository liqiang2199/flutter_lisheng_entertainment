import 'package:json_annotation/json_annotation.dart';
part 'TeamReportFormDataListBeen.g.dart';

@JsonSerializable()
class TeamReportFormDataListBeen {

  int id;
  int level;
  int user_id;
  String is_dali;
  String username;
  String status;
  String all_money;
  int userNum;
  String czMoney;
  String tcMoney;
  String tzMoney;
  String jgMoney;
  String fdMoney;
  String hdMoney;
  String ykMoney;

  TeamReportFormDataListBeen(this.id, this.level, this.user_id, this.is_dali,
      this.username, this.status, this.all_money, this.userNum, this.czMoney,
      this.tcMoney, this.tzMoney, this.jgMoney, this.fdMoney, this.hdMoney,
      this.ykMoney);

  factory TeamReportFormDataListBeen.fromJson(Map<String, dynamic> json) => _$TeamReportFormDataListBeenFromJson(json);


}