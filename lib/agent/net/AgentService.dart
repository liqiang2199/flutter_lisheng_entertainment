import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/bridge/ToastUtilBridge.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/DelLinkAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/LinkOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/MemberManagerHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/OrdinaryOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/RechargeListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamAccountChangeHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamBettingListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamReportFormHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/UserFhHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'AgencyBonusHandler.dart';
import 'LinkManagerHandler.dart';
import 'MemberManagerHandler.dart';
import 'OrdinaryOpenAccountHandler.dart';
import 'TeamAccountChangeHandler.dart';
import 'TeamBettingHandler.dart';
import 'TeamOverviewHandler.dart';
import 'TeamRechargeRecordHandler.dart';
import 'TeamReportFormHandler.dart';

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
  void teamBettingList(TeamBettingHandler bettingHandler, String userName, String time, String endTime, String lotteryId, String qs, String page, String status) {
    TeamBettingListHttpBeen teamBettingListHttpBeen =
            new TeamBettingListHttpBeen (SpUtil.getString(Constant.TOKEN), userName, "20", page, lotteryId, status,qs,time );
    teamBettingListHttpBeen.start_date = time;
    teamBettingListHttpBeen.end_date = endTime;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingHandler);
    apiService.teamBettingList(teamBettingListHttpBeen);
  }

  /// 团队账变
  void teamMoneyLog(TeamAccountChangeHandler accountChangeHandler, String userName, String time, String endTime,String page, String status) {

    TeamAccountChangeHttpBeen teamBettingListHttpBeen = new TeamAccountChangeHttpBeen();
    teamBettingListHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    teamBettingListHttpBeen.page = page;
    teamBettingListHttpBeen.limit = "20";
    teamBettingListHttpBeen.type = status;
    teamBettingListHttpBeen.end_date = endTime;
    teamBettingListHttpBeen.start_date = time;
    teamBettingListHttpBeen.username = userName;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(accountChangeHandler);
    apiService.teamMoneyLog(teamBettingListHttpBeen);

  }

  /// 团队充值记录
  void rechargeList(TeamRechargeRecordHandler rechargeRecordHandler,String userName, String page, String startTime, String endTime) {

    RechargeListHttpBeen rechargeListHttpBeen = new RechargeListHttpBeen(SpUtil.getString(Constant.TOKEN), userName, "20", page);
    rechargeListHttpBeen.start_date = startTime;
    rechargeListHttpBeen.end_date = endTime;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(rechargeRecordHandler);
    apiService.rechargeList(rechargeListHttpBeen);
  }

  /// 团队会员列表
  void userlist(MemberManagerHandler managerHandler, String name, String page, String limit) {

    MemberManagerHttpBeen managerHttpBeen = new MemberManagerHttpBeen();
    managerHttpBeen.page = page;
    managerHttpBeen.username = name;
    managerHttpBeen.limit = limit;
    managerHttpBeen.token = SpUtil.getString(Constant.TOKEN);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(managerHandler);
    apiService.userlist(managerHttpBeen);

  }

  /// 团队总览
  void teamAll(TeamOverviewHandler teamOverviewHandler) {
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(teamOverviewHandler);
    apiService.teamAll(baseTokenHttpBeen);
  }

  /// 团队列表
  void teamList(TeamReportFormHandler reportFormHandler, String page, String userName, String userId) {

    TeamReportFormHttpBeen reportFormHttpBeen = new TeamReportFormHttpBeen();
    reportFormHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    reportFormHttpBeen.limit = "20";
    reportFormHttpBeen.page = page;
    reportFormHttpBeen.username = userName;
    reportFormHttpBeen.user_id = userId;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(reportFormHandler);
    apiService.teamList(reportFormHttpBeen);
  }

  /// 我的分红
  void myFh(AgencyBonusHandler agencyBonusHandler) {
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(agencyBonusHandler);
    apiService.myFh(baseTokenHttpBeen);
  }

  /// 历史分红
  void userFh(AgencyBonusHandler agencyBonusHandler, String page) {
    UserFhHttpBeen openAccountHttpBeen = new UserFhHttpBeen(SpUtil.getString(Constant.TOKEN), "20", page);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(agencyBonusHandler);
    apiService.userFh(openAccountHttpBeen);
  }

}