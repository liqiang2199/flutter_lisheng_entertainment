import 'package:json_annotation/json_annotation.dart';
part 'TeamAccountChangeHttpBeen.g.dart';
/// 团队账变
@JsonSerializable()
class TeamAccountChangeHttpBeen {

  String token;
  String username;
  String limit;
  String page;
  String type;
  String start_date;
  String end_date;

  TeamAccountChangeHttpBeen();

  factory TeamAccountChangeHttpBeen.fromJson(Map<String, dynamic> json) => _$TeamAccountChangeHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$TeamAccountChangeHttpBeenToJson(this);

}