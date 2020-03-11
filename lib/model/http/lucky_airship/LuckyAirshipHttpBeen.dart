
import 'package:json_annotation/json_annotation.dart';
part 'LuckyAirshipHttpBeen.g.dart';

@JsonSerializable()
class LuckyAirshipHttpBeen {

  String token;
  String play_id;

  /// 定位胆
  String one_num;
  String two_num;
  String three_num;
  String four_num;
  String five_num;
  String six_num;
  String seven_num;
  String eight_num;
  String nine_num;
  String ten_num;


  /**
   *  前一
   *  前二单式
   */
  ///
  String data_num;
  /// 大小  单双  龙虎
  String num_type;

  /// 投注
  int multiple;

  LuckyAirshipHttpBeen();
  factory LuckyAirshipHttpBeen.fromJson(Map<String, dynamic> json) => _$LuckyAirshipHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$LuckyAirshipHttpBeenToJson(this);

}