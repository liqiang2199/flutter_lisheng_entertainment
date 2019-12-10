
import 'package:json_annotation/json_annotation.dart';
part 'BankDataBeen.g.dart';

@JsonSerializable()
class BankDataBeen {

  int id;
  int user_id;
  int banktype_id;
  String realname;
  String card_number;
  String branch_name;
  String bank_name;

  BankDataBeen(this.id, this.user_id, this.banktype_id, this.realname,
      this.card_number, this.branch_name, this.bank_name);

  factory BankDataBeen.fromJson(Map<String, dynamic> json) => _$BankDataBeenFromJson(json);


}