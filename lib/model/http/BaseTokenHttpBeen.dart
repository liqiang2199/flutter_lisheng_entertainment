
import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:json_annotation/json_annotation.dart';
part 'BaseTokenHttpBeen.g.dart';

@JsonSerializable()
class BaseTokenHttpBeen {

  String token;

  BaseTokenHttpBeen(this.token);
  factory BaseTokenHttpBeen.fromJson(Map<String, dynamic> json) => _$BaseTokenHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$BaseTokenHttpBeenToJson(this);

}