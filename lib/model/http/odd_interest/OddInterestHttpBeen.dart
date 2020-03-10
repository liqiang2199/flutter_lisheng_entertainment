
import 'package:json_annotation/json_annotation.dart';
part 'OddInterestHttpBeen.g.dart';

@JsonSerializable()
class OddInterestHttpBeen {

  String token;
  String play_id;

  /// 前三/直选/复式
  String one_num;
  String two_num;
  String three_num;

  /// 任选复式
  String four_num;
  String five_num;
  /// 五星和值 大小单双
  String sum_type;

  /**
   *  前三/直选/单式 （和值， 组三， 组六， 组选和值，和值尾数）
   */
  ///
  String data_num;
  /// 任选/单式 组选（计算注数） 万,千,百,十,个
  String data_address;
  /// 下注号码1,2 (二重号)
  String double_num;
  /// 下注号码1,2 (三重号)
  String sc_num;

  /// 投注
  int multiple;

  OddInterestHttpBeen();
  factory OddInterestHttpBeen.fromJson(Map<String, dynamic> json) => _$OddInterestHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$OddInterestHttpBeenToJson(this);

}