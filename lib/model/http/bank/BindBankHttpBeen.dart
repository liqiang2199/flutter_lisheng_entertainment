import 'package:flutter_lisheng_entertainment/model/http/base/BaseHttpBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'BindBankHttpBeen.g.dart';
/// 绑定银行卡
@JsonSerializable()
class BindBankHttpBeen extends BaseHttpBeen{

  String token;
  String banktype_id;
  String realname;
  String card_number;
  String branch_name;
  String capital_pwd;

  BindBankHttpBeen(this.token, this.banktype_id, this.realname,
      this.card_number, this.branch_name, this.capital_pwd);

  factory BindBankHttpBeen.fromJson(Map<String, dynamic> json) => _$BindBankHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$BindBankHttpBeenToJson(this);

}