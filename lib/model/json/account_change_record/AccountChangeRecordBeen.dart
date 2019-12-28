
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'AccountChangeRecordDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AccountChangeRecordBeen.g.dart';

@JsonSerializable()
class AccountChangeRecordBeen  extends BaseJson{

  AccountChangeRecordDataBeen data;

  AccountChangeRecordBeen(this.data);
  factory AccountChangeRecordBeen.fromJson(Map<String, dynamic> json) => _$AccountChangeRecordBeenFromJson(json);

}