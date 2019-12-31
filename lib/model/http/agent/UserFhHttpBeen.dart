import 'package:json_annotation/json_annotation.dart';
part 'UserFhHttpBeen.g.dart';
/// 历史分红
@JsonSerializable()
class UserFhHttpBeen {
  String token;
  String limit;
  String page;

  UserFhHttpBeen(this.token, this.limit, this.page);

  factory UserFhHttpBeen.fromJson(Map<String, dynamic> json) => _$UserFhHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$UserFhHttpBeenToJson(this);

}