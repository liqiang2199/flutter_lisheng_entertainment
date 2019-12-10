import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/base/BaseHttpBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserInfoCenterHttpBeen.g.dart';

@JsonSerializable()
class UserInfoCenterHttpBeen extends BaseHttpBeen{

  String token = SpUtil.getString(Constant.TOKEN);
  String new_pwd;
  String old_pwd;

  UserInfoCenterHttpBeen(this.new_pwd, this.old_pwd,this.token);

  factory UserInfoCenterHttpBeen.fromJson(Map<String, dynamic> json) => _$UserInfoCenterHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoCenterHttpBeenToJson(this);


}