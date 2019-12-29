import 'package:json_annotation/json_annotation.dart';

import 'UserWithdrawRecordDataListBeen.dart';
part 'UserWithdrawRecordDataBeen.g.dart';

@JsonSerializable()
class UserWithdrawRecordDataBeen {

  int count;
  List<UserWithdrawRecordDataListBeen> data;

  UserWithdrawRecordDataBeen(this.count, this.data);
  factory UserWithdrawRecordDataBeen.fromJson(Map<String, dynamic> json) => _$UserWithdrawRecordDataBeenFromJson(json);

}