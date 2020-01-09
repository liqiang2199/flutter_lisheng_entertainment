
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'UserReportDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserReportBeen.g.dart';

@JsonSerializable()
class UserReportBeen extends BaseJson{

  UserReportDataBeen data;

  UserReportBeen(this.data);

  factory UserReportBeen.fromJson(Map<String, dynamic> json) => _$UserReportBeenFromJson(json);

}