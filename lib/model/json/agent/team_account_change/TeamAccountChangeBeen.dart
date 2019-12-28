
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TeamAccountChangeDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamAccountChangeBeen.g.dart';

@JsonSerializable()
class TeamAccountChangeBeen extends BaseJson{

  TeamAccountChangeDataBeen data;

  TeamAccountChangeBeen();

  factory TeamAccountChangeBeen.fromJson(Map<String, dynamic> json) => _$TeamAccountChangeBeenFromJson(json);
}