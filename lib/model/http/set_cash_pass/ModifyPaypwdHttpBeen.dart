import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/base/BaseHttpBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ModifyPaypwdHttpBeen.g.dart';
/// 设置密码
@JsonSerializable()
class ModifyPaypwdHttpBeen extends BaseHttpBeen{
  String token;
  String new_paypwd;
  String old_paypwd;

  ModifyPaypwdHttpBeen(this.new_paypwd, this.old_paypwd, this.token);

  factory ModifyPaypwdHttpBeen.fromJson(Map<String, dynamic> json) => _$ModifyPaypwdHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$ModifyPaypwdHttpBeenToJson(this);
}