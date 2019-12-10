import 'package:json_annotation/json_annotation.dart';
part 'RechargeTypeDataBeen.g.dart';

@JsonSerializable()
class RechargeTypeDataBeen {

  int id;
  String type;
  String image;
  String name;
  String min_money;
  String code;
  String pay_name;

  RechargeTypeDataBeen(this.id, this.type, this.image, this.name, this.min_money,
      this.code, this.pay_name);

  factory RechargeTypeDataBeen.fromJson(Map<String, dynamic> json) => _$RechargeTypeDataBeenFromJson(json);
}