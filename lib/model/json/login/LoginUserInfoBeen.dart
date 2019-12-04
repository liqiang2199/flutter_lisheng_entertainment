
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'LoginUserInfoBeen.g.dart';

@JsonSerializable()
class LoginUserInfoBeen {

  int id;
  String avatar;
  String is_dali;
  String username;
  String account;
  int level;
  String status;
  String pay_pwd;
  String pwd;
  int user_id;
  String all_money;
  String ratio;
  int login_time;
  String login_ip;
  int createtime;
  int updatetime;

  LoginUserInfoBeen(this.id, this.avatar, this.is_dali, this.username,
      this.account, this.level, this.status, this.pay_pwd, this.pwd,
      this.user_id, this.all_money, this.ratio, this.login_time, this.login_ip,
      this.createtime, this.updatetime);


  factory LoginUserInfoBeen.fromJson(Map<String, dynamic> json) => _$LoginUserInfoBeenFromJson(json);
}
