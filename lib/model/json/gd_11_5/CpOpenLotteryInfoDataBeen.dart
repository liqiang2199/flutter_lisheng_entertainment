
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'CpOpenLotteryInfoBeen.dart';

part 'CpOpenLotteryInfoDataBeen.g.dart';

@JsonSerializable()
class CpOpenLotteryInfoDataBeen extends BaseJson{
  List<CpOpenLotteryInfoBeen> data;

  CpOpenLotteryInfoDataBeen();

  factory CpOpenLotteryInfoDataBeen.fromJson(Map<String, dynamic> json) => _$CpOpenLotteryInfoDataBeenFromJson(json);

}