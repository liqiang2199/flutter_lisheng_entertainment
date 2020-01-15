import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_single/TrendHanoiOneLotterySingleReDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';
abstract class TrendHanoiOneLotteryHandler extends BaseHandler{

  /// 单号走势
  void setTrendSingleOneLotteryBeen(List<TrendHanoiOneLotterySingleReDataBeen> re_data);

}