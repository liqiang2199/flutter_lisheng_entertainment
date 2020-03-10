
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'OpenAccountIntervalDataBeen.dart';

import 'package:json_annotation/json_annotation.dart';
part 'OpenAccountIntervalBeen.g.dart';

@JsonSerializable()
class OpenAccountIntervalBeen extends BaseJson {
  OpenAccountIntervalDataBeen data;

  OpenAccountIntervalBeen(this.data);

  factory OpenAccountIntervalBeen.fromJson(Map<String, dynamic> json) => _$OpenAccountIntervalBeenFromJson(json);

}