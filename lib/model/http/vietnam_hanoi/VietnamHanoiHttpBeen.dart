
import 'package:json_annotation/json_annotation.dart';
part 'VietnamHanoiHttpBeen.g.dart';

@JsonSerializable()
class VietnamHanoiHttpBeen {

  String token;
  String play_id;

  /// 前三/直选/复式
  String one_num;
  String two_num;
  String three_num;

  /**
   *  前三/直选/单式 （和值， 组三， 组六， 组选和值，和值尾数）
   */
  ///
  String data_num;

  VietnamHanoiHttpBeen();
  factory VietnamHanoiHttpBeen.fromJson(Map<String, dynamic> json) => _$VietnamHanoiHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$VietnamHanoiHttpBeenToJson(this);

}