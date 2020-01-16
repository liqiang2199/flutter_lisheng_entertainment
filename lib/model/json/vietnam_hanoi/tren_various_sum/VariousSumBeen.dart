import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'VariousSumDataBeen.dart';
part 'VariousSumBeen.g.dart';

@JsonSerializable()
class VariousSumBeen extends BaseJson{

  List<VariousSumDataBeen> data;

  VariousSumBeen(this.data);
  factory VariousSumBeen.fromJson(Map<String, dynamic> json) => _$VariousSumBeenFromJson(json);

}