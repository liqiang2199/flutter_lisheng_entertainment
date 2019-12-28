
import 'TeamBettingDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamBettingDataBeen.g.dart';

@JsonSerializable()
class TeamBettingDataBeen {
  int count;
  List<TeamBettingDataListBeen> data;

  TeamBettingDataBeen(this.count, this.data);

  factory TeamBettingDataBeen.fromJson(Map<String, dynamic> json) => _$TeamBettingDataBeenFromJson(json);

}