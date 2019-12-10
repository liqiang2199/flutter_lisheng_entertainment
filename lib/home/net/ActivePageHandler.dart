
import 'package:flutter_lisheng_entertainment/model/json/active_page/ActivePageDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class ActivePageHandler extends BaseHandler{

  void setActivePageListBeen(List<ActivePageDataBeen> data);

}