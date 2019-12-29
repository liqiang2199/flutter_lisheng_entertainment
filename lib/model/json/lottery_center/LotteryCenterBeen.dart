
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'LotteryCenterDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LotteryCenterBeen.g.dart';

@JsonSerializable()
class LotteryCenterBeen  extends BaseJson{

  List<LotteryCenterDataBeen> data;

  LotteryCenterBeen(this.data);

  factory LotteryCenterBeen.fromJson(Map<String, dynamic> json) => _$LotteryCenterBeenFromJson(json);
}