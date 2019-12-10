import 'package:json_annotation/json_annotation.dart';
part 'OrdinaryOpenAccountHttpBeen.g.dart';
/// 绑定银行卡
@JsonSerializable()
class OrdinaryOpenAccountHttpBeen {

  String is_dali;
  String account;
  String username;
  String pwd;
  String ratio;
  String token;

  OrdinaryOpenAccountHttpBeen(this.is_dali, this.account, this.username,
      this.pwd, this.ratio, this.token);


  factory OrdinaryOpenAccountHttpBeen.fromJson(Map<String, dynamic> json) => _$OrdinaryOpenAccountHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$OrdinaryOpenAccountHttpBeenToJson(this);

}