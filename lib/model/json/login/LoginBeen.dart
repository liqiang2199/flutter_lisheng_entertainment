
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'LoginDataBeen.dart';
part 'LoginBeen.g.dart';

@JsonSerializable()
class LoginBeen extends BaseJson {

  LoginDataBeen data;

  LoginBeen(this.data);

  factory LoginBeen.fromJson(Map<String, dynamic> json) => _$LoginBeenFromJson(json);

  @override
  String toString() {
    return 'data:token = ${data.token}';
  }

}