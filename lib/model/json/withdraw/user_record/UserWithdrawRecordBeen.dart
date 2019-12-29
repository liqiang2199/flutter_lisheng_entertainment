
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'UserWithdrawRecordDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserWithdrawRecordBeen.g.dart';

@JsonSerializable()
class UserWithdrawRecordBeen extends BaseJson {

  UserWithdrawRecordDataBeen data;

  UserWithdrawRecordBeen(this.data);
  factory UserWithdrawRecordBeen.fromJson(Map<String, dynamic> json) => _$UserWithdrawRecordBeenFromJson(json);

}