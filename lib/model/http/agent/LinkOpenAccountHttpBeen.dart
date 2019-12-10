
import 'package:json_annotation/json_annotation.dart';
part 'LinkOpenAccountHttpBeen.g.dart';

@JsonSerializable()
class LinkOpenAccountHttpBeen {

  String token;
  String is_dali;
  String day;
  String ratio;

  LinkOpenAccountHttpBeen(this.token, this.is_dali, this.day, this.ratio);
  factory LinkOpenAccountHttpBeen.fromJson(Map<String, dynamic> json) => _$LinkOpenAccountHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$LinkOpenAccountHttpBeenToJson(this);

}