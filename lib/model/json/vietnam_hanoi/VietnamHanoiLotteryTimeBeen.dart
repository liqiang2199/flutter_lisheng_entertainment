
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'VietnamHanoiLotteryTimeDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'VietnamHanoiLotteryTimeBeen.g.dart';

@JsonSerializable()
class VietnamHanoiLotteryTimeBeen extends BaseJson{
  VietnamHanoiLotteryTimeDataBeen data;

  VietnamHanoiLotteryTimeBeen();

  factory VietnamHanoiLotteryTimeBeen.fromJson(Map<String, dynamic> json) => _$VietnamHanoiLotteryTimeBeenFromJson(json);


}