

import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'DragonTigerDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'DragonTigerBeen.g.dart';

@JsonSerializable()
class DragonTigerBeen  extends BaseJson{
  List<DragonTigerDataBeen> data;

  DragonTigerBeen(this.data);

  factory DragonTigerBeen.fromJson(Map<String, dynamic> json) => _$DragonTigerBeenFromJson(json);
}