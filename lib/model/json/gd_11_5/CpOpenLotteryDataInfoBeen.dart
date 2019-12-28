import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'CpOpenLotteryInfoBeen.dart';

part 'CpOpenLotteryDataInfoBeen.g.dart';

@JsonSerializable()
class CpOpenLotteryDataInfoBeen extends BaseJson{

  CpOpenLotteryInfoBeen data;

  CpOpenLotteryDataInfoBeen();

  factory CpOpenLotteryDataInfoBeen.fromJson(Map<String, dynamic> json) => _$CpOpenLotteryDataInfoBeenFromJson(json);

}