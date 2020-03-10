
///订单撤销
import 'package:json_annotation/json_annotation.dart';
part 'DelOrderHttpBeen.g.dart';

@JsonSerializable()
class DelOrderHttpBeen {
  String token;
  String id;

  DelOrderHttpBeen();
  factory DelOrderHttpBeen.fromJson(Map<String, dynamic> json) => _$DelOrderHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$DelOrderHttpBeenToJson(this);
}