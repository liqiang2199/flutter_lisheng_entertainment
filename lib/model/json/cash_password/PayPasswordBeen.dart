
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PayPasswordBeen.g.dart';

@JsonSerializable()
class PayPasswordBeen extends BaseJson {
  PayPasswordBeen();
  factory PayPasswordBeen.fromJson(Map<String, dynamic> json) => _$PayPasswordBeenFromJson(json);

}