
import 'package:json_annotation/json_annotation.dart';
part 'TrendFiveSumDataBeen.g.dart';

@JsonSerializable()
class TrendFiveSumDataBeen {

  String pre_draw_issue;
  int sum;
  String ds;
  String dx;
  String pre_draw_time;
  String pre_draw_code;

  TrendFiveSumDataBeen(this.pre_draw_issue, this.sum, this.ds, this.dx,
      this.pre_draw_time, this.pre_draw_code);
  factory TrendFiveSumDataBeen.fromJson(Map<String, dynamic> json) => _$TrendFiveSumDataBeenFromJson(json);

}