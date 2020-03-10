
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/GetBettingRecordListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CpOpenLotteryInfoHttp.dart';
import 'package:flutter_lisheng_entertainment/model/http/order/DelOrderHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/order/OrderOnceHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_record/UserAccountChangeRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/VietnamHanoiHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/hanoi_trend/HanoiOneLotteryMoreTrendHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/hanoi_trend/HanoiOneLotterySingleTrendHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/net/AccountChangeRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/GetBettingRecordListHandler.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'GameHallHandler.dart';
import 'PlayMode11Choice5Handler.dart';
import 'TrendHanoiOneLotteryHandler.dart';
import 'game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'vietnam_hanoi/VietnamHanoiBettingHandler.dart';

class GameService {

  static GameService get instance => _getInstance();
  static GameService _instance;

  // 私有构造函数
  GameService._internal() {
    // 初始化
  }

  static GameService _getInstance() {
    if(_instance == null) {
      _instance = new GameService._internal();
    }
    return _instance;
  }


  /**
   * 玩法获取
   */
  void getPlay(PlayMode11Choice5Handler playMode11Choice5Handler) {

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(playMode11Choice5Handler);
    apiService.getPlay(baseTokenHttpBeen);
  }

  /// 获取彩种
  void lotteryList(GameHallHandler gameHallHandler) {
    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen openAccountHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(gameHallHandler);
    apiService.lotteryList(openAccountHttpBeen);
  }

  /// 开奖记录
  void kjlogList(String lottery_id, String page, LotteryNum11Choice5Handler num11choice5handler) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), lottery_id, "30", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.kjlogList(openLotteryListHttpBeen);
  }

  /// 河内一分彩 开奖记录
  void hanoi_kjlogList( String page, LotteryNum11Choice5Handler num11choice5handler, String colorVariety) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", "30", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    if (colorVariety == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      apiService.hanoiOneKjLog_LotteryList(openLotteryListHttpBeen);
    }

    if (colorVariety == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      // 河内 5分彩
      apiService.hanoi5KjLog_LotteryList(openLotteryListHttpBeen);
    }

  }

  /// 腾讯分分彩 开奖记录
  void tencent_kjlogList( String page, LotteryNum11Choice5Handler num11choice5handler, String colorVariety) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", "30", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);

    if (colorVariety == "${Constant.GAME_NUM_5_TENCENT}") {
      apiService.tencent5KjLog(openLotteryListHttpBeen);
    }

    if (colorVariety == "${Constant.GAME_NUM_10_TENCENT}") {
      apiService.tencent10KjLog(openLotteryListHttpBeen);
    }

    if (colorVariety == "${Constant.GAME_NUM_TENCENT}") {
      apiService.tencentKjLog(openLotteryListHttpBeen);
    }

  }

  void kjlogList_Betting(String lottery_id, String page, LotteryNum11Choice5Handler num11choice5handler) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), lottery_id, "8", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.kjlogList(openLotteryListHttpBeen);
  }

  /// 奇趣一分彩 开奖记录
  void oddInterest_kjlogList( String page, LotteryNum11Choice5Handler num11choice5handler, String colorVariety) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", "30", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);

    if (colorVariety == "${Constant.GAME_NUM_ODD_INTEREST}") {
      apiService.oddInterestKjLog(openLotteryListHttpBeen);
    }

    if (colorVariety == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      apiService.oddInterest5KjLog(openLotteryListHttpBeen);
    }

    if (colorVariety == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      apiService.oddInterest10KjLog(openLotteryListHttpBeen);
    }
    //幸运飞艇
    if (colorVariety == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
      apiService.luckyAirshipKjLog(openLotteryListHttpBeen);
    }

  }


  void getApi(String lottery_id, LotteryNum11Choice5Handler num11choice5handler) {
    CpOpenLotteryInfoHttp openLotteryListHttpBeen = new CpOpenLotteryInfoHttp(SpUtil.getString(Constant.TOKEN), lottery_id);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.getApi(openLotteryListHttpBeen);
  }

  /// 个人投注记录
  void bettingList(GetBettingRecordListHandler bettingRecordListHandler, String lotteryId,
      String status, String startTime, String endTime, String page) {
    GetBettingRecordListHttpBeen openLotteryListHttpBeen = new GetBettingRecordListHttpBeen();
    openLotteryListHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openLotteryListHttpBeen.limit = "20";
    openLotteryListHttpBeen.lottery_id = lotteryId;
    openLotteryListHttpBeen.status = status;
    openLotteryListHttpBeen.stare_time = startTime;
    openLotteryListHttpBeen.end_time = endTime;
    openLotteryListHttpBeen.page = page;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingRecordListHandler);
    apiService.bettingList(openLotteryListHttpBeen);
  }

  /**
   * 个人账变记录
   */
  ///
  void moneyLog(AccountChangeRecordHandler changeRecordHandler,String type, int page, String startTime, String endTime) {
    UserAccountChangeRecordHttpBeen openLotteryListHttpBeen =
            new UserAccountChangeRecordHttpBeen(SpUtil.getString(Constant.TOKEN), type, "20", startTime, endTime,page);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(changeRecordHandler);
    apiService.moneyLog(openLotteryListHttpBeen);
  }

  /**
   * 越南 河内一分彩 玩法选择
   */
  ///
  void hanoiOneGetPlay(PlayMode11Choice5Handler playMode11Choice5Handler, String colorVarietyID) {

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(playMode11Choice5Handler);

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      apiService.hanoiOneGetPlay(baseTokenHttpBeen);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      //河内 5 分彩
      apiService.hanoi5GetPlay(baseTokenHttpBeen);
    }

  }

  /// 腾讯分分彩 玩法获取
  void tencentGetPlay( PlayMode11Choice5Handler playMode11Choice5Handler, String colorVarietyID) {
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(playMode11Choice5Handler);
    if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
      //腾讯5分彩
      apiService.tencent5GetPlay(baseTokenHttpBeen);
    } else {
      if (colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
        apiService.tencent10GetPlay(baseTokenHttpBeen);
      } else {
        apiService.tencentGetPlay(baseTokenHttpBeen);
      }
    }

  }

  /// 幸运飞艇 玩法获取
  void luckyAirshipPlay( PlayMode11Choice5Handler playMode11Choice5Handler, String colorVarietyID) {
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(playMode11Choice5Handler);
    if (colorVarietyID == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
      apiService.tencent5GetPlay(baseTokenHttpBeen);
    }

  }


  /**
   * 奇趣一分彩 玩法选择
   */
  ///
  void oddInterestGetPlay(PlayMode11Choice5Handler playMode11Choice5Handler, String colorVarietyID) {

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(playMode11Choice5Handler);

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
      apiService.oddInterestGetPlay(baseTokenHttpBeen);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      //奇趣 5 分彩
      apiService.oddInterest5GetPlay(baseTokenHttpBeen);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      //奇趣 10 分彩
      apiService.oddInterest10GetPlay(baseTokenHttpBeen);
    }

  }

  /// 单号走势
  void hanoiOneOddNumber(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit, String address) {

    HanoiOneLotterySingleTrendHttpBeen openAccountHttpBeen = new HanoiOneLotterySingleTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;
    openAccountHttpBeen.address = address;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneOddNumber(openAccountHttpBeen);
  }

  ///多号走势
  void hanoiOneMultipleNumbers(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit, String address) {
    HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen = new HanoiOneLotteryMoreTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;
    openAccountHttpBeen.address = address;
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneMultipleNumbers(openAccountHttpBeen);

  }

  ///单双走势
  void hanoiOneSingleDouble(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit, String address) {
    HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen = new HanoiOneLotteryMoreTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;
    openAccountHttpBeen.address = address;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneSingleDouble(openAccountHttpBeen);
  }

  ///大小走势
  void hanoiOneMaxMin(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit, String address) {
    HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen = new HanoiOneLotteryMoreTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;
    openAccountHttpBeen.address = address;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneMaxMin(openAccountHttpBeen);
  }

  ///五星和值
  void hanoiOneFiveValue(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit) {
    HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen = new HanoiOneLotteryMoreTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneFiveValue(openAccountHttpBeen);
  }

  ///各类和值
  void hanoiOneVariousSum(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit) {
    HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen = new HanoiOneLotteryMoreTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneVariousSum(openAccountHttpBeen);
  }

  ///各类跨度
  void hanoiOneVariousSpan(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler, String limit){
    HanoiOneLotteryMoreTrendHttpBeen openAccountHttpBeen = new HanoiOneLotteryMoreTrendHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.limmit = limit;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneVariousSpan(openAccountHttpBeen);
  }

  ///龙虎和
  void hanoiOneDragonTiger(TrendHanoiOneLotteryHandler trendHanoiOneLotteryHandler) {
    BaseTokenHttpBeen openAccountHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(trendHanoiOneLotteryHandler);
    apiService.hanoiOneDragonTiger(openAccountHttpBeen);
  }

  /// 订单撤销
  void delOrder(BuildContext context,GetBettingRecordListHandler getBettingRecordListHandler, String id) {
    DelOrderHttpBeen delOrderHttpBeen = new DelOrderHttpBeen();
    delOrderHttpBeen.id = id;
    delOrderHttpBeen.token = SpUtil.getString(Constant.TOKEN);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(getBettingRecordListHandler);
    apiService.setBuildContext(context);
    apiService.delOrder(delOrderHttpBeen);
  }

  /// 再来一单 (app)
  void orderOnce(BuildContext context,GetBettingRecordListHandler getBettingRecordListHandler, String id) {
    OrderOnceHttpBeen orderOnceHttpBeen = new OrderOnceHttpBeen(SpUtil.getString(Constant.TOKEN), id);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(getBettingRecordListHandler);
    apiService.setBuildContext(context);
    apiService.orderOnce(orderOnceHttpBeen);
  }
}