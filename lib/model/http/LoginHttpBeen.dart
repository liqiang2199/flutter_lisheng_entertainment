import 'package:flutter_lisheng_entertainment/Util/JsonFormatUtil.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base/BaseHttpBeen.dart';

@JsonSerializable()
class LoginHttpBeen extends BaseHttpBeen{

  String account;
  String pwd;

  LoginHttpBeen({this.account, this.pwd});

  factory LoginHttpBeen.fromJson(Map<String, dynamic> json) => loginHttpJson(json);
  Map<String, dynamic> toJson() => loginJson(this);

}