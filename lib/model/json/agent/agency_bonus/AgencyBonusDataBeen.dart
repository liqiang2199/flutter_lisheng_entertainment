import 'package:json_annotation/json_annotation.dart';
part 'AgencyBonusDataBeen.g.dart';

@JsonSerializable()
class AgencyBonusDataBeen {

  int yxUserNum;
  String ykMoney;
  String bonus_money;
  String fhMoney;

  AgencyBonusDataBeen(this.yxUserNum, this.ykMoney, this.bonus_money,
      this.fhMoney);

  factory AgencyBonusDataBeen.fromJson(Map<String, dynamic> json) => _$AgencyBonusDataBeenFromJson(json);
}