import 'package:flutter_lisheng_entertainment/model/json/recharge/RechargeTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

/**
 * 充值
 */
abstract class RechargeHandler extends BaseHandler{

  /// 类型选择
  void setRechargeTypeList(RechargeTypeListBeen data);
}