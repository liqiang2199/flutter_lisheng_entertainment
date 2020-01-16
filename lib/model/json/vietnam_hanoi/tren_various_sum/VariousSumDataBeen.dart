import 'package:json_annotation/json_annotation.dart';
part 'VariousSumDataBeen.g.dart';

@JsonSerializable()
class VariousSumDataBeen {
  String pre_draw_issue;
  int qe;
  int qs;
  int zs;
  int hs;
  int he;
  String pre_draw_time;
  String pre_draw_code;

  VariousSumDataBeen(this.pre_draw_issue, this.qe, this.qs, this.zs, this.hs,
      this.he, this.pre_draw_time, this.pre_draw_code);

  factory VariousSumDataBeen.fromJson(Map<String, dynamic> json) => _$VariousSumDataBeenFromJson(json);
}