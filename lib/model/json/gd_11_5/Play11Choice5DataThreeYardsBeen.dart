import 'package:json_annotation/json_annotation.dart';
part 'Play11Choice5DataThreeYardsBeen.g.dart';

@JsonSerializable()
class Play11Choice5DataThreeYardsBeen {

  int id;
  int lottery_id;
  int play_id;
  String name;
  String is_group;
  String status;
  String money_award;
  String money;
  String remark;

  Play11Choice5DataThreeYardsBeen(this.id, this.lottery_id, this.play_id,
      this.name, this.is_group, this.status, this.money_award, this.money,
      this.remark);

  factory Play11Choice5DataThreeYardsBeen.fromJson(Map<String, dynamic> json) => _$Play11Choice5DataThreeYardsBeenFromJson(json);


}