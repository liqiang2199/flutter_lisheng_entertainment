
import 'package:json_annotation/json_annotation.dart';
part 'DragonTigerDataBeen.g.dart';

@JsonSerializable()
class DragonTigerDataBeen {
  String pre_draw_issue;
  String wq;
  String wb;
  String ws;
  String wg;
  String qb;
  String qs;
  String qg;
  String bs;
  String bg;
  String sg;
  String pre_draw_time;
  String pre_draw_code;

  DragonTigerDataBeen(this.pre_draw_issue, this.wq, this.wb, this.ws, this.wg,
      this.qb, this.qs, this.qg, this.bs, this.bg, this.sg, this.pre_draw_time,
      this.pre_draw_code);

  factory DragonTigerDataBeen.fromJson(Map<String, dynamic> json) => _$DragonTigerDataBeenFromJson(json);
}