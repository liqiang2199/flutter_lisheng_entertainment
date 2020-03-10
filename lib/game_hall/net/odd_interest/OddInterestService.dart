
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/odd_interest/OddInterestHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import '../GameCommonService.dart';
import 'OddInterestHandler.dart';

class OddInterestService extends GameCommonService {

  static OddInterestService get instance => _getInstance();
  static OddInterestService _instance;

  // 私有构造函数
  OddInterestService._internal() {
    // 初始化
  }

  static OddInterestService _getInstance() {
    if(_instance == null) {
      _instance = new OddInterestService._internal();
    }
    return _instance;
  }


  /// 计算注数
  /**
   * isTwoListCpNum 是否是两个 （后二或者 前二）
   * 前三/前三直选/复式（计算注数）
   * 中三/中三直选/复式（计算注数）
   * 后三/后三直选/复式（计算注数）
   * 前二/直选/复试（计算注数）
   * 后二/直选/复试（计算注数）
   */
  ///
  void hanoiOneGetGDBets(BuildContext context,OddInterestHandler hanoiBettingHandler
      , List<String> oneNum, List<String> twoNum,
      List<String> threeNum, String playID, bool isTwoListCpNum
      , bool isBetting, int multiple, String colorVarietyID) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (twoNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (!isTwoListCpNum) {
      if (threeNum.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
    }

    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.one_num = stringAppend(oneNum);
    openAccountHttpBeen.two_num = stringAppend(twoNum);

    if (!isTwoListCpNum) {
      openAccountHttpBeen.three_num = stringAppend(threeNum);
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
  }

  /**
   * 后四
   */
  ///
  void oddInterestLaterFourGetGDBets(BuildContext context,OddInterestHandler hanoiBettingHandler
      , List<String> oneNum, List<String> twoNum,
      List<String> threeNum, List<String> fourNum, String playID, bool isTwoListCpNum
      , bool isBetting, int multiple, String colorVarietyID) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (twoNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (threeNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (fourNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.two_num = stringAppend(oneNum);
    openAccountHttpBeen.three_num = stringAppend(twoNum);
    openAccountHttpBeen.four_num = stringAppend(threeNum);
    openAccountHttpBeen.five_num = stringAppend(fourNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
  }

  /**
   * 前三/前三直选/直选和值（计算注数）
   * 三前三/前三直选/直选跨度（计算注数）
   * 前三/前三组选/组三（计算注数）
   * 前三/前三组选/组六（计算注数）
   * 前三/前三组选/组选和值（计算注数）
   * 前三/前三其他 /和值尾数（计算注数）
   */
  ///
  void hanoiOneGetGDBetsSpan(BuildContext context,OddInterestHandler hanoiBettingHandler
      , List<String> oneNum, String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);

  }

  /// 随机单式
  void hanoiOneGetGDBetsRandomSingle(BuildContext context,OddInterestHandler hanoiBettingHandler
      ,String oneNum, String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    oneNum = oneNum.replaceAll(",", ";");

    openAccountHttpBeen.data_num = oneNum;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);


  }

  /// 输入单式
  void hanoiOneGetGDBetsEditSingle(BuildContext context,OddInterestHandler hanoiBettingHandler
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

    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringSingleAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);


  }

  /**
   *  任选复式
   *  如果是定位胆 只要选中一注都能进行投注
   */
  ///
  void hanoiOneGetGDBetsOptional(BuildContext context,OddInterestHandler hanoiBettingHandler, List<String> oneNum
      , List<String> twoNum, List<String> threeNum, List<String> four_num, List<String> five_num
      , String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (playID != "206") {
      if (oneNum.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
      if (twoNum.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
      if (threeNum.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
      if (four_num.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
      if (five_num.length <= 0) {
        if (isBetting) {
          hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
    }


    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.one_num = stringAppend(oneNum);
    openAccountHttpBeen.two_num = stringAppend(twoNum);
    openAccountHttpBeen.three_num = stringAppend(threeNum);
    openAccountHttpBeen.four_num = stringAppend(four_num);
    openAccountHttpBeen.five_num = stringAppend(five_num);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);

  }

  /**
   * 任选组选(非单式)
   */
  ///
  void hanoiOneGetGDBetsOptionalGroup(BuildContext context,OddInterestHandler hanoiBettingHandler, List<String> oneNum
      , List<String> bitsNum,  String playID, bool isSingle, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (bitsNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    if (isSingle) {
      openAccountHttpBeen.data_num = stringSingleAppend(oneNum);
    } else {
      openAccountHttpBeen.data_num = stringAppend(oneNum);
    }

    openAccountHttpBeen.data_address = stringAppend(bitsNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);

  }

  /**
   * 任选（单式)
   */
  ///
  void hanoiOneGetGDBetsOptionalSingle(BuildContext context,OddInterestHandler hanoiBettingHandler, List<String> oneNum
      , List<String> bitsNum,  String playID, bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (bitsNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringAppend(oneNum);
    openAccountHttpBeen.data_address = stringAppend(bitsNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);


  }

  /**
   * 新龙虎
   */
  ///
  void hanoiOneGetGDBetsDragonTiger(BuildContext context,OddInterestHandler hanoiBettingHandler
      , List<String> dragonTiger,  String playID
      , bool isBetting, int multiple, String colorVarietyID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (dragonTiger.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    OddInterestHttpBeen openAccountHttpBeen = new OddInterestHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
  }

  _postLotteryBettingNum(BuildContext context,OddInterestHttpBeen openAccountHttpBeen, ApiService apiService
      , bool isBetting, int multiple, String colorVarietyID) {
    if (isBetting) {
      openAccountHttpBeen.multiple = multiple;
      apiService.setBuildContext(context);
      if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
        apiService.oddInterestOrderAdd(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
        apiService.oddInterest5OrderAdd(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
        apiService.oddInterest10OrderAdd(openAccountHttpBeen);
      }

    } else {
      if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
        apiService.oddInterestGdBets(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
        apiService.oddInterest5GdBets(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
        apiService.oddInterest10GdBets(openAccountHttpBeen);
      }
    }
  }

  /// 获取开奖时间
  void oddInterestGetKjTime(OddInterestHandler hanoiBettingHandler
      , String colorVarietyID) {

    BaseTokenHttpBeen openAccountHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
      apiService.oddInterestGetKjtime(openAccountHttpBeen);
    }
    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      apiService.oddInterest5GetKjtime(openAccountHttpBeen);
    }
    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      apiService.oddInterest10GetKjtime(openAccountHttpBeen);
    }

  }

  /// 越南河内1分彩 开奖记录
  void oddInterestKjLog(OddInterestHandler bettingHandler, String page
      , String limit, String colorVarietyID) {
    OpenLotteryListHttpBeen openAccountHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", limit, page);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingHandler);
    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
      apiService.oddInterestKjLog(openAccountHttpBeen);
    }
    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      apiService.oddInterest5KjLog(openAccountHttpBeen);
    }
    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      apiService.oddInterest10KjLog(openAccountHttpBeen);
    }

  }

}