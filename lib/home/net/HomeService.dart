import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/home/net/ActivePageHandler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CpOpenLotteryInfoHttp.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'HomeHandler.dart';
import 'LotteryCenterHandler.dart';
import 'SystemNoticeHandler.dart';


class HomeService {

  static HomeService get instance => _getInstance();
  static HomeService _instance;

  // 私有构造函数
  HomeService._internal() {
    // 初始化
  }

  static HomeService _getInstance() {
    if(_instance == null) {
      _instance = new HomeService._internal();
    }
    return _instance;
  }

  /**
   * getBannerList
   */
  ///
  void getBannerList(String token, HomeHandler homeHandler) async{

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen tokenHttpBeen = new BaseTokenHttpBeen(token);
    apiService.setHandler(homeHandler);
    apiService.getBannerList(tokenHttpBeen);
  }

  /**
   * 获取网站公告
   */
  ///
  void getSystemNoticeList(SystemNoticeHandler homeHandler) async{

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen tokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(homeHandler);
    apiService.getNoticeList(tokenHttpBeen);
  }

  /**
   * 网站活动列表
   */
  ///
  void getActivityList(ActivePageHandler homeHandler) async{

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen tokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(homeHandler);
    apiService.getActivityList(tokenHttpBeen);
  }

  void getApiHome(LotteryCenterHandler num11choice5handler) {
    CpOpenLotteryInfoHttp openLotteryListHttpBeen = new CpOpenLotteryInfoHttp(SpUtil.getString(Constant.TOKEN), "");
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.getApiHome(openLotteryListHttpBeen);
  }

}