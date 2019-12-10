import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/base/BaseHttpBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SetPaypwdHttpBeen.g.dart';
/// 设置密码
@JsonSerializable()
class SetPaypwdHttpBeen extends BaseHttpBeen{
  String token = SpUtil.getString(Constant.TOKEN);
  String new_paypwd;

  SetPaypwdHttpBeen(this.new_paypwd, this.token);

  factory SetPaypwdHttpBeen.fromJson(Map<String, dynamic> json) => _$SetPaypwdHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$SetPaypwdHttpBeenToJson(this);
}