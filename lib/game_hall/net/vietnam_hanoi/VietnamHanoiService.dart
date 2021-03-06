
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/VietnamHanoiHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import '../GameCommonService.dart';
import 'VietnamHanoiBettingHandler.dart';

class VietnamHanoiService{
  static VietnamHanoiService get instance => _getInstance();
  static VietnamHanoiService _instance;

  // 私有构造函数
  VietnamHanoiService._internal() {
    // 初始化
  }

  static VietnamHanoiService _getInstance() {
    if(_instance == null) {
      _instance = new VietnamHanoiService._internal();
    }
    return _instance;
  }

  String _stringAppend(List<String> list) {
    StringBuffer numStr = new StringBuffer();
    list.forEach((value){
      numStr.write(value);
      numStr.write(",");
    });
    String numS = "";
    if (numStr.length > 0) {
      numS = numStr.toString().substring(0, numStr.length - 1);
    }
    return numS;
  }

  // 单式 计算 加 ，
  String _stringSingleAppend(List<String> list) {
    StringBuffer numStr = new StringBuffer();
    list.forEach((value){
      var length = value.length;
      for (int i = 0; i < length; i++) {
        numStr.write(value.substring(i, i + 1));
        if (i != length - 1) {
          numStr.write(",");
        }

      }

      numStr.write(";");
    });
    String numS = "";
    if (numStr.length > 0) {
      numS = numStr.toString().substring(0, numStr.length - 1);
    }
    return numS;
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
  void hanoiOneGetGDBets(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler
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

    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.one_num = _stringAppend(oneNum);
    openAccountHttpBeen.two_num = _stringAppend(twoNum);

    if (!isTwoListCpNum) {
      openAccountHttpBeen.three_num = _stringAppend(threeNum);
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }


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
  void hanoiOneGetGDBetsSpan(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler
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


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = _stringAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }
  }

  /// 随机单式
  void hanoiOneGetGDBetsRandomSingle(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler
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


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    oneNum = oneNum.replaceAll(",", ";");

    openAccountHttpBeen.data_num = oneNum;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }

  }

  /// 输入单式
  void hanoiOneGetGDBetsEditSingle(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler
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

    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = _stringSingleAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }

  }

  /**
   *  任选复式
   *  如果是定位胆 只要选中一注都能进行投注
   */
  ///
  void hanoiOneGetGDBetsOptional(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler, List<String> oneNum
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


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.one_num = _stringAppend(oneNum);
    openAccountHttpBeen.two_num = _stringAppend(twoNum);
    openAccountHttpBeen.three_num = _stringAppend(threeNum);
    openAccountHttpBeen.four_num = _stringAppend(four_num);
    openAccountHttpBeen.five_num = _stringAppend(five_num);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }

  }

  /**
   * 任选组选(非单式)
   */
  ///
  void hanoiOneGetGDBetsOptionalGroup(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler, List<String> oneNum
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


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    if (isSingle) {
      openAccountHttpBeen.data_num = _stringSingleAppend(oneNum);
    } else {
      openAccountHttpBeen.data_num = _stringAppend(oneNum);
    }

    openAccountHttpBeen.data_address = _stringAppend(bitsNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }

  }

  /**
   * 任选（单式)
   */
  ///
  void hanoiOneGetGDBetsOptionalSingle(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler, List<String> oneNum
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


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = _stringAppend(oneNum);
    openAccountHttpBeen.data_address = _stringAppend(bitsNum);


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
//    if (isBetting) {
//      openAccountHttpBeen.multiple = multiple;
//      apiService.setBuildContext(context);
//      apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
//    } else {
//      apiService.hanoiOneGetGDBets(openAccountHttpBeen);
//    }

  }

  /**
   * 新龙虎
   */
  ///
  void hanoiOneGetGDBetsDragonTiger(BuildContext context,VietnamHanoiBettingHandler hanoiBettingHandler
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


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;


    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    _postLotteryBettingNum(context, openAccountHttpBeen, apiService, isBetting, multiple, colorVarietyID);
  }

  _postLotteryBettingNum(BuildContext context,VietnamHanoiHttpBeen openAccountHttpBeen, ApiService apiService
      , bool isBetting, int multiple, String colorVarietyID) {
    if (isBetting) {
      openAccountHttpBeen.multiple = multiple;
      apiService.setBuildContext(context);
      if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
        apiService.hanoiOneGetOrderAdd(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
        apiService.hanoi5GetOrderAdd(openAccountHttpBeen);
      }

    } else {
      if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
        apiService.hanoiOneGetGDBets(openAccountHttpBeen);
      }
      if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
        apiService.hanoi5GetGDBets(openAccountHttpBeen);
      }

    }
  }


  /// 获取开奖时间
  void hanoiOneGetKjTime(VietnamHanoiBettingHandler hanoiBettingHandler
      , String colorVarietyID) {

    BaseTokenHttpBeen openAccountHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      apiService.hanoiOneGetKjTime(openAccountHttpBeen);
    }
    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      apiService.hanoi5GetKjTime(openAccountHttpBeen);
    }


  }

  /// 越南河内1分彩 开奖记录
  void hanoiOneKjLog(VietnamHanoiBettingHandler bettingHandler, String page
      , String limit, String colorVarietyID) {
    OpenLotteryListHttpBeen openAccountHttpBeen = new OpenLotteryListHttpBeen(SpUtil.getString(Constant.TOKEN), "", limit, page);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingHandler);
    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      apiService.hanoiOneKjLog(openAccountHttpBeen);
    }
    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      apiService.hanoi5KjLog(openAccountHttpBeen);
    }

  }

}