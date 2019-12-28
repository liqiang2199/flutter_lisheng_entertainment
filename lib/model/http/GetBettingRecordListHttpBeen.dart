import 'package:json_annotation/json_annotation.dart';
part "GetBettingRecordListHttpBeen.g.dart";

@JsonSerializable()
class GetBettingRecordListHttpBeen {

  String token;
  String username;
  String limit;
  String lottery_id;//彩票种类（0为全部）
  String status;//状态 状态（默认0 为全部） 1=待开奖,2=中奖,3=未中奖
  String stare_time;//起始时间（2018-06-06）（默认1）
  String end_time;

  GetBettingRecordListHttpBeen();
  factory GetBettingRecordListHttpBeen.fromJson(Map<String, dynamic> json) => _$GetBettingRecordListHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$GetBettingRecordListHttpBeenToJson(this);

}