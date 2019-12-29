import 'package:json_annotation/json_annotation.dart';
part 'UserWithdrawRecordDataListBeen.g.dart';

@JsonSerializable()
class UserWithdrawRecordDataListBeen {

  int id;
  int user_id;
  int bank_id;
  String money;
  String service_money;
  String status;
  String remark;
  String createtime;
  String updatetime;
  String realname;
  String card_number;
  String branch_name;
  String name;

  UserWithdrawRecordDataListBeen();
  factory UserWithdrawRecordDataListBeen.fromJson(Map<String, dynamic> json) => _$UserWithdrawRecordDataListBeenFromJson(json);

}