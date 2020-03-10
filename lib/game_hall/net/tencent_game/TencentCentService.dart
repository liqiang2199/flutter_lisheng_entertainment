

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/tencent/TencentHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import '../GameCommonService.dart';
import 'TencentCnetBettingHandler.dart';

class TencentCentService extends GameCommonService{
  static TencentCentService get instance => _getInstance();
  static TencentCentService _instance;

  // 私有构造函数
  TencentCentService._internal() {
    // 初始化
  }

  static TencentCentService _getInstance() {
    if(_instance == null) {
      _instance = new TencentCentService._internal();
    }
    return _instance;
  }

  /// 腾讯分分彩 开奖记录  一分彩  5 分彩  10 分彩 //显示8期
  void tencent_kjlogList( TencentCnetBettingHandler num11choice5handler, String _colorVarietyID) {
    OpenLotteryListHttpBeen openLotteryListHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", "8", "1");
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(num11choice5handler);
    if (_colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
      apiService.tencent5KjLog(openLotteryListHttpBeen);
    }
    if (_colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
      apiService.tencent10KjLog(openLotteryListHttpBeen);
    }
    if (_colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
      apiService.tencentKjLog(openLotteryListHttpBeen);
    }

  }

  /// 腾讯分分彩 开奖时间
  void tencentGetKjtime(TencentCnetBettingHandler tencentCnetBettingHandler, String _colorVarietyID) {
    BaseTokenHttpBeen openAccountHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(tencentCnetBettingHandler);
    if (_colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
      apiService.tencent5GetKjtime(openAccountHttpBeen);
    }
    if (_colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
      apiService.tencent10GetKjtime(openAccountHttpBeen);
    }
    if (_colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
      apiService.tencentGetKjtime(openAccountHttpBeen);
    }

  }


  /// 腾讯分分彩 计算注数
  void tencentThreeGdBets(BuildContext context,TencentCnetBettingHandler tencentCnetBettingHandler, List<String> oneNum, List<String> twoNum,
      List<String> threeNum, String playID, bool isTwoListCpNum, bool isBetting, int multiple, String colorVarietyID) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        tencentCnetBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      tencentCnetBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (twoNum.length <= 0) {
      if (isBetting) {
        tencentCnetBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      tencentCnetBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (!isTwoListCpNum) {
      if (threeNum.length <= 0) {
        if (isBetting) {
          tencentCnetBettingHandler.showToast("你还没有选择号码或所选号码不全");
          return;
        }
        tencentCnetBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
        return;
      }
    }

    TencentHttpBeen baseTokenHttpBeen = new TencentHttpBeen();
    baseTokenHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    baseTokenHttpBeen.play_id = playID;

    baseTokenHttpBeen.one_num = stringAppend(oneNum);
    baseTokenHttpBeen.two_num = stringAppend(twoNum);

    if (!isTwoListCpNum) {
      baseTokenHttpBeen.three_num = stringAppend(threeNum);
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(tencentCnetBettingHandler);
//    if (isBetting) {
//      baseTokenHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(baseTokenHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(baseTokenHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(baseTokenHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(baseTokenHttpBeen);
//      }
//    }

    _postBetting(context, apiService, baseTokenHttpBeen, isBetting, multiple, colorVarietyID);

  }

  /// 重号组选 五星组选 60
  void tencentDuplicateNumberGroupChoiceGdBets(BuildContext context,TencentCnetBettingHandler tencentCnetBettingHandler
      , List<String> duplicateNum, List<String> oneNum, String playID,
      bool isTwoListCpNum, bool isBetting, int multiple, String colorVarietyID) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        tencentCnetBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      tencentCnetBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (duplicateNum.length <= 0) {
      if (isBetting) {
        tencentCnetBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      tencentCnetBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    TencentHttpBeen baseTokenHttpBeen = new TencentHttpBeen();
    baseTokenHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    baseTokenHttpBeen.play_id = playID;
    if (playID == "287" || playID == "288" || playID == "301" ||
        //5分彩
        playID == "619" || playID == "620" || playID == "631" ||
        //10分彩
        playID == "774" || playID == "775" || playID == "786") {
      // 组选 60 30  后四  组选12
      baseTokenHttpBeen.data_num = stringAppend(oneNum);
      baseTokenHttpBeen.double_num = stringAppend(duplicateNum);
    }
    if (playID == "289" || playID == "303" ||
        playID == "621" || playID == "633" ||
        playID == "776" || playID == "788") {
      // 组选 20 后四 组选 4
      baseTokenHttpBeen.data_num = stringAppend(oneNum);
      baseTokenHttpBeen.sc_num = stringAppend(duplicateNum);
    }

    if (playID == "290" || playID == "622" || playID == "777") {
      // 组选 10
      baseTokenHttpBeen.double_num = stringAppend(oneNum);
      baseTokenHttpBeen.sc_num = stringAppend(duplicateNum);
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(tencentCnetBettingHandler);
//    if (isBetting) {
//      baseTokenHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(baseTokenHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(baseTokenHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(baseTokenHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(baseTokenHttpBeen);
//      }
//    }

    _postBetting(context, apiService, baseTokenHttpBeen, isBetting, multiple, colorVarietyID);

  }

  /**
   * 前三/前三直选/直选和值（计算注数）
   * 前三/前三直选/直选跨度（计算注数）
   * 前三/前三组选/组三（计算注数）
   * 前三/前三组选/组六（计算注数）
   * 前三/前三组选/组选和值（计算注数）
   * 前三/前三其他 /和值尾数（计算注数）
   *
   * 五星 和值 大小单双
   * 后四 组选 6
   */
  ///
  void tencentGetGDBetsSpan(BuildContext context, TencentCnetBettingHandler hanoiBettingHandler,
      List<String> oneNum, String playID, bool isBetting, int multiple, String colorVarietyID ) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    if (playID == "302" || playID == "632" || playID == "787") {
      // 后四 组选 6
      openAccountHttpBeen.double_num = stringAppend(oneNum);

    } else {
      if (playID == "293" || playID == "624" || playID == "779") {
        // 五星 大小单双
        openAccountHttpBeen.sum_type = stringAppend(oneNum);
      } else {
        if (playID == "286" || playID == "618" || playID == "773") {
          // 五星 组选 120
          if (oneNum.length < 5) {
            hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
          }
          return;
        }
        openAccountHttpBeen.data_num = stringAppend(oneNum);
      }
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);
  }

  /**
   *  任选复式
   *  如果是定位胆 只要选中一注都能进行投注
   */
  ///
  void tencentFiveGetGDBetsOptional(BuildContext context,TencentCnetBettingHandler hanoiBettingHandler, List<String> oneNum
      , List<String> twoNum, List<String> threeNum, List<String> four_num,
      List<String> five_num, String playID, bool isBetting, int multiple, String colorVarietyID) {
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


    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.one_num = stringAppend(oneNum);
    openAccountHttpBeen.two_num = stringAppend(twoNum);
    openAccountHttpBeen.three_num = stringAppend(threeNum);
    openAccountHttpBeen.four_num = stringAppend(four_num);
    openAccountHttpBeen.five_num = stringAppend(five_num);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(openAccountHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(openAccountHttpBeen);
//      }
//    }

    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);

  }


  /// 后四/后四直选/复式（计算注数）
  void tencentFourGetGDBetsOptional(BuildContext context,TencentCnetBettingHandler hanoiBettingHandler, List<String> oneNum
      , List<String> twoNum, List<String> threeNum, List<String> four_num
      , String playID, bool isBetting, int multiple, String colorVarietyID) {
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
    if (four_num.length <= 0) {
      if (isBetting) {
        hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
        return;
      }
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.one_num = stringAppend(oneNum);
    openAccountHttpBeen.two_num = stringAppend(twoNum);
    openAccountHttpBeen.three_num = stringAppend(threeNum);
    openAccountHttpBeen.four_num = stringAppend(four_num);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(openAccountHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(openAccountHttpBeen);
//      }
//    }

    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);

  }

  /// 随机单式
  void tencentGetGDBetsRandomSingle(BuildContext context,TencentCnetBettingHandler hanoiBettingHandler
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


    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    oneNum = oneNum.replaceAll(",", ";");

    openAccountHttpBeen.data_num = oneNum;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(openAccountHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(openAccountHttpBeen);
//      }
//    }
    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);

  }

  /// 输入单式
  void tencentGetGDBetsEditSingle(BuildContext context,TencentCnetBettingHandler hanoiBettingHandler
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

    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringSingleAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(openAccountHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(openAccountHttpBeen);
//      }
//    }
    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);
  }

  /**
   * 任选组选(非单式)
   */
  ///
  void tencentGetGDBetsOptionalGroup(BuildContext context,TencentCnetBettingHandler hanoiBettingHandler, List<String> oneNum
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


    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
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
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(openAccountHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(openAccountHttpBeen);
//      }
//    }

    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);

  }

  /**
   * 任选（单式)
   */
  ///
  void tencentGetGDBetsOptionalSingle(BuildContext context,TencentCnetBettingHandler hanoiBettingHandler, List<String> oneNum
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


    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = stringAppend(oneNum);
    openAccountHttpBeen.data_address = stringAppend(bitsNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentOrderAdd(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5OrderAdd(openAccountHttpBeen);
//      }
//    } else {
//      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//        apiService.tencentGdBets(openAccountHttpBeen);
//      }
//      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//        apiService.tencent5GdBets(openAccountHttpBeen);
//      }
//    }

    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);

  }


  /**
   * 新龙虎
   */
  ///
  void tencentGetGDBetsDragonTiger(BuildContext context, TencentCnetBettingHandler hanoiBettingHandler
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


    TencentHttpBeen openAccountHttpBeen = new TencentHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postBetting(context, apiService, openAccountHttpBeen, isBetting, multiple, colorVarietyID);
  }

  _postBetting(BuildContext context, ApiService apiService
      , TencentHttpBeen openAccountHttpBeen,bool isBetting,int multiple, String colorVarietyID) {
    if (isBetting) {
      openAccountHttpBeen.multiple = multiple;
      apiService.setBuildContext(context);
      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
        apiService.tencentOrderAdd(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
        apiService.tencent5OrderAdd(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
        apiService.tencent10OrderAdd(openAccountHttpBeen);
      }
    } else {
      if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
        apiService.tencentGdBets(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
        apiService.tencent5GdBets(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
        apiService.tencent10GdBets(openAccountHttpBeen);
      }
    }
  }

}