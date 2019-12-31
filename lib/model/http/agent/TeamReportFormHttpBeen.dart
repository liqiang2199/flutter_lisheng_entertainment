import 'package:json_annotation/json_annotation.dart';
part 'TeamReportFormHttpBeen.g.dart';
/// 团队列表
@JsonSerializable()
class TeamReportFormHttpBeen {

  String token;
  String user_id;
  String username;
  String limit;
  String page;

  TeamReportFormHttpBeen();

  factory TeamReportFormHttpBeen.fromJson(Map<String, dynamic> json) => _$TeamReportFormHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$TeamReportFormHttpBeenToJson(this);

}