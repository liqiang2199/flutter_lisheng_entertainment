
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class GetBettingRecordListHandler extends BaseHandler{

  void setGetBettingRecordData(GetBettingRecordBeen recordDataBeen);

}