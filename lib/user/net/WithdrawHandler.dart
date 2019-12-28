
import 'package:flutter_lisheng_entertainment/model/json/withdraw/WithdrawListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

/**
 * 提现
 */
///
abstract class WithdrawHandler extends BaseHandler{

  /**
   * 提现时查询今日提现次数 提现中总金额
   */
  ///
  void setWithdrawListData(WithdrawListDataBeen listDataBeen);

  /**
   * 提现申请
   */
  ///
  void userWithdrawResult(bool result);



}