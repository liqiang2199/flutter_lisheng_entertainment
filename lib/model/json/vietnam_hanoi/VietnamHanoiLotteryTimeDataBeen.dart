
import 'package:json_annotation/json_annotation.dart';
part 'VietnamHanoiLotteryTimeDataBeen.g.dart';

@JsonSerializable()
class VietnamHanoiLotteryTimeDataBeen {

  String qishu;
  String kj_time;

  VietnamHanoiLotteryTimeDataBeen();
  factory VietnamHanoiLotteryTimeDataBeen.fromJson(Map<String, dynamic> json) => _$VietnamHanoiLotteryTimeDataBeenFromJson(json);

}