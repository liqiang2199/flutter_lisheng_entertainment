import 'package:json_annotation/json_annotation.dart';
part 'MemberManagerDataListBeen.g.dart';

@JsonSerializable()
class MemberManagerDataListBeen {

  int id;
  String avatar;
  String is_dali;
  String username;
  String account;
  int level;
  int user_id;
  String status;
  String all_subsidy_money;
  String all_money;
  String ratio;
  String login_time;
  String login_ip;
  String createtime;
  String updatetime;
  String level_name;

  MemberManagerDataListBeen(this.id, this.avatar, this.is_dali, this.username,
      this.account, this.level, this.user_id, this.status,
      this.all_subsidy_money, this.all_money, this.ratio, this.login_time,
      this.login_ip, this.createtime, this.updatetime, this.level_name);
  factory MemberManagerDataListBeen.fromJson(Map<String, dynamic> json) => _$MemberManagerDataListBeenFromJson(json);

}