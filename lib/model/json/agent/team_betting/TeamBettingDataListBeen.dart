import 'package:json_annotation/json_annotation.dart';
part 'TeamBettingDataListBeen.g.dart';

@JsonSerializable()
class TeamBettingDataListBeen {
  int id;
  int user_id;
  int lottery_id;
  int paly_id;
  String ordercode;
  String pre_draw_issue;
  String jg_money;
  String xz_money;
  int multiple;
  String kj_time;
  String remark;
  String status;
  String createtime;
  String username;
  String play;

  TeamBettingDataListBeen();

  factory TeamBettingDataListBeen.fromJson(Map<String, dynamic> json) => _$TeamBettingDataListBeenFromJson(json);

}