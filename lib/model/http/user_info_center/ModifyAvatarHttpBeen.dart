
import 'package:json_annotation/json_annotation.dart';
part 'ModifyAvatarHttpBeen.g.dart';

@JsonSerializable()
class ModifyAvatarHttpBeen {

  String token;
  String avatar;


  ModifyAvatarHttpBeen(this.token, this.avatar);

  factory ModifyAvatarHttpBeen.fromJson(Map<String, dynamic> json) => _$ModifyAvatarHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$ModifyAvatarHttpBeenToJson(this);
}