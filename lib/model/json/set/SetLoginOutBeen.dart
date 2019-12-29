
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SetLoginOutBeen.g.dart';

@JsonSerializable()
class SetLoginOutBeen extends BaseJson{


  SetLoginOutBeen();

  factory SetLoginOutBeen.fromJson(Map<String, dynamic> json) => _$SetLoginOutBeenFromJson(json);
}