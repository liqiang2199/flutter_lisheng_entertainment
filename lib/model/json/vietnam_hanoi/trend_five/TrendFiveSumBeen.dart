
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TrendFiveSumDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TrendFiveSumBeen.g.dart';

@JsonSerializable()
class TrendFiveSumBeen extends BaseJson{

  List<TrendFiveSumDataBeen> data;

  TrendFiveSumBeen(this.data);
  factory TrendFiveSumBeen.fromJson(Map<String, dynamic> json) => _$TrendFiveSumBeenFromJson(json);
}