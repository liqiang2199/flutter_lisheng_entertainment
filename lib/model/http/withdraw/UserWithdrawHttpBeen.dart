import 'package:json_annotation/json_annotation.dart';
part "UserWithdrawHttpBeen.g.dart";

/**
 * 提现申请
 */
///
@JsonSerializable()
class UserWithdrawHttpBeen {
  String token;
  String money;
  String bank_id;
  String pay_pwd;

  UserWithdrawHttpBeen(this.token, this.money, this.bank_id, this.pay_pwd);

  factory UserWithdrawHttpBeen.fromJson(Map<String, dynamic> json) => _$UserWithdrawHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$UserWithdrawHttpBeenToJson(this);

}