
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgencyBonusHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/MemberManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/OpenAccountIntervalHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/OrdinaryOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamAccountChangeHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamOverviewHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamRechargeRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamReportFormHandler.dart';
import 'package:flutter_lisheng_entertainment/base/handler/ModifyAvatarHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameHallHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/PlayMode11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/TrendHanoiOneLotteryHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/CalculationBettingNumHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/odd_interest/OddInterestHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/tencent_game/TencentCnetBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/ActivePageHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/LotteryCenterHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/SystemNoticeHandler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/CommonUploadHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/GetBettingRecordListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/UserReportHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/DelLinkAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/LinkOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/MemberManagerHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/OrdinaryOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/RechargeListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamAccountChangeHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamBettingListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamReportFormHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/UserFhHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/bank/BindBankHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CalculationBettingNumHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CpOpenLotteryInfoHttp.dart';
import 'package:flutter_lisheng_entertainment/model/http/odd_interest/OddInterestHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/order/DelOrderHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/order/OrderOnceHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/ModifyPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/SetPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/tencent/TencentHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_info_center/ModifyAvatarHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_info_center/UserInfoCenterHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_record/UserAccountChangeRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/VietnamHanoiHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/hanoi_trend/HanoiOneLotteryMoreTrendHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/hanoi_trend/HanoiOneLotterySingleTrendHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/withdraw/UserWithdrawHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/withdraw/record/UserWithdrawRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:flutter_lisheng_entertainment/model/json/JsonBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/active_page/ActivePageListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/LinkOpenAccountBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/OrdinaryOpenAccountBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/TeamOverviewBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/agency_bonus/AgencyBonusBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/agency_bonus/AgencyBonusHistoryBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/link_list/LinkAccountListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/open_account_interval/OpenAccountIntervalBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_account_change/TeamAccountChangeBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_betting/TeamBettingBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_member/MemberManagerBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_recharge/TeamRechargeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_report_form/TeamReportFormBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/BankListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/type/GetBankTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/cash_password/PayPasswordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryDataInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryInfoDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/home_json/GetBannerListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/tren_various_sum/VariousSumBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_dragon_tiger/DragonTigerBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_five/TrendFiveSumBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_single/TrendHanoiOneLotterySingleBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_more/TrendHanoiOneLotteryMoreBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_center/LotteryCenterBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/recharge/RechargeTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/set/SetLoginOutBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/system_notice/SystemNoticeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/user_report/UserReportBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/VietnamHanoiLotteryTimeBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_single/TrendHanoiOneLotterySingleReDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_single_double/TrendSingleDoubleBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_single_double/TrendSingleDoubleDataNumBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/WithdrawListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/user_record/UserWithdrawRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/user/bank/BindBankController.dart';
import 'package:flutter_lisheng_entertainment/user/net/BankListHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/BindBankHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/LoginHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/LotteryReportHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/ModifyLoginPasswordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/RechargeHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/SetCashPasswordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/SetHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserWithdrawRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/WithdrawHandler.dart';
import 'package:flutter_lisheng_entertainment/view/common/loading.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';

import 'AccountChangeRecordHandler.dart';
import 'GetBettingRecordListHandler.dart';

@RestApi(baseUrl: UrlUtil.BaseUrl)
abstract class ApiService<T> {

  BuildContext context;
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService<T>;

  setHandler(T _baseHandler);
  setBuildContext(BuildContext context) {
    this.context = context;
  }

  @POST(UrlUtil.login)
  void login(@Body() LoginHttpBeen task);

  // 图片上传
  @POST(UrlUtil.commonUpload)
  void upload(@Body() CommonUploadHttpBeen uploadHttpBeen);

  // 修改用户头像
  @POST(UrlUtil.editAvatar)
  void editAvatar(@Body() ModifyAvatarHttpBeen uploadHttpBeen);

  /// 退出登录
  @POST(UrlUtil.loginOut)
  void loginOut(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// banner列表
  @POST(UrlUtil.getBannerList)
  void getBannerList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  ///获取网站公告
  @POST(UrlUtil.getNoticeList)
  void getNoticeList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 网站活动列表
  @POST(UrlUtil.getActivityList)
  void getActivityList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  @POST(UrlUtil.editLoginPwd)
  void editLoginPwd(@Body() UserInfoCenterHttpBeen tokenHttpBeen);

  /// 设置资金密码
  @POST(UrlUtil.setPaypwd)
  void setPaypwd(@Body() SetPaypwdHttpBeen tokenHttpBeen);

  /// 修改资金密码
  @POST(UrlUtil.setPaypwd)
  void modifyPaypwd(@Body() ModifyPaypwdHttpBeen tokenHttpBeen);

  /// 获取银行卡列表
  @POST(UrlUtil.getBankList)
  void getBankList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 银行卡绑定
  @POST(UrlUtil.bindBank)
  void bindBank(@Body() BindBankHttpBeen tokenHttpBeen);

  /// 获取银行卡列表
  @POST(UrlUtil.getBanktypeList)
  void getBanktypeList();

  /// 获取充值方式
  @POST(UrlUtil.getPaytypeList)
  void getPaytypeList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 提现时查询今日提现次数 提现中总金额
  @POST(UrlUtil.withdrawList)
  void withdrawList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 提现时查询今日提现次数 提现中总金额
  @POST(UrlUtil.userWithdraw)
  void userWithdraw(@Body() UserWithdrawHttpBeen userWithdrawHttpBeen);

  /// 代理 开户
  @POST(UrlUtil.addAccount)
  void postOrdinaryOpenAccount(@Body() OrdinaryOpenAccountHttpBeen openAccountHttpBeen);

  /// 开户页面获取最大返点值
  @POST(UrlUtil.openAccount)
  void openAccount(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 创建开户链接
  @POST(UrlUtil.addAccountLink)
  void postLinkOpenAccount(@Body() LinkOpenAccountHttpBeen openAccountHttpBeen);

  /// 获取链接开户地址列表
  @POST(UrlUtil.getLinkAccountList)
  void getLinkAccountList(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 删除链接开户地址
  @POST(UrlUtil.delLinkAccount)
  void delLinkAccount(@Body() DelLinkAccountHttpBeen openAccountHttpBeen);

  /// 团队投注
  @POST(UrlUtil.teamBettingList)
  void teamBettingList(@Body() TeamBettingListHttpBeen teamBettingListHttpBeen);

  /// 团队账变
  @POST(UrlUtil.teamMoneyLog)
  void teamMoneyLog(@Body() TeamAccountChangeHttpBeen teamBettingListHttpBeen);

  /// 团队充值记录
  @POST(UrlUtil.rechargeList)
  void rechargeList(@Body() RechargeListHttpBeen rechargeListHttpBeen);

  /// 团队会员列表
  @POST(UrlUtil.userlist)
  void userlist(@Body() MemberManagerHttpBeen managerHttpBeen);

  /// 团队总览
  @POST(UrlUtil.teamAll)
  void teamAll(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 团队列表
  @POST(UrlUtil.teamList)
  void teamList(@Body() TeamReportFormHttpBeen reportFormHttpBeen);

  /// 我的分红
  @POST(UrlUtil.myFh)
  void myFh(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 历史分红
  @POST(UrlUtil.userFh)
  void userFh(@Body() UserFhHttpBeen openAccountHttpBeen);

  /**
   * 广东11 选 5
   */

  /// 删除链接开户地址
  @POST(UrlUtil.getPlay)
  void getPlay(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  @POST(UrlUtil.gdBets)
  void gdBets(@Body() CalculationBettingNumHttpBeen openAccountHttpBeen);

  /// 广东11 选 5
  @POST(UrlUtil.orderAdd)
  void orderAdd(@Body() CalculationBettingNumHttpBeen openAccountHttpBeen);

  /// 彩票种类
  @POST(UrlUtil.lotteryList)
  void lotteryList(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  ///开奖记录
  @POST(UrlUtil.kjlogList)
  void kjlogList(@Body() OpenLotteryListHttpBeen openLotteryListHttpBeen);

  ///开奖记录 (下期时间)
  @POST(UrlUtil.getApi)
  void getApi(@Body() CpOpenLotteryInfoHttp openLotteryListHttpBeen);

  @POST(UrlUtil.getApi)
  void getApiHome(@Body() CpOpenLotteryInfoHttp openLotteryListHttpBeen);

  /// 订单撤销
  @POST(UrlUtil.delOrder)
  void delOrder(@Body() DelOrderHttpBeen delOrderHttpBeen);

  /// 再来一单 (app)
  @POST(UrlUtil.orderOnce)
  void orderOnce(@Body() OrderOnceHttpBeen orderOnceHttpBeen);

  /**
   * 越南 河内一分彩
   */
  ///
  @POST(UrlUtil.hanoiOneGetPlay)
  void hanoiOneGetPlay(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 计算注数
  @POST(UrlUtil.hanoiOneGetGDBets)
  void hanoiOneGetGDBets(@Body() VietnamHanoiHttpBeen openAccountHttpBeen);

  /// 投注
  @POST(UrlUtil.hanoiOneGetOrderAdd)
  void hanoiOneGetOrderAdd(@Body() VietnamHanoiHttpBeen openAccountHttpBeen);

  /// 获取下期开奖时间
  @POST(UrlUtil.hanoiOneGetKjTime)
  void hanoiOneGetKjTime(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 越南河内1分彩 开奖记录
  @POST(UrlUtil.hanoiOneKjLog)
  void hanoiOneKjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 越南河内1分彩 开奖记录
  @POST(UrlUtil.hanoiOneKjLog)
  void hanoiOneKjLog_LotteryList(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  ///单号走势
  @POST(UrlUtil.hanoiOneOddNumber)
  void hanoiOneOddNumber(@Body() HanoiOneLotterySingleTrendHttpBeen openAccountHttpBeen);

  ///多号走势
  @POST(UrlUtil.hanoiOneMultipleNumbers)
  void hanoiOneMultipleNumbers(@Body() HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen);

  ///单双走势
  @POST(UrlUtil.hanoiOneSingleDouble)
  void hanoiOneSingleDouble(@Body() HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen);

  ///大小走势
  @POST(UrlUtil.hanoiOneMaxMin)
  void hanoiOneMaxMin(@Body() HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen);

  ///五星和值
  @POST(UrlUtil.hanoiOneFiveValue)
  void hanoiOneFiveValue(@Body() HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen);

  ///各类和值
  @POST(UrlUtil.hanoiOneVariousSum)
  void hanoiOneVariousSum(@Body() HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen);

  ///各类跨度
  @POST(UrlUtil.hanoiOneVariousSpan)
  void hanoiOneVariousSpan(@Body() HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen);


  ///龙虎和
  @POST(UrlUtil.hanoiOneDragonTiger)
  void hanoiOneDragonTiger(@Body() BaseTokenHttpBeen openAccountHttpBeen);


  /**
   * 河内5分彩
   */
  ///
  @POST(UrlUtil.hanoi5GetPlay)
  void hanoi5GetPlay(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 计算注数
  @POST(UrlUtil.hanoi5GetGDBets)
  void hanoi5GetGDBets(@Body() VietnamHanoiHttpBeen openAccountHttpBeen);

  /// 投注
  @POST(UrlUtil.hanoi5GetOrderAdd)
  void hanoi5GetOrderAdd(@Body() VietnamHanoiHttpBeen openAccountHttpBeen);

  /// 获取下期开奖时间
  @POST(UrlUtil.hanoi5GetKjTime)
  void hanoi5GetKjTime(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 河内5分彩 开奖记录
  @POST(UrlUtil.hanoi5KjLog)
  void hanoi5KjLog_LotteryList(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 河内5分彩 开奖记录
  @POST(UrlUtil.hanoi5KjLog)
  void hanoi5KjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);




  /**
   * 腾讯分分彩
   */
  /// 腾讯分分彩 开奖记录
  @POST(UrlUtil.tencentKjLog)
  void tencentKjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 腾讯分分彩 开奖记录
  @POST(UrlUtil.tencentKjLog)
  void tencentKjLog_Limit(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 腾讯分分彩 玩法获取
  @POST(UrlUtil.tencentGetPlay)
  void tencentGetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 腾讯分分彩 开奖时间
  @POST(UrlUtil.tencentGetKjtime)
  void tencentGetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 腾讯分分彩 计算注数
  @POST(UrlUtil.tencentGdBets)
  void tencentGdBets(@Body() TencentHttpBeen baseTokenHttpBeen);

  /// 腾讯分分彩 下注接口
  @POST(UrlUtil.tencentOrderAdd)
  void tencentOrderAdd(@Body() TencentHttpBeen baseTokenHttpBeen);

  /**
   * 腾讯五分彩
   */
  /// 腾讯5分彩 开奖记录
  @POST(UrlUtil.tencent5KjLog)
  void tencent5KjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 腾讯5分彩 玩法获取
  @POST(UrlUtil.tencent5GetPlay)
  void tencent5GetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 腾讯5分彩 开奖时间
  @POST(UrlUtil.tencent5GetKjtime)
  void tencent5GetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 腾讯5分彩 计算注数
  @POST(UrlUtil.tencent5GdBets)
  void tencent5GdBets(@Body() TencentHttpBeen baseTokenHttpBeen);

  /// 腾讯5分彩 下注接口
  @POST(UrlUtil.tencent5OrderAdd)
  void tencent5OrderAdd(@Body() TencentHttpBeen baseTokenHttpBeen);

  /**
   * 腾讯10分彩
   */
  /// 腾讯10分彩 开奖记录
  @POST(UrlUtil.tencent10KjLog)
  void tencent10KjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 腾讯10分彩 玩法获取
  @POST(UrlUtil.tencent10GetPlay)
  void tencent10GetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 腾讯10分彩 开奖时间
  @POST(UrlUtil.tencent10GetKjtime)
  void tencent10GetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 腾讯10分彩 计算注数
  @POST(UrlUtil.tencent10GdBets)
  void tencent10GdBets(@Body() TencentHttpBeen baseTokenHttpBeen);

  /// 腾讯10分彩 下注接口
  @POST(UrlUtil.tencent10OrderAdd)
  void tencent10OrderAdd(@Body() TencentHttpBeen baseTokenHttpBeen);

  /**
   * 奇趣一分彩
   */
  /// 奇趣一分彩 开奖记录
  @POST(UrlUtil.oddInterestKjLog)
  void oddInterestKjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 奇趣一分彩 玩法获取
  @POST(UrlUtil.oddInterestGetPlay)
  void oddInterestGetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 奇趣一分彩 开奖时间
  @POST(UrlUtil.oddInterestGetKjtime)
  void oddInterestGetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 奇趣一分彩 计算注数
  @POST(UrlUtil.oddInterestGdBets)
  void oddInterestGdBets(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /// 奇趣一分彩 下注接口
  @POST(UrlUtil.oddInterestOrderAdd)
  void oddInterestOrderAdd(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /**
   * 奇趣5分彩
   */
  /// 奇趣一分彩 开奖记录
  @POST(UrlUtil.oddInterest5KjLog)
  void oddInterest5KjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 奇趣一分彩 玩法获取
  @POST(UrlUtil.oddInterest5GetPlay)
  void oddInterest5GetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 奇趣一分彩 开奖时间
  @POST(UrlUtil.oddInterest5GetKjtime)
  void oddInterest5GetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 奇趣一分彩 计算注数
  @POST(UrlUtil.oddInterest5GdBets)
  void oddInterest5GdBets(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /// 奇趣一分彩 下注接口
  @POST(UrlUtil.oddInterest5OrderAdd)
  void oddInterest5OrderAdd(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /**
   * 奇趣10分彩
   */
  /// 奇趣10分彩 开奖记录
  @POST(UrlUtil.oddInterest10KjLog)
  void oddInterest10KjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 奇趣10分彩 玩法获取
  @POST(UrlUtil.oddInterest10GetPlay)
  void oddInterest10GetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 奇趣10分彩 开奖时间
  @POST(UrlUtil.oddInterest10GetKjtime)
  void oddInterest10GetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 奇趣10分彩 计算注数
  @POST(UrlUtil.oddInterest10GdBets)
  void oddInterest10GdBets(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /// 奇趣10分彩 下注接口
  @POST(UrlUtil.oddInterest10OrderAdd)
  void oddInterest10OrderAdd(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /**
   * 幸运飞艇
   */
  /// 幸运飞艇 开奖记录
  @POST(UrlUtil.luckyAirshipKjLog)
  void luckyAirshipKjLog(@Body() OpenLotteryListHttpBeen openAccountHttpBeen);

  /// 幸运飞艇 玩法获取
  @POST(UrlUtil.luckyAirshipGetPlay)
  void luckyAirshipGetPlay(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 幸运飞艇 开奖时间
  @POST(UrlUtil.luckyAirshipGetKjtime)
  void luckyAirshipGetKjtime(@Body() BaseTokenHttpBeen baseTokenHttpBeen);

  /// 幸运飞艇 计算注数
  @POST(UrlUtil.luckyAirshipGdBets)
  void luckyAirshipGdBets(@Body() OddInterestHttpBeen baseTokenHttpBeen);

  /// 幸运飞艇 下注接口
  @POST(UrlUtil.luckyAirshipOrderAdd)
  void luckyAirshipOrderAdd(@Body() OddInterestHttpBeen baseTokenHttpBeen);


  /**
   * 个人中心
   */
  /// 个人投注记录
  @POST(UrlUtil.bettingList)
  void bettingList(@Body() GetBettingRecordListHttpBeen openLotteryListHttpBeen);

  @POST(UrlUtil.moneyLog)
  void moneyLog(@Body() UserAccountChangeRecordHttpBeen openLotteryListHttpBeen);

  /// 个人报表
  @POST(UrlUtil.userReport)
  void userReport(@Body() UserReportHttpBeen userReportHttpBeen);

  /// 获取提现记录
  @POST(UrlUtil.withdraw)
  void withdraw(@Body() UserWithdrawRecordHttpBeen withdrawRecordHttpBeen);

}

class _ApiService<T> implements ApiService<T> {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= UrlUtil.BaseUrl;
  }

  final Dio _dio;

  T _baseHandler;
  String baseUrl;
  BuildContext context;

  _getHeaders () {
    return {
      'Accept':'application/json, text/plain, */*',
      'Content-Type':'application/json',
    };
  }

  @override
  setHandler(T _baseHandler) {
    this._baseHandler = _baseHandler;
  }

  @override
  setBuildContext(BuildContext context) {
    this.context = context;
  }

  /**
   * 发送Post 网络请求
   * jsonData 传入的 json 数据
   */
  ///
  @override
  Future<Map<String, dynamic>> responseResult(Map<String, dynamic> jsonData, String path) async {
    _showLoadingDialog();//弹出弹窗
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(jsonData ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(path,
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: _getHeaders (),
            extra: _extra,
            baseUrl: UrlUtil.BaseUrl),
        data: _data)
//        .catchError((error) {
//          if (context != null) {
//            Navigator.pop(context);
//          }
//
//          switch (error.runtimeType) {
//            case DioError:
//            // Here's the sample to get the failed response error code and message
//              final res = (error as DioError).response;
//              //print("Got error : ${res.statusCode} -> ${res.statusMessage}");
//              break;
//            default:
//          }
//    })
    ;



    if (_result.data != null) {
      print(_result.data);
    }
    if (context != null) {
      Navigator.pop(context);
    }
    return _result.data;
  }
  /// 加载弹窗 提示 弹窗
  _showLoadingDialog() {
    if (context == null) {
      return;
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(loadTip: "加载中...",);
        });
  }


  @override
  void login(LoginHttpBeen task) {
    ArgumentError.checkNotNull(task, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(task.toJson(), UrlUtil.login).then((onValue) {
      var loginDataBeen = LoginBeen.fromJson(onValue);

      var loginH = _baseHandler as LoginHandler;
      if (loginDataBeen.code == 1) {
        print("token = ${loginDataBeen.toString()}");
        print("loginDataBeen = ${loginDataBeen.data.token}");
        SpUtil.putString(Constant.TOKEN, "${loginDataBeen.data.token}");
        SpUtil.putString(Constant.ALL_MONEY, "${loginDataBeen.data.userInfo.all_money}");
        SpUtil.putString(Constant.USER_RATIO, "${loginDataBeen.data.userInfo.ratio}");
        SpUtil.putString(Constant.USER_HEAD_IMG, "${loginDataBeen.data.userInfo.avatar}");
        SpUtil.putString(Constant.USER_NAME, "${loginDataBeen.data.userInfo.username}");
        SpUtil.putString(Constant.IS_AGENT, "${loginDataBeen.data.userInfo.is_dali}");
        var pay_pwd = loginDataBeen.data.userInfo.pay_pwd;
        if(pay_pwd != null) {
          if (!TextUtil.isEmpty(pay_pwd)) {
            SpUtil.putBool(Constant.PAY_SET, true);
          } else {
            SpUtil.putBool(Constant.PAY_SET, false);
          }
        } else {
          SpUtil.putBool(Constant.PAY_SET, false);
        }

        print("SpUtil GetToekn = ${SpUtil.getString(Constant.TOKEN)}");
        if (loginH != null) {
          loginH.loginSuccess(true, loginDataBeen);
        }
      } else {
        if (loginH != null) {
          loginH.loginFail(false);
          loginH.showToast(loginDataBeen.msg);
        }
      }

      return loginDataBeen;
    });
  }

  /// 图片保存
  void upload(CommonUploadHttpBeen uploadHttpBeen) {
    ArgumentError.checkNotNull(uploadHttpBeen, '参数为空');
//    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(uploadHttpBeen.toJson(), UrlUtil.commonUpload).then((onValue) {
//      var bannerList = SetLoginOutBeen.fromJson(onValue);
//      var setHandler = _baseHandler as SetHandler;
//      if (bannerList.code == 1) {
//        if (setHandler != null) {
//          setHandler.loginOutResult(true);
//        }
//      } else {
//        setHandler.showToast(bannerList.msg);
//      }
    });
  }

  /// 修改头像
  void editAvatar(ModifyAvatarHttpBeen uploadHttpBeen) {
    ArgumentError.checkNotNull(uploadHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(uploadHttpBeen.toJson(), UrlUtil.editAvatar).then((onValue) {
      var bannerList = SetLoginOutBeen.fromJson(onValue);
      var avatarHandler = _baseHandler as ModifyAvatarHandler;
      avatarHandler.showToast(bannerList.msg);
      if (bannerList.code == 1) {
        if (avatarHandler != null) {
          SpUtil.putString(Constant.USER_HEAD_IMG, "${uploadHttpBeen.avatar}");
          avatarHandler.setModifyHeadImgUrl("${UrlUtil.BaseUrl}${uploadHttpBeen.avatar}");
        }
      }
    });
  }

  /// 退出登录
  @override
  void loginOut(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.loginOut).then((onValue) {
      var bannerList = SetLoginOutBeen.fromJson(onValue);
      var setHandler = _baseHandler as SetHandler;
      if (bannerList.code == 1) {
        if (setHandler != null) {
          setHandler.loginOutResult(true);
        }
      } else {
        setHandler.showToast(bannerList.msg);
      }
    });
  }

  @override
  void getBannerList(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getBannerList).then((onValue) {
      var bannerList = GetBannerListDataBeen.fromJson(onValue);
      var homeHandler = _baseHandler as HomeHandler;
      if (bannerList.code == 1) {
        if (homeHandler != null) {
          homeHandler.getBannerListBeen(bannerList);
        }
      }
    });
  }

  @override
  void getNoticeList(@Body() BaseTokenHttpBeen tokenHttpBeen){
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getNoticeList).then((onValue) {
      var systemNoticeList = SystemNoticeListBeen.fromJson(onValue);
      var systemNoticeHandler = _baseHandler as SystemNoticeHandler;
      if (systemNoticeList.code == 1) {
        systemNoticeHandler.setSystemListData(systemNoticeList.data);
      }

    });
  }

  @override
  void getActivityList(@Body() BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getActivityList).then((onValue) {
      var activePageListBeen = ActivePageListBeen.fromJson(onValue);
      var activePageHandler = _baseHandler as ActivePageHandler;
      if (activePageListBeen.code == 1) {
        activePageHandler.setActivePageListBeen(activePageListBeen.data);
      }

    });
  }

  @override
  void editLoginPwd(@Body() UserInfoCenterHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.editLoginPwd).then((onValue) {

    });
  }

  /// 修改、设置 支付密码
  @override
  void setPaypwd(@Body() SetPaypwdHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.setPaypwd).then((onValue) {
      var payPasswordBeen = PayPasswordBeen.fromJson(onValue);
      SetCashPasswordHandler cashPasswordHandler = _baseHandler as SetCashPasswordHandler;
      if (payPasswordBeen.code == 1) {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.setPayPasswordResult(true);
        }
      } else {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.showToast(payPasswordBeen.msg);
        }
      }
    });
  }

  @override
  void modifyPaypwd(@Body() ModifyPaypwdHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.setPaypwd).then((onValue) {
      var payPasswordBeen = PayPasswordBeen.fromJson(onValue);
      ModifyLoginPasswordHandler cashPasswordHandler = _baseHandler as ModifyLoginPasswordHandler;
      if (payPasswordBeen.code == 1) {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.setPayPasswordResult(true);
        }
      } else {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.showToast(payPasswordBeen.msg);
        }
      }
    });
  }

  /**
   * 获取银行卡列表
   */
  @override
  void getBankList(@Body() BaseTokenHttpBeen tokenHttpBeen){
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getBankList).then((onValue) {
      var bankListBeen = BankListBeen.fromJson(onValue);
      BankListHandler bankListHandler = _baseHandler as BankListHandler;
      if (bankListBeen.code == 1) {
        if (bankListHandler != null) {
          bankListHandler.setBankListDataBeen(bankListBeen.data);
        }
      } else {
      }

    });
  }

  /**
   * 获取银行卡类别列表
   */
  @override
  void getBanktypeList() {
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(null, UrlUtil.getBanktypeList).then((onValue) {
      var getBankTypeList = GetBankTypeListBeen.fromJson(onValue);
      BindBankHandler bindBankHandler = _baseHandler as BindBankHandler;

      if (getBankTypeList.code == 1) {
        bindBankHandler.setBankTypeList(getBankTypeList.data);
      } else {
        bindBankHandler.showToast(getBankTypeList.msg);
      }

    });
  }

  @override
  void bindBank(@Body() BindBankHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(tokenHttpBeen.toJson(), UrlUtil.bindBank).then((onValue) {
      var getBankTypeList = GetBankTypeListBeen.fromJson(onValue);
      BindBankHandler bindBankHandler = _baseHandler as BindBankHandler;

      if (getBankTypeList.code == 1) {
        bindBankHandler.setBindBankResult(true, getBankTypeList.msg);
      } else {
        bindBankHandler.showToast(getBankTypeList.msg);
      }

    });
  }

  @override
  void getPaytypeList(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getPaytypeList).then((onValue) {
      var rechargeTypeBeen = RechargeTypeListBeen.fromJson(onValue);
      RechargeHandler rechargeHandler = _baseHandler as RechargeHandler;

      if (rechargeTypeBeen.code == 1) {
        rechargeHandler.setRechargeTypeList(rechargeTypeBeen);
      } else {
        rechargeHandler.showToast(rechargeTypeBeen.msg);
      }

    });
  }

  /**
   * 提现时查询今日提现次数 提现中总金额
   */
  ///
  @override
  void withdrawList(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.withdrawList).then((onValue) {
      var rechargeTypeBeen = WithdrawListDataBeen.fromJson(onValue);
      WithdrawHandler rechargeHandler = _baseHandler as WithdrawHandler;

      if (rechargeTypeBeen.code == 1) {
        rechargeHandler.setWithdrawListData(rechargeTypeBeen);
      } else {
        rechargeHandler.showToast(rechargeTypeBeen.msg);
      }

    });
  }
  /**
   * 提现申请
   */
  ///
  @override
  void userWithdraw(UserWithdrawHttpBeen userWithdrawHttpBeen) {
    ArgumentError.checkNotNull(userWithdrawHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(userWithdrawHttpBeen.toJson(), UrlUtil.userWithdraw).then((onValue) {
      var rechargeTypeBeen = WithdrawListDataBeen.fromJson(onValue);
      WithdrawHandler rechargeHandler = _baseHandler as WithdrawHandler;
      rechargeHandler.showToast(rechargeTypeBeen.msg);
      if (rechargeTypeBeen.code == 1) {
        rechargeHandler.userWithdrawResult(true);
      }

    });
  }

  /**
   * 代理 开户
   */
  ///
  @override
  void postOrdinaryOpenAccount(OrdinaryOpenAccountHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.addAccount).then((onValue) {
      var openAccountBeen = OrdinaryOpenAccountBeen.fromJson(onValue);
      OrdinaryOpenAccountHandler rechargeHandler = _baseHandler as OrdinaryOpenAccountHandler;

      if (openAccountBeen.code == 1) {
        rechargeHandler.showToast(openAccountBeen.msg);
        rechargeHandler.setOrdinaryOpenAccountResult(true);
      } else {
        rechargeHandler.showToast(openAccountBeen.msg);
      }

    });
  }

  /// 开户页面获取最大返点值
  void openAccount(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(tokenHttpBeen.toJson(), UrlUtil.openAccount).then((onValue) {
      var openAccountBeen = OpenAccountIntervalBeen.fromJson(onValue);
      OpenAccountIntervalHandler rechargeHandler = _baseHandler as OpenAccountIntervalHandler;

      if (openAccountBeen.code == 1) {
        rechargeHandler.setOpenAccountIntervalBeen(openAccountBeen);
      } else {
        rechargeHandler.showToast(openAccountBeen.msg);
      }

    });
  }

  /**
   * 创建开户链接
   */
  ///
  @override
  void postLinkOpenAccount(LinkOpenAccountHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.addAccountLink).then((onValue) {
      var openAccountBeen = LinkOpenAccountBeen.fromJson(onValue);
      LinkOpenAccountHandler rechargeHandler = _baseHandler as LinkOpenAccountHandler;

      if (openAccountBeen.code == 1) {
        rechargeHandler.showToast(openAccountBeen.msg);
        rechargeHandler.setLinkOpenAccountResult(true);
      } else {
        rechargeHandler.showToast(openAccountBeen.msg);
      }

    });
  }

  /**
   * 获取链接开户地址列表
   */
  @override
  void getLinkAccountList(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.getLinkAccountList).then((onValue) {
      var linkListBeen = LinkAccountListDataBeen.fromJson(onValue);
      LinkManagerHandler linkManagerHandler = _baseHandler as LinkManagerHandler;

      if (linkListBeen.code == 1) {
        linkManagerHandler.setLinkAccountList(linkListBeen.data);
      } else {
        linkManagerHandler.showToast(linkListBeen.msg);
      }

    });
  }

  /// 删除链接开户地址
  @override
  void delLinkAccount(DelLinkAccountHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.delLinkAccount).then((onValue) {
      var linkListBeen = LinkAccountListDataBeen.fromJson(onValue);
      LinkManagerHandler linkManagerHandler = _baseHandler as LinkManagerHandler;
      linkManagerHandler.showToast(linkListBeen.msg);
      if (linkListBeen.code == 1) {
        linkManagerHandler.setDelLinkAccount(true);
      }

    });
  }

  /// 团队投注
  @override
  void teamBettingList(TeamBettingListHttpBeen teamBettingListHttpBeen) {
    ArgumentError.checkNotNull(teamBettingListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(teamBettingListHttpBeen.toJson(), UrlUtil.teamBettingList).then((onValue) {
      var teamBettingBeen = TeamBettingBeen.fromJson(onValue);
      TeamBettingHandler teamBettingHandler = _baseHandler as TeamBettingHandler;

      if (teamBettingBeen.code == 1) {
        teamBettingHandler.setTeamBettingBeen(teamBettingBeen);
      } else {
        teamBettingHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队账变
  @override
  void teamMoneyLog(TeamAccountChangeHttpBeen teamBettingListHttpBeen) {
    ArgumentError.checkNotNull(teamBettingListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(teamBettingListHttpBeen.toJson(), UrlUtil.teamMoneyLog).then((onValue) {
      var teamBettingBeen = TeamAccountChangeBeen.fromJson(onValue);
      TeamAccountChangeHandler teamBettingHandler = _baseHandler as TeamAccountChangeHandler;

      if (teamBettingBeen.code == 1) {
        teamBettingHandler.setTeamAccountChangeBeen(teamBettingBeen);
      } else {
        teamBettingHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队充值记录
  @override
  void rechargeList(RechargeListHttpBeen rechargeListHttpBeen) {
    ArgumentError.checkNotNull(rechargeListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(rechargeListHttpBeen.toJson(), UrlUtil.rechargeList).then((onValue) {
      var teamBettingBeen = TeamRechargeRecordBeen.fromJson(onValue);
      TeamRechargeRecordHandler teamRechargeRecordHandler = _baseHandler as TeamRechargeRecordHandler;

      if (teamBettingBeen.code == 1) {
        teamRechargeRecordHandler.setTeamRechargeRecordBeen(teamBettingBeen);
      } else {
        teamRechargeRecordHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队会员列表
  @override
  void userlist(MemberManagerHttpBeen managerHttpBeen) {
    ArgumentError.checkNotNull(managerHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(managerHttpBeen.toJson(), UrlUtil.userlist).then((onValue) {
      var teamBettingBeen = MemberManagerBeen.fromJson(onValue);
      MemberManagerHandler teamRechargeRecordHandler = _baseHandler as MemberManagerHandler;

      if (teamBettingBeen.code == 1) {
        teamRechargeRecordHandler.setMemberManagerBeen(teamBettingBeen);
      } else {
        teamRechargeRecordHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队总览
  @override
  void teamAll(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.teamAll).then((onValue) {
      var teamOverviewBeen = TeamOverviewBeen.fromJson(onValue);
      TeamOverviewHandler teamOverviewHandler = _baseHandler as TeamOverviewHandler;

      if (teamOverviewBeen.code == 1) {
        teamOverviewHandler.setTeamOverviewBeen(teamOverviewBeen);
      } else {
        teamOverviewHandler.showToast(teamOverviewBeen.msg);
      }

    });
  }

  /// 团队列表
  @override
  void teamList(TeamReportFormHttpBeen reportFormHttpBeen) {
    ArgumentError.checkNotNull(reportFormHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(reportFormHttpBeen.toJson(), UrlUtil.teamList).then((onValue) {
      var teamReportBeen = TeamReportFormBeen.fromJson(onValue);
      TeamReportFormHandler teamOverviewHandler = _baseHandler as TeamReportFormHandler;

      if (teamReportBeen.code == 1) {
        teamOverviewHandler.setTeamReportFormBeen(teamReportBeen);
      } else {
        teamOverviewHandler.showToast(teamReportBeen.msg);
      }

    });
  }

  /// 我的分红
  @override
  void myFh(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.myFh).then((onValue) {
      var teamOverviewBeen = AgencyBonusBeen.fromJson(onValue);
      AgencyBonusHandler teamOverviewHandler = _baseHandler as AgencyBonusHandler;

      if (teamOverviewBeen.code == 1) {
        teamOverviewHandler.setAgencyBonusBeen(teamOverviewBeen);
      } else {
        teamOverviewHandler.showToast(teamOverviewBeen.msg);
      }

    });
  }

  /// 历史分红
  @override
  void userFh(UserFhHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.userFh).then((onValue) {
      var teamOverviewBeen = AgencyBonusHistoryBeen.fromJson(onValue);
      AgencyBonusHandler teamOverviewHandler = _baseHandler as AgencyBonusHandler;

      if (teamOverviewBeen.code == 1) {
        teamOverviewHandler.setAgencyBonusHistoryBeen(teamOverviewBeen);
      } else {
        teamOverviewHandler.showToast(teamOverviewBeen.msg);
      }

    });
  }

  /// 广东11 选 5

  /**
   * 玩法获取
   */
  @override
  void getPlay(BaseTokenHttpBeen playMode) {
    ArgumentError.checkNotNull(playMode, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(playMode.toJson(), UrlUtil.getPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);

    });
  }

  @override
  void gdBets(CalculationBettingNumHttpBeen bettingNumHttpBeen) {
    ArgumentError.checkNotNull(bettingNumHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(bettingNumHttpBeen.toJson(), UrlUtil.gdBets).then((onValue) {
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      CalculationBettingNumHandler linkManagerHandler = _baseHandler as CalculationBettingNumHandler;
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 下注
  @override
  void orderAdd(CalculationBettingNumHttpBeen bettingNumHttpBeen) {
    ArgumentError.checkNotNull(bettingNumHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(bettingNumHttpBeen.toJson(), UrlUtil.orderAdd).then((onValue) {
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      CalculationBettingNumHandler linkManagerHandler = _baseHandler as CalculationBettingNumHandler;
      linkManagerHandler.showToast(bettingNum.msg);
      if (bettingNum.code == 1) {
        linkManagerHandler.multipleSuccess(true);
      }
    });
  }

  /// 彩票种类
  @override
  void lotteryList(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.lotteryList).then((onValue) {
      var bettingNum = LotteryTypeDataBeen.fromJson(onValue);
      GameHallHandler linkManagerHandler = _baseHandler as GameHallHandler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setLotteryTypeData(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 开奖列表
  @override
  void kjlogList(OpenLotteryListHttpBeen openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.kjlogList).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      LotteryNum11Choice5Handler linkManagerHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setOpenLotteryListData(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 彩票开奖信息（下期时间）
  @override
  void getApi(CpOpenLotteryInfoHttp openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.getApi).then((onValue) {
      var bettingNum = CpOpenLotteryDataInfoBeen.fromJson(onValue);
      LotteryNum11Choice5Handler linkManagerHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setOpenLotteryListInfoData(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 彩票开奖信息
  @override
  void getApiHome(CpOpenLotteryInfoHttp openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.getApi).then((onValue) {
      var bettingNum = LotteryCenterBeen.fromJson(onValue);
      LotteryCenterHandler linkManagerHandler = _baseHandler as LotteryCenterHandler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setLotteryCenterBeen(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 订单撤销
  void delOrder(DelOrderHttpBeen delOrderHttpBeen) {
    ArgumentError.checkNotNull(delOrderHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(delOrderHttpBeen.toJson(), UrlUtil.delOrder).then((onValue) {
      var bettingNum = LotteryCenterBeen.fromJson(onValue);
      GetBettingRecordListHandler linkManagerHandler = _baseHandler as GetBettingRecordListHandler;
      linkManagerHandler.showToast(bettingNum.msg);
      if (bettingNum.code == 1) {
        //linkManagerHandler.setLotteryCenterBeen(bettingNum);
      } else {

      }

    });
  }

  /// 再来一单 (app)
  void orderOnce(@Body() OrderOnceHttpBeen orderOnceHttpBeen) {
    ArgumentError.checkNotNull(orderOnceHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(orderOnceHttpBeen.toJson(), UrlUtil.orderOnce).then((onValue) {
      var bettingNum = LotteryCenterBeen.fromJson(onValue);
      GetBettingRecordListHandler linkManagerHandler = _baseHandler as GetBettingRecordListHandler;
      linkManagerHandler.showToast(bettingNum.msg);
      if (bettingNum.code == 1) {
        linkManagerHandler.getOrderOnceResult(true);
      }

    });
  }

  /**
   * 个人投注记录
   */
  ///
  @override
  void bettingList(GetBettingRecordListHttpBeen openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.bettingList).then((onValue) {
      var bettingNum = GetBettingRecordBeen.fromJson(onValue);
      GetBettingRecordListHandler bettingRecordListHandler = _baseHandler as GetBettingRecordListHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setGetBettingRecordData(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 个人账变记录
   */
  ///
  void moneyLog(UserAccountChangeRecordHttpBeen openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.moneyLog).then((onValue) {
      var bettingNum = AccountChangeRecordBeen.fromJson(onValue);
      AccountChangeRecordHandler bettingRecordListHandler = _baseHandler as AccountChangeRecordHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setAccountChangeRecord(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 获取提现记录
   */
  ///
  @override
  void withdraw(UserWithdrawRecordHttpBeen withdrawRecordHttpBeen) {
    ArgumentError.checkNotNull(withdrawRecordHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(withdrawRecordHttpBeen.toJson(), UrlUtil.withdraw).then((onValue) {
      var bettingNum = UserWithdrawRecordBeen.fromJson(onValue);
      UserWithdrawRecordHandler bettingRecordListHandler = _baseHandler as UserWithdrawRecordHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setUserWithdrawRecordBeen(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 个人报表
   */
  ///
  void userReport(UserReportHttpBeen userReportHttpBeen) {
    ArgumentError.checkNotNull(userReportHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(userReportHttpBeen.toJson(), UrlUtil.userReport).then((onValue) {
      var bettingNum = UserReportBeen.fromJson(onValue);
      LotteryReportHandler bettingRecordListHandler = _baseHandler as LotteryReportHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setUserReportDataBeen(bettingNum.data);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 越南 河内一分彩
   */
  ///
  @override
  void hanoiOneGetPlay(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneGetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);

    });
  }

  /// 计算注数
  @override
  void hanoiOneGetGDBets(VietnamHanoiHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneGetGDBets).then((onValue) {
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      VietnamHanoiBettingHandler linkManagerHandler = _baseHandler as VietnamHanoiBettingHandler;
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 河内一分彩 下注
  @override
  void hanoiOneGetOrderAdd(VietnamHanoiHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneGetOrderAdd).then((onValue) {
      var jsonBeen = JsonBeen.fromJson(onValue);
      VietnamHanoiBettingHandler linkManagerHandler = _baseHandler as VietnamHanoiBettingHandler;
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }

    });
  }

  /// 获取下期开奖时间
  @override
  void hanoiOneGetKjTime(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneGetKjTime).then((onValue) {
      VietnamHanoiBettingHandler linkManagerHandler = _baseHandler as VietnamHanoiBettingHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  // 越南河内1分彩 开奖记录
  void hanoiOneKjLog_LotteryList(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setOpenLotteryListData(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 越南河内1分彩 开奖记录
  void hanoiOneKjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      VietnamHanoiBettingHandler bettingRecordListHandler = _baseHandler as VietnamHanoiBettingHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setAccountChangeRecord(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 单号走势
  void hanoiOneOddNumber(HanoiOneLotterySingleTrendHttpBeen openAccountHttpBeen){
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneOddNumber).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = TrendHanoiOneLotterySingleBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        linkManagerHandler.setTrendSingleOneLotteryBeen(trendHanoiBeen.data);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }

  ///多号走势
  void hanoiOneMultipleNumbers( HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneMultipleNumbers).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = TrendHanoiOneLotteryMoreBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          reDataBeen.moreNum = moreBeen.num;
          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }

  ///单双走势
  void hanoiOneSingleDouble(HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneSingleDouble).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = TrendSingleDoubleBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          List<TrendSingleDoubleDataNumBeen> num = moreBeen.num;
          List<String> singleDoubleNumList = new List();
          List<String> singleDoubleNumStr = new List();
          num?.forEach((numStr) {
            singleDoubleNumList.add(numStr.code);
            singleDoubleNumStr.add(numStr.ds);
          });
          reDataBeen.singleDoubleNum = singleDoubleNumList;
          reDataBeen.singleDoubleStr = singleDoubleNumStr;
          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }

  ///大小走势
  void hanoiOneMaxMin(HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneMaxMin).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = TrendSingleDoubleBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          List<TrendSingleDoubleDataNumBeen> num = moreBeen.num;
          List<String> singleDoubleNumList = new List();
          List<String> singleDoubleNumStr = new List();
          num?.forEach((numStr) {
            singleDoubleNumList.add(numStr.code);
            singleDoubleNumStr.add(numStr.dx);
          });
          reDataBeen.singleDoubleNum = singleDoubleNumList;
          reDataBeen.singleDoubleStr = singleDoubleNumStr;
          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }

  ///五星和值
  void hanoiOneFiveValue(HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneFiveValue).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = TrendFiveSumBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          reDataBeen.sum = "${moreBeen.sum}";
          reDataBeen.dx = moreBeen.dx;
          reDataBeen.ds = moreBeen.ds;

          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }

  ///各类和值
  void hanoiOneVariousSum(HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneVariousSum).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = VariousSumBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          reDataBeen.qe = "${moreBeen.qe}";
          reDataBeen.qs = "${moreBeen.qs}";
          reDataBeen.zs = "${moreBeen.zs}";
          reDataBeen.hs = "${moreBeen.hs}";
          reDataBeen.he = "${moreBeen.he}";

          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }

  ///各类跨度
  void hanoiOneVariousSpan(HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneVariousSpan).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = VariousSumBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          reDataBeen.qe = "${moreBeen.qe}";
          reDataBeen.qs = "${moreBeen.qs}";
          reDataBeen.zs = "${moreBeen.zs}";
          reDataBeen.hs = "${moreBeen.hs}";
          reDataBeen.he = "${moreBeen.he}";

          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }


  ///龙虎和
  void hanoiOneDragonTiger(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneDragonTiger).then((onValue) {
      TrendHanoiOneLotteryHandler linkManagerHandler = _baseHandler as TrendHanoiOneLotteryHandler;
      var  trendHanoiBeen = DragonTigerBeen.fromJson(onValue);
      if (trendHanoiBeen.code == 1) {
        List<TrendHanoiOneLotterySingleReDataBeen> dataTrendHanoi = new List();
        trendHanoiBeen.data?.forEach((moreBeen) {
          TrendHanoiOneLotterySingleReDataBeen reDataBeen = new TrendHanoiOneLotterySingleReDataBeen();
          reDataBeen.pre_draw_issue = moreBeen.pre_draw_issue;
          reDataBeen.pre_draw_code = moreBeen.pre_draw_code;
          reDataBeen.pre_draw_time = moreBeen.pre_draw_time;
          reDataBeen.wq = "${moreBeen.wq}";
          reDataBeen.wb = "${moreBeen.wb}";
          reDataBeen.ws = "${moreBeen.ws}";
          reDataBeen.wg = "${moreBeen.wg}";
          reDataBeen.qb = "${moreBeen.qb}";
          reDataBeen.qs = "${moreBeen.qs}";
          reDataBeen.qg = "${moreBeen.qg}";
          reDataBeen.bs = "${moreBeen.bs}";
          reDataBeen.bg = "${moreBeen.bg}";
          reDataBeen.sg = "${moreBeen.sg}";

          dataTrendHanoi.add(reDataBeen);
        });

        linkManagerHandler.setTrendSingleOneLotteryBeen(dataTrendHanoi);
      } else {
        linkManagerHandler.showToast(trendHanoiBeen.msg);
      }
    });
  }


  /**
   * 河内5分彩
   */
  ///
  @override
  void hanoi5GetPlay(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoi5GetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);

    });
  }

  /// 计算注数
  @override
  void hanoi5GetGDBets(VietnamHanoiHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoi5GetGDBets).then((onValue) {
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      VietnamHanoiBettingHandler linkManagerHandler = _baseHandler as VietnamHanoiBettingHandler;
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 河内一分彩 下注
  @override
  void hanoi5GetOrderAdd(VietnamHanoiHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoi5GetOrderAdd).then((onValue) {
      var jsonBeen = JsonBeen.fromJson(onValue);
      VietnamHanoiBettingHandler linkManagerHandler = _baseHandler as VietnamHanoiBettingHandler;
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }

    });
  }

  /// 获取下期开奖时间
  @override
  void hanoi5GetKjTime(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoi5GetKjTime).then((onValue) {
      VietnamHanoiBettingHandler linkManagerHandler = _baseHandler as VietnamHanoiBettingHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  // 河内5分彩 开奖记录
  void hanoi5KjLog_LotteryList(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoiOneKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setOpenLotteryListData(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 河内5分彩 开奖记录
  void hanoi5KjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.hanoi5KjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      VietnamHanoiBettingHandler bettingRecordListHandler = _baseHandler as VietnamHanoiBettingHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setAccountChangeRecord(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 腾讯分分彩
   */
  /// 腾讯分分彩 开奖记录
  void tencentKjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.tencentKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is TencentCnetBettingHandler) {
        TencentCnetBettingHandler bettingRecordListHandler = _baseHandler as TencentCnetBettingHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 腾讯分分彩 开奖记录
  void tencentKjLog_Limit(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.tencentKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (_baseHandler is LotteryNum11Choice5Handler) {

      }

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setOpenLotteryListData(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯分分彩 玩法获取
  void tencentGetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencentGetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 腾讯分分彩 开奖时间
  void tencentGetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencentGetKjtime).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯分分彩 计算注数
  void tencentGdBets(TencentHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencentGdBets).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯分分彩 下注接口
  void tencentOrderAdd(TencentHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencentGdBets).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }


  /**
   * 腾讯5分彩
   */
  /// 腾讯5分彩 开奖记录
  void tencent5KjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.tencent5KjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is TencentCnetBettingHandler) {
        TencentCnetBettingHandler bettingRecordListHandler = _baseHandler as TencentCnetBettingHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 腾讯5分彩 玩法获取
  void tencent5GetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent5GetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 腾讯5分彩 开奖时间
  void tencent5GetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent5GetKjtime).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯5分彩 计算注数
  void tencent5GdBets(TencentHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent5GdBets).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯5分彩 下注接口
  void tencent5OrderAdd(TencentHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent5OrderAdd).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }


  /**
   * 腾讯10分彩
   */
  /// 腾讯10分彩 开奖记录
  void tencent10KjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.tencent10KjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is TencentCnetBettingHandler) {
        TencentCnetBettingHandler bettingRecordListHandler = _baseHandler as TencentCnetBettingHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 腾讯10分彩 玩法获取
  void tencent10GetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent10GetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 腾讯10分彩 开奖时间
  void tencent10GetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent10GetKjtime).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯10分彩 计算注数
  void tencent10GdBets(TencentHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent10GdBets).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 腾讯10分彩 下注接口
  void tencent10OrderAdd(TencentHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.tencent10OrderAdd).then((onValue) {
      TencentCnetBettingHandler linkManagerHandler = _baseHandler as TencentCnetBettingHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }


  /**
   * 奇趣一分彩
   */
  /// 奇趣一分彩 开奖记录
  void oddInterestKjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.oddInterestKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is OddInterestHandler) {
        OddInterestHandler bettingRecordListHandler = _baseHandler as OddInterestHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 奇趣一分彩 玩法获取
  void oddInterestGetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterestGetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 奇趣一分彩 开奖时间
  void oddInterestGetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterestGetKjtime).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 奇趣一分彩 计算注数
  void oddInterestGdBets(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterestGdBets).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 奇趣一分彩 下注接口
  void oddInterestOrderAdd(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterestOrderAdd).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }

  /**
   * 奇趣5分彩
   */
  /// 奇趣5分彩 开奖记录
  void oddInterest5KjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.oddInterest5KjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is OddInterestHandler) {
        OddInterestHandler bettingRecordListHandler = _baseHandler as OddInterestHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 奇趣5分彩 玩法获取
  void oddInterest5GetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest5GetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 奇趣5分彩 开奖时间
  void oddInterest5GetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest5GetKjtime).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 奇趣5分彩 计算注数
  void oddInterest5GdBets(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest5GdBets).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 奇趣5分彩 下注接口
  void oddInterest5OrderAdd(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest5OrderAdd).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }


  /**
   * 奇趣10分彩
   */
  /// 奇趣10分彩 开奖记录
  void oddInterest10KjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.oddInterest10KjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is OddInterestHandler) {
        OddInterestHandler bettingRecordListHandler = _baseHandler as OddInterestHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 奇趣10分彩 玩法获取
  void oddInterest10GetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest10GetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 奇趣10分彩 开奖时间
  void oddInterest10GetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest10GetKjtime).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 奇趣10分彩 计算注数
  void oddInterest10GdBets(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest10GdBets).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 奇趣10分彩 下注接口
  void oddInterest10OrderAdd(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.oddInterest10OrderAdd).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }

  /**
   * 幸运飞艇
   */
  /// 幸运飞艇 开奖记录
  void luckyAirshipKjLog(OpenLotteryListHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.luckyAirshipKjLog).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);

      if (_baseHandler is LotteryNum11Choice5Handler) {
        LotteryNum11Choice5Handler bettingRecordListHandler = _baseHandler as LotteryNum11Choice5Handler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setOpenLotteryListData(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }

      if (_baseHandler is OddInterestHandler) {
        OddInterestHandler bettingRecordListHandler = _baseHandler as OddInterestHandler;

        if (bettingNum.code == 1) {
          bettingRecordListHandler.setAccountChangeRecord(bettingNum);
        } else {
          bettingRecordListHandler.showToast(bettingNum.msg);
        }
      }



    });
  }

  /// 幸运飞艇 玩法获取
  void luckyAirshipGetPlay( BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.luckyAirshipGetPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);
    });
  }

  /// 幸运飞艇 开奖时间
  void luckyAirshipGetKjtime(BaseTokenHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.luckyAirshipGetKjtime).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = VietnamHanoiLotteryTimeBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.openVietnamHanoiLotteryTime(bettingNum.data.kj_time, bettingNum.data.qishu);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 幸运飞艇 计算注数
  void luckyAirshipGdBets(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.luckyAirshipGdBets).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 幸运飞艇 下注接口
  void luckyAirshipOrderAdd(OddInterestHttpBeen baseTokenHttpBeen) {
    ArgumentError.checkNotNull(baseTokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(baseTokenHttpBeen.toJson(), UrlUtil.luckyAirshipOrderAdd).then((onValue) {
      OddInterestHandler linkManagerHandler = _baseHandler as OddInterestHandler;
      var jsonBeen = JsonBeen.fromJson(onValue);
      if (jsonBeen.code == 1) {
        var bettingNum = CalculationBettingNumBeen.fromJson(onValue);

        if (bettingNum.code == 1) {
          linkManagerHandler.bettingSuccessResult();
        } else {
          linkManagerHandler.showToast(bettingNum.msg);
        }
      } else {
        linkManagerHandler.showToast(jsonBeen.msg);
      }
    });
  }

}
