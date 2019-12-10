import 'package:flutter_lisheng_entertainment/model/json/home_json/GetBannerListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class HomeHandler extends BaseHandler {

  /**
   * banner 列表
   */
  void getBannerListBeen(GetBannerListDataBeen bannerListDataBeen);

}