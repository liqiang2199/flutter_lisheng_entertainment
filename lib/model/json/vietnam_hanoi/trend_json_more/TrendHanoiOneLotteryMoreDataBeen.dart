import 'package:json_annotation/json_annotation.dart';
part 'TrendHanoiOneLotteryMoreDataBeen.g.dart';

@JsonSerializable()
class TrendHanoiOneLotteryMoreDataBeen {

  String pre_draw_issue;
  String pre_draw_code;
  String pre_draw_time;
  List<String> num;

  TrendHanoiOneLotteryMoreDataBeen();
  factory TrendHanoiOneLotteryMoreDataBeen.fromJson(Map<String, dynamic> json) => _$TrendHanoiOneLotteryMoreDataBeenFromJson(json);

}