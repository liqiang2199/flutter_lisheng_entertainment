import 'package:json_annotation/json_annotation.dart';
part 'TrendHanoiOneLotterySingleReDataBeen.g.dart';

@JsonSerializable()
class TrendHanoiOneLotterySingleReDataBeen {

  String pre_draw_issue;
  String num;
  String pre_draw_time;
  String pre_draw_code;

  List<String> moreNum;

  TrendHanoiOneLotterySingleReDataBeen();
  factory TrendHanoiOneLotterySingleReDataBeen.fromJson(Map<String, dynamic> json) => _$TrendHanoiOneLotterySingleReDataBeenFromJson(json);

}