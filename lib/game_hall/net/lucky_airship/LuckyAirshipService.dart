
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/lucky_airship/LuckyAirshipHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import '../GameCommonService.dart';
import 'LuckyAirshipHandler.dart';

class LuckyAirshipService extends GameCommonService {

  static LuckyAirshipService get instance => _getInstance();
  static LuckyAirshipService _instance;

  // 私有构造函数
  LuckyAirshipService._internal() {
    // 初始化
  }

  static LuckyAirshipService _getInstance() {
    if(_instance == null) {
      _instance = new LuckyAirshipService._internal();
    }
    return _instance;
  }



  /// 输入单式
  void luckyAirshipGetGDBetsEditSingle(BuildContext context,LuckyAirshipHandler hanoiBettingHandler
      ,List<String> oneNum, String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    LuckyAirshipHttpBeen openAccountHttpBeen = new LuckyAirshipHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringSingleAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);


  }

  /**
   *
   *  如果是定位胆 只要选中一注都能进行投注
   */
  ///
  void hanoiOneGetGDBetsOptional(BuildContext context,LuckyAirshipHandler hanoiBettingHandler,List<List<String>> numList
      , String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (numList.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    LuckyAirshipHttpBeen openAccountHttpBeen = new LuckyAirshipHttpBeen();
    for (int i = 0; i < numList.length; i ++) {
      var numListSizeOnly = numList[i];
      if (numListSizeOnly.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          break;
        }
        break;
      }

      if (i == 0) {
        openAccountHttpBeen.one_num = stringAppend(numListSizeOnly);
      }
      if (i == 1) {
        openAccountHttpBeen.two_num = stringAppend(numListSizeOnly);
      }
      if (i == 2) {
        openAccountHttpBeen.three_num = stringAppend(numListSizeOnly);
      }
      if (i == 3) {
        openAccountHttpBeen.four_num = stringAppend(numListSizeOnly);
      }
      if (i == 4) {
        openAccountHttpBeen.five_num = stringAppend(numListSizeOnly);
      }
      if (i == 5) {
        openAccountHttpBeen.six_num = stringAppend(numListSizeOnly);
      }
      if (i == 6) {
        openAccountHttpBeen.seven_num = stringAppend(numListSizeOnly);
      }
      if (i == 7) {
        openAccountHttpBeen.eight_num = stringAppend(numListSizeOnly);
      }
      if (i == 8) {
        openAccountHttpBeen.nine_num = stringAppend(numListSizeOnly);
      }
      if (i == 9) {
        openAccountHttpBeen.ten_num = stringAppend(numListSizeOnly);
      }
    }

    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);

  }


  /**
   * 前一 复式
   */
  ///
  void luckyAirshipOneGetGDBets(BuildContext context,LuckyAirshipHandler hanoiBettingHandler, List<String> oneNum
      ,  String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    LuckyAirshipHttpBeen openAccountHttpBeen = new LuckyAirshipHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringAppend(oneNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);


  }

  /**
   * 大小  单双   龙虎
   */
  ///
  void luckyAirshipDragonTigerGetGDBets(BuildContext context,LuckyAirshipHandler hanoiBettingHandler, List<String> oneNum
      ,  String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    LuckyAirshipHttpBeen openAccountHttpBeen = new LuckyAirshipHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.num_type = stringAppend(oneNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);


  }


  _postLotteryBettingNum(BuildContext context,LuckyAirshipHttpBeen openAccountHttpBeen, ApiService apiService
      , bool isBetting, int multiple, String colorVarietyID) {
    if (isBetting) {
      openAccountHttpBeen.multiple = multiple;
      apiService.setBuildContext(context);
      if (colorVarietyID == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
        apiService.luckyAirshipOrderAdd(openAccountHttpBeen);
      }

    } else {
      if (colorVarietyID == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
        apiService.luckyAirshipGdBets(openAccountHttpBeen);
      }
    }
  }

  /// 获取开奖时间
  void luckyAirshipGetKjTime(LuckyAirshipHandler hanoiBettingHandler
      , String colorVarietyID) {

    BaseTokenHttpBeen openAccountHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    if (colorVarietyID == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
      apiService.luckyAirshipGetKjtime(openAccountHttpBeen);
    }

  }

  ///  开奖记录
  void luckyAirshipKjLog(LuckyAirshipHandler bettingHandler, String page
      , String limit, String colorVarietyID) {
    OpenLotteryListHttpBeen openAccountHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", limit, page);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingHandler);
    if (colorVarietyID == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
      apiService.luckyAirshipKjLog(openAccountHttpBeen);
    }

  }

}