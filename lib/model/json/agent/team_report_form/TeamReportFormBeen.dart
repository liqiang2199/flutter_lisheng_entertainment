
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TeamReportFormDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamReportFormBeen.g.dart';

@JsonSerializable()
class TeamReportFormBeen  extends BaseJson{

  TeamReportFormDataBeen data;

  TeamReportFormBeen(this.data);
  factory TeamReportFormBeen.fromJson(Map<String, dynamic> json) => _$TeamReportFormBeenFromJson(json);

}