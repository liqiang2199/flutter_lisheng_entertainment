
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'TeamOverviewDataBeen.dart';
part 'TeamOverviewBeen.g.dart';

@JsonSerializable()
class TeamOverviewBeen extends BaseJson {

  TeamOverviewDataBeen data;

  TeamOverviewBeen(this.data);

  factory TeamOverviewBeen.fromJson(Map<String, dynamic> json) => _$TeamOverviewBeenFromJson(json);
}