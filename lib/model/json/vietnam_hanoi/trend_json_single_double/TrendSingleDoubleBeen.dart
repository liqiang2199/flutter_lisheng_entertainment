
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TrendSingleDoubleDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TrendSingleDoubleBeen.g.dart';

@JsonSerializable()
class TrendSingleDoubleBeen extends BaseJson {

  List<TrendSingleDoubleDataBeen> data;

  TrendSingleDoubleBeen(this.data);

  factory TrendSingleDoubleBeen.fromJson(Map<String, dynamic> json) => _$TrendSingleDoubleBeenFromJson(json);
}