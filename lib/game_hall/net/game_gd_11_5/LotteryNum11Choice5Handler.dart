import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryDataInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
/**
 * 开奖记录
 */
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

///
abstract class LotteryNum11Choice5Handler extends BaseHandler{

  /**
   * 获取开奖列表
   */
  ///
  void setOpenLotteryListData(OpenLotteryListDataBeen data);

  /// 彩票开奖信息（下期时间）
  void setOpenLotteryListInfoData(CpOpenLotteryDataInfoBeen data);
}