
import 'AgencyBonusHistoryDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AgencyBonusHistoryDataBeen.g.dart';

@JsonSerializable()
class AgencyBonusHistoryDataBeen {

  List<AgencyBonusHistoryDataListBeen> data;
  int count;

  AgencyBonusHistoryDataBeen(this.data);

  factory AgencyBonusHistoryDataBeen.fromJson(Map<String, dynamic> json) => _$AgencyBonusHistoryDataBeenFromJson(json);

}