import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

/**
 * 计算注数
 */
abstract class CalculationBettingNumHandler extends BaseHandler{

  /// 注数请求 返回数据
  void getCalculationBettingNumData(CalculationBettingNumDataBeen data);

  /**
   * 下注成功
   */
  void multipleSuccess(bool result);
}