
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class GetBettingRecordListHandler extends BaseHandler{

  void setGetBettingRecordData(GetBettingRecordBeen recordDataBeen);

  /**
   * 再来一注的结果
   */
  ///
  void getOrderOnceResult(bool result);

}