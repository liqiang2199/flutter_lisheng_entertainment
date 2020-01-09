
///个人报表
import 'package:json_annotation/json_annotation.dart';
part "UserReportHttpBeen.g.dart";

@JsonSerializable()
class UserReportHttpBeen {

  String token;
  String start_date;
  String end_date;

  UserReportHttpBeen();

  factory UserReportHttpBeen.fromJson(Map<String, dynamic> json) => _$UserReportHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$UserReportHttpBeenToJson(this);
}