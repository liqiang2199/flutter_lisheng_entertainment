
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'OrdinaryOpenAccountBeen.g.dart';

@JsonSerializable()
class OrdinaryOpenAccountBeen extends BaseJson {
  OrdinaryOpenAccountBeen();
  factory OrdinaryOpenAccountBeen.fromJson(Map<String, dynamic> json) => _$OrdinaryOpenAccountBeenFromJson(json);
}