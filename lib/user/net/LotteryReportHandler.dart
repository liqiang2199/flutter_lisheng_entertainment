
import 'package:flutter_lisheng_entertainment/model/json/user_report/UserReportDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class LotteryReportHandler extends BaseHandler{

  void setUserReportDataBeen(UserReportDataBeen dataBeen);
}