import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'WithdrawListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'WithdrawListDataBeen.g.dart';

@JsonSerializable()
class WithdrawListDataBeen extends BaseJson{

  WithdrawListBeen data;

  WithdrawListDataBeen(this.data);
  factory WithdrawListDataBeen.fromJson(Map<String, dynamic> json) => _$WithdrawListDataBeenFromJson(json);

}