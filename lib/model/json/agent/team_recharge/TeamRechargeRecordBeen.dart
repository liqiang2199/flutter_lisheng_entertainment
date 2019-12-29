
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TeamRechargeRecordDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamRechargeRecordBeen.g.dart';

@JsonSerializable()
class TeamRechargeRecordBeen extends BaseJson{

  TeamRechargeRecordDataBeen data;

  TeamRechargeRecordBeen(this.data);

  factory TeamRechargeRecordBeen.fromJson(Map<String, dynamic> json) => _$TeamRechargeRecordBeenFromJson(json);

}