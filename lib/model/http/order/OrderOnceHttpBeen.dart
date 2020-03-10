
import 'package:json_annotation/json_annotation.dart';
part 'OrderOnceHttpBeen.g.dart';

@JsonSerializable()
class OrderOnceHttpBeen {
  String token;
  String order_id;

  OrderOnceHttpBeen(this.token, this.order_id);

  factory OrderOnceHttpBeen.fromJson(Map<String, dynamic> json) => _$OrderOnceHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$OrderOnceHttpBeenToJson(this);
}