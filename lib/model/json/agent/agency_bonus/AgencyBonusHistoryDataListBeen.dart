import 'package:json_annotation/json_annotation.dart';

part 'AgencyBonusHistoryDataListBeen.g.dart';

@JsonSerializable()
class AgencyBonusHistoryDataListBeen {

  int id;
  int user_id;
  int cycle_id;
  int yxusernum;
  int num;
  String xzallmoney;
  String zjallmoney;
  String fdallmoney;
  String moneytype;
  String bili;
  String money;
  String subsidy_money;
  String bonus_money;
  String rmark;
  String status;
  String createtime;
  String startdate;
  String enddate;
  String cycle_status;
  bool isOpenList;

  AgencyBonusHistoryDataListBeen();
  factory AgencyBonusHistoryDataListBeen.fromJson(Map<String, dynamic> json) => _$AgencyBonusHistoryDataListBeenFromJson(json);

}