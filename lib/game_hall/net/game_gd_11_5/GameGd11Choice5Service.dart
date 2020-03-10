

import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CalculationBettingNumHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'CalculationBettingNumHandler.dart';

class GameGd11Choice5Service {
  static GameGd11Choice5Service get instance => _getInstance();
  static GameGd11Choice5Service _instance;

  // 私有构造函数
  GameGd11Choice5Service._internal() {
    // 初始化
  }

  static GameGd11Choice5Service _getInstance() {
    if(_instance == null) {
      _instance = new GameGd11Choice5Service._internal();
    }
    return _instance;
  }

  /// 拼接字符串
  String _stringAppend(List<String> list) {
    StringBuffer numStr = new StringBuffer();
    list.forEach((value){
      numStr.write(value);
      numStr.write(",");
    });
    return numStr.toString();
  }

  /**
   * len 需要多少长度
   */
  ///
  String _stringAppend_List(List<String> list, int len) {
    StringBuffer numStr = new StringBuffer();

    if(list.length <= 0) {
      return numStr.toString();
    }
    var listStr = list[0].replaceAll(",", "");
    var length = listStr.length;
    if (length >= len) {
      for (int i = 0; i < length; i = i + 2) {
        numStr.write(listStr.substring(i, i + 2));
        numStr.write(",");
      }
    }
    var string = numStr.toString();
    var substring = string.substring(0, string.length - 1);
    return "$substring;";
  }

  /// 三码/前三直选/复式（计算注数）
//  void threeYardDirectlyElectedCompound(String one_num, String two_num, String three_num, CalculationBettingNumHandler  bettingNumHandler ) {
  void threeYardDirectlyElectedCompound(List<String> one_num, List<String> two_num, List<String> three_num
      , CalculationBettingNumHandler  bettingNumHandler ,bool isAddBetting, int bettingMultiple) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (one_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (two_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (three_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    CalculationBettingNumHttpBeen bettingNumHttpBeen = new CalculationBettingNumHttpBeen(SpUtil.getString(Constant.TOKEN),"4");


    bettingNumHttpBeen.one_num = _stringAppend(one_num);
    bettingNumHttpBeen.two_num = _stringAppend(two_num);
    bettingNumHttpBeen.three_num = _stringAppend(three_num);
    if (isAddBetting) {
      bettingNumHttpBeen.multiple = bettingMultiple;
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingNumHandler);
    if(isAddBetting) {
      apiService.orderAdd(bettingNumHttpBeen);
    } else {
      apiService.gdBets(bettingNumHttpBeen);
    }

  }

  /**
   * 只有一个选号时
   * playId 玩法ID
   */
  ///
  void commonOneListDataNum(List<String> numList, CalculationBettingNumHandler  bettingNumHandler
      , String playId, bool isAddBetting, int bettingMultiple) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (numList.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    CalculationBettingNumHttpBeen bettingNumHttpBeen = new CalculationBettingNumHttpBeen(SpUtil.getString(Constant.TOKEN),playId);

    if(playId == "5"|| playId == "6"|| playId == "23") {
      // 三码/前三直选/单式（计算注数） 三码/前三组合/单式（计算注数）任选/任选单式/三中三
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 6);
    } else if (playId == "40" || playId == "12" || playId == "22") {
      // 二码/前二组选/单式（计算注数）二码/前二直选/单式（计算注数）  任选/任选单式/二中二
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 4);
    }else if (playId == "24") {
      // 任选/任选单式四中四
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 8);
    }
    else if (playId == "25") {
      // 任选/任选单式五中五
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 10);
    }
    else if (playId == "26") {
      // 任选/任选单式 六中五
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 12);
    }
    else if (playId == "27") {
      // 任选/任选单式 七中五
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 14);
    }
    else if (playId == "28") {
      // 任选/任选单式 八中五
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 16);
    }
    else if (playId == "21") {
      // 任选/任选单式 1中1
      bettingNumHttpBeen.data_num = _stringAppend_List(numList, 2);
    }
    else {
      bettingNumHttpBeen.data_num = _stringAppend(numList);
    }

    if (isAddBetting) {
      bettingNumHttpBeen.multiple = bettingMultiple;
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingNumHandler);
    if(isAddBetting) {
      apiService.orderAdd(bettingNumHttpBeen);
    } else {
      apiService.gdBets(bettingNumHttpBeen);
    }
  }

  /// 三码/前三组合/复式（计算注数）
  void threeYardCombinationCompound(List<String> numList, CalculationBettingNumHandler  bettingNumHandler,bool isAddBetting, int bettingMultiple) {
    commonOneListDataNum(numList, bettingNumHandler, "7", isAddBetting, bettingMultiple);
  }


  /**
   * 二码/前二直选/复式（计算注数）
   */
  ///
  void twoYardDirectlyElectedCompound(List<String> one_num, List<String> two_num,  CalculationBettingNumHandler  bettingNumHandler, bool isAddBetting, int bettingMultiple ) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (one_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (two_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    CalculationBettingNumHttpBeen bettingNumHttpBeen = new CalculationBettingNumHttpBeen(SpUtil.getString(Constant.TOKEN),"11");


    bettingNumHttpBeen.one_num = _stringAppend(one_num);
    bettingNumHttpBeen.two_num = _stringAppend(two_num);
    if(isAddBetting) {
      bettingNumHttpBeen.multiple = bettingMultiple;
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingNumHandler);
    if(isAddBetting) {
      apiService.orderAdd(bettingNumHttpBeen);
    } else {
      apiService.gdBets(bettingNumHttpBeen);
    }

  }

  /// 二码/前二组合/复式（计算注数）
  void twoYardCombinationCompound(List<String> numList,
      CalculationBettingNumHandler  bettingNumHandler, bool isAddBetting, int bettingMultiple) {
    commonOneListDataNum(numList, bettingNumHandler, "39",isAddBetting, bettingMultiple);
  }

  /// 不定胆/前三位（计算注数）
  void uncertainGallbladderCombinationCompound(List<String> numList,
      CalculationBettingNumHandler  bettingNumHandler, bool isAddBetting, int bettingMultiple) {
    commonOneListDataNum(numList, bettingNumHandler, "15", isAddBetting, bettingMultiple);
  }

  /// 定位胆/定位胆（计算注数）
  void certainGallbladderCombinationCompound(List<String> one_num, List<String> two_num,
      List<String> three_num, CalculationBettingNumHandler  bettingNumHandler, String playID, bool isAddBetting, int bettingMultiple ) {

    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (one_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (two_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (three_num.length <= 0) {
      bettingNumHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    CalculationBettingNumHttpBeen bettingNumHttpBeen = new CalculationBettingNumHttpBeen(SpUtil.getString(Constant.TOKEN), playID);


    bettingNumHttpBeen.one_num = _stringAppend(one_num);
    bettingNumHttpBeen.two_num = _stringAppend(two_num);
    bettingNumHttpBeen.three_num = _stringAppend(three_num);
    if (isAddBetting) {
      bettingNumHttpBeen.multiple = bettingMultiple;
    }

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingNumHandler);
    if(isAddBetting) {
      apiService.orderAdd(bettingNumHttpBeen);
    } else {
      apiService.gdBets(bettingNumHttpBeen);
    }

  }

}