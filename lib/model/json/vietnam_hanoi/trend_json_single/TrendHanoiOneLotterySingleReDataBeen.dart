import 'package:json_annotation/json_annotation.dart';
part 'TrendHanoiOneLotterySingleReDataBeen.g.dart';

@JsonSerializable()
class TrendHanoiOneLotterySingleReDataBeen {

  String pre_draw_issue;
  String num;
  String pre_draw_time;
  String pre_draw_code;

  /// 多号走势
  List<String> moreNum;

  /// 单双走势
  List<String> singleDoubleNum;
  List<String> singleDoubleStr;//说明

  /// 五星和值
  String sum;
  String ds;
  String dx;

  /// 各类和值
  String qe;
  String qs;
  String zs;
  String hs;
  String he;

  /// 龙虎和
  String wq;
  String wb;
  String ws;
  String wg;
  String qb;
  //String qs;
  String qg;
  String bs;
  String bg;
  String sg;

  TrendHanoiOneLotterySingleReDataBeen();
  factory TrendHanoiOneLotterySingleReDataBeen.fromJson(Map<String, dynamic> json) => _$TrendHanoiOneLotterySingleReDataBeenFromJson(json);

}