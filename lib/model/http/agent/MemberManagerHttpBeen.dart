import 'package:json_annotation/json_annotation.dart';
part 'MemberManagerHttpBeen.g.dart';
/// 会员管理
@JsonSerializable()
class MemberManagerHttpBeen {
  String token;
  String username;
  String limit;
  String page;

  MemberManagerHttpBeen();
  factory MemberManagerHttpBeen.fromJson(Map<String, dynamic> json) => _$MemberManagerHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$MemberManagerHttpBeenToJson(this);

}