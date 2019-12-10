
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'LinkOpenAccountBeen.g.dart';

@JsonSerializable()
class LinkOpenAccountBeen extends BaseJson{
  LinkOpenAccountBeen();
  factory LinkOpenAccountBeen.fromJson(Map<String, dynamic> json) => _$LinkOpenAccountBeenFromJson(json);
}