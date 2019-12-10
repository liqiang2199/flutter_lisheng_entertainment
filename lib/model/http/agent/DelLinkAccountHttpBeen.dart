import 'package:json_annotation/json_annotation.dart';
part 'DelLinkAccountHttpBeen.g.dart';

@JsonSerializable()
class DelLinkAccountHttpBeen {
  String token;
  String id;

  DelLinkAccountHttpBeen(this.token, this.id);
  factory DelLinkAccountHttpBeen.fromJson(Map<String, dynamic> json) => _$DelLinkAccountHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$DelLinkAccountHttpBeenToJson(this);

}