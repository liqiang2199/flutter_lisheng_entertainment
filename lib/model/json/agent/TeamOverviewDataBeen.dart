
import 'package:json_annotation/json_annotation.dart';
part 'TeamOverviewDataBeen.g.dart';

@JsonSerializable()
class TeamOverviewDataBeen  {

  String teamAllMoney;
  int userCount;
  int onlineUserCount;
  String teamCzMoney;
  String teamTxMoney;
  String teamXzMoney;
  String teamZjMoney;

  TeamOverviewDataBeen(this.teamAllMoney, this.userCount, this.onlineUserCount,
      this.teamCzMoney, this.teamTxMoney, this.teamXzMoney, this.teamZjMoney);


  factory TeamOverviewDataBeen.fromJson(Map<String, dynamic> json) => _$TeamOverviewDataBeenFromJson(json);

}