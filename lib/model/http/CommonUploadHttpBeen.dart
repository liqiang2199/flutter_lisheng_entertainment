
import 'package:json_annotation/json_annotation.dart';
part "CommonUploadHttpBeen.g.dart";

@JsonSerializable()
class CommonUploadHttpBeen {
  String file;

  CommonUploadHttpBeen(this.file);
  factory CommonUploadHttpBeen.fromJson(Map<String, dynamic> json) => _$CommonUploadHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$CommonUploadHttpBeenToJson(this);

}