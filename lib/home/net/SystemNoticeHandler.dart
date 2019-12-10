import 'package:flutter_lisheng_entertainment/model/json/system_notice/SystemNoticeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class SystemNoticeHandler extends BaseHandler {

  void setSystemListData(List<SystemNoticeDataBeen> data);

}