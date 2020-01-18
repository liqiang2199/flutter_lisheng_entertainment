
import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/GetBettingRecordListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CpOpenLotteryInfoHttp.dart';
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

  /// 河内一分彩
  void hanoi_kjlogList( String page, LotteryNum11Choice5Handler num11choice5handler) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", "30", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.hanoiOneKjLog_LotteryList(openLotteryListHttpBeen);
  }

  void kjlogList_Betting(String lottery_id, String page, LotteryNum11Choice5Handler num11choice5handler) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), lottery_id, "5", page);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.kjlogList(openLotteryListHttpBeen);
  }

  void getApi(String lottery_id, LotteryNum11Choice5Handler num11choice5handler) {
    CpOpenLotteryInfoHttp openLotteryListHttpBeen = new CpOpenLotteryInfoHttp(SpUtil.getString(Constant.TOKEN), lottery_id);
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    apiService.getApi(openLotteryListHttpBeen);
  }

  /// 个人投注记录
  void bettingList(GetBettingRecordListHandler bettingRecordListHandler, String lotteryId, String status, String startTime, String endTime) {
    GetBettingRecordListHttpBeen openLotteryListHttpBeen = new GetBettingRecordListHttpBeen();
    openLotteryListHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openLotteryListHttpBeen.limit = "20";
    openLotteryListHttpBeen.lottery_id = lotteryId;
    openLotteryListHttpBeen.status = status;
    openLotteryListHttpBeen.stare_time = startTime;
    openLotteryListHttpBeen.end_time = endTime;

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
   * 越南 河内一分彩
   */
  ///
  void hanoiOneGetPlay(PlayMode11Choice5Handler playMode11Choice5Handler) {

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(playMode11Choice5Handler);
    apiService.hanoiOneGetPlay(baseTokenHttpBeen);
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
}