import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/bridge/ToastUtilBridge.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/DelLinkAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/LinkOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/OrdinaryOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamAccountChangeHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamBettingListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'LinkManagerHandler.dart';
import 'OrdinaryOpenAccountHandler.dart';
import 'TeamAccountChangeHandler.dart';
import 'TeamBettingHandler.dart';

/**
 * AgentService
 */
class AgentService extends ToastUtilBridge{

  static AgentService get instance => _getInstance();
  static AgentService _instance;

  // 私有构造函数
  AgentService._internal() {
    // 初始化
  }

  static AgentService _getInstance() {
    if(_instance == null) {
      _instance = new AgentService._internal();
    }
    return _instance;
  }

  /**
   * 代理 开户
   */
  ///
  void postOrdinaryOpenAccount(OrdinaryOpenAccountHandler handler, String accountType,
      String account, String userName, String pwd,String rePwd, String ratio) {
    if (TextUtil.isEmpty(accountType)) {
      showToast("请选择开户类型");
      return;
    }
    if (TextUtil.isEmpty(account)) {
      showToast("请输入登录账号");
      return;
    }
    if (TextUtil.isEmpty(userName)) {
      showToast("请输入用户名");
      return;
    }
    if (TextUtil.isEmpty(pwd)) {
      showToast("请输入密码");
      return;
    }
    if (TextUtil.isEmpty(rePwd)) {
      showToast("请再次输入密码");
      return;
    }
    if (rePwd != rePwd) {
      showToast("两次密码不一致");
      return;
    }
    if (TextUtil.isEmpty(account)) {
      showToast("请选择链接有效期");
      return;
    }
    if (TextUtil.isEmpty(ratio)) {
      showToast("请输入返点");
      return;
    }
    OrdinaryOpenAccountHttpBeen openAccountHttpBeen = new
    OrdinaryOpenAccountHttpBeen(accountType, account, userName, pwd, ratio, SpUtil.getString(Constant.TOKEN));
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(handler);
    apiService.postOrdinaryOpenAccount(openAccountHttpBeen);

  }

  /**
   * 创建开户链接
   */
  ///
  void postLinkOpenAccount(String accountType, String day, String ratio, LinkOpenAccountHandler handler){
    if (TextUtil.isEmpty(accountType)) {
      showToast("请选择开户类型");
      return;
    }
    if (TextUtil.isEmpty(day)) {
      showToast("请选择链接有效期");
      return;
    }
    if (TextUtil.isEmpty(ratio)) {
      showToast("请输入返点");
      return;
    }
    LinkOpenAccountHttpBeen openAccountHttpBeen = new LinkOpenAccountHttpBeen(
        SpUtil.getString(Constant.TOKEN), accountType, day, ratio);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(handler);
    apiService.postLinkOpenAccount(openAccountHttpBeen);

  }

  /**
   * 获取链接开户地址列表
   */
  ///
  void getLinkAccountList(LinkManagerHandler linkManagerHandler) {

    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(linkManagerHandler);
    apiService.getLinkAccountList(baseTokenHttpBeen);

  }

  /**
   * 删除链接开户地址
   */
  ///
  void delLinkAccount(LinkManagerHandler linkManagerHandler, String id) {

    DelLinkAccountHttpBeen baseTokenHttpBeen = new DelLinkAccountHttpBeen(SpUtil.getString(Constant.TOKEN), id);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(linkManagerHandler);
    apiService.delLinkAccount(baseTokenHttpBeen);

  }

  /**
   * 团队投注
   */
  ///
  void teamBettingList(TeamBettingHandler bettingHandler, String userName, String time, String lotteryId, String qs, String page, String status) {
    TeamBettingListHttpBeen teamBettingListHttpBeen =
            new TeamBettingListHttpBeen (SpUtil.getString(Constant.TOKEN), userName, "20", page, lotteryId, status,qs,time );
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingHandler);
    apiService.teamBettingList(teamBettingListHttpBeen);
  }

  /// 团队账变
  void teamMoneyLog(TeamAccountChangeHandler accountChangeHandler, String userName, String time,String page, String status) {

    TeamAccountChangeHttpBeen teamBettingListHttpBeen = new TeamAccountChangeHttpBeen();
    teamBettingListHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    teamBettingListHttpBeen.page = page;
    teamBettingListHttpBeen.limit = "20";
    teamBettingListHttpBeen.type = status;
    teamBettingListHttpBeen.date = time;
    teamBettingListHttpBeen.username = userName;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(accountChangeHandler);
    apiService.teamMoneyLog(teamBettingListHttpBeen);

  }

}