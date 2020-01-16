
import 'TrendSingleDoubleDataNumBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TrendSingleDoubleDataBeen.g.dart';

@JsonSerializable()
class TrendSingleDoubleDataBeen {
  String pre_draw_issue;
  String pre_draw_time;
  String pre_draw_code;
  List<TrendSingleDoubleDataNumBeen> num;

  TrendSingleDoubleDataBeen(this.pre_draw_issue);

  factory TrendSingleDoubleDataBeen.fromJson(Map<String, dynamic> json) => _$TrendSingleDoubleDataBeenFromJson(json);
}