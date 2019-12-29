
import 'TeamRechargeRecordDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamRechargeRecordDataBeen.g.dart';

@JsonSerializable()
class TeamRechargeRecordDataBeen {

  List<TeamRechargeRecordDataListBeen> userlist;
  int count;

  TeamRechargeRecordDataBeen(this.userlist, this.count);

  factory TeamRechargeRecordDataBeen.fromJson(Map<String, dynamic> json) => _$TeamRechargeRecordDataBeenFromJson(json);

}