import 'package:json_annotation/json_annotation.dart';
part 'AccountChangeRecordDataListBeen.g.dart';

@JsonSerializable()
class AccountChangeRecordDataListBeen {

  int id;
  int user_id;
  String t;
  String money;
  String all_money;
  String type;
  String relation;
  String createtime;
  String remark;

  AccountChangeRecordDataListBeen(this.id, this.user_id, this.t, this.money,
      this.all_money, this.type, this.relation, this.createtime, this.remark);

  factory AccountChangeRecordDataListBeen.fromJson(Map<String, dynamic> json) => _$AccountChangeRecordDataListBeenFromJson(json);

}