import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'JsonBeen.g.dart';

@JsonSerializable()
class JsonBeen extends BaseJson {

  JsonBeen();
  factory JsonBeen.fromJson(Map<String, dynamic> json) => _$JsonBeenFromJson(json);
}