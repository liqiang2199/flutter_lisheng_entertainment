import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'LoginUserInfoBeen.dart';
part 'LoginDataBeen.g.dart';

@JsonSerializable()
class LoginDataBeen{

  String token;
  LoginUserInfoBeen userInfo;

  LoginDataBeen(this.token, this.userInfo);

  factory LoginDataBeen.fromJson(Map<String, dynamic> json) => _$LoginDataBeenFromJson(json);

  @override
  String toString() {
    return 'token:${this.token}';
  }


}