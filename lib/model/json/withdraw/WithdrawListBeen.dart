
import 'package:json_annotation/json_annotation.dart';
part 'WithdrawListBeen.g.dart';

@JsonSerializable()
class WithdrawListBeen{
  int withdrawCount;
  String withdrawAllmoney;

  WithdrawListBeen(this.withdrawCount, this.withdrawAllmoney);
  factory WithdrawListBeen.fromJson(Map<String, dynamic> json) => _$WithdrawListBeenFromJson(json);

}