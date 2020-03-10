
import 'package:json_annotation/json_annotation.dart';
part 'TeamAccountChangeDataListBeen.g.dart';

@JsonSerializable()
class TeamAccountChangeDataListBeen {

  int id;
  int user_id;
  String t;
  String money;
  String status;
  String all_money;
  String type;
  String relation;
  String createtime;
  String remark;
  String username;

  TeamAccountChangeDataListBeen(this.id, this.user_id, this.t, this.money,
      this.all_money, this.type, this.relation, this.createtime, this.remark,
      this.username);


  factory TeamAccountChangeDataListBeen.fromJson(Map<String, dynamic> json) => _$TeamAccountChangeDataListBeenFromJson(json);

}