import 'package:json_annotation/json_annotation.dart';
part 'TeamRechargeRecordDataListBeen.g.dart';

@JsonSerializable()
class TeamRechargeRecordDataListBeen {

  int id;
  int user_id ;
  int paytype_id  ;

  String status;
  String money;
  String name;
  String remark;
  String reason;
  String createtime;
  String updatetime;
  String username;

  TeamRechargeRecordDataListBeen(this.id, this.user_id, this.paytype_id,
      this.status, this.money, this.name, this.remark, this.reason,
      this.createtime, this.updatetime, this.username);

  factory TeamRechargeRecordDataListBeen.fromJson(Map<String, dynamic> json) => _$TeamRechargeRecordDataListBeenFromJson(json);

}