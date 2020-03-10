

import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class LuckyAirshipHandler extends BaseHandler {

  void getCalculationBettingNumData( CalculationBettingNumDataBeen data);

  /// 清空新 龙  虎 状态
  void cleanDragonTigerStatus(bool result);

  /// 下次开奖 时间 numberPeriods 开奖期数
  void openVietnamHanoiLotteryTime(String time, String numberPeriods);

  /// 下注成功
  void bettingSuccessResult();

  /// 开奖列表
  void setAccountChangeRecord(OpenLotteryListDataBeen changeRecordBeen) {}

}