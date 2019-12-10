
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'RechargeTypeDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'RechargeTypeListBeen.g.dart';

@JsonSerializable()
class RechargeTypeListBeen extends BaseJson{

  List<RechargeTypeDataBeen> data;

  RechargeTypeListBeen(this.data);

  factory RechargeTypeListBeen.fromJson(Map<String, dynamic> json) => _$RechargeTypeListBeenFromJson(json);

}