
import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/vietnam_hanoi/VietnamHanoiHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'VietnamHanoiBettingHandler.dart';

class VietnamHanoiService {
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
    return numStr.toString();
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
  void hanoiOneGetGDBets(VietnamHanoiBettingHandler hanoiBettingHandler, List<String> oneNum, List<String> twoNum, List<String> threeNum, String playID, bool isTwoListCpNum) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (twoNum.length <= 0) {
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }
    if (!isTwoListCpNum) {
      if (threeNum.length <= 0) {
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
    apiService.hanoiOneGetGDBets(openAccountHttpBeen);

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
  void hanoiOneGetGDBetsSpan(VietnamHanoiBettingHandler hanoiBettingHandler, List<String> oneNum, String playID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }


    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

    openAccountHttpBeen.data_num = _stringAppend(oneNum);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    apiService.hanoiOneGetGDBets(openAccountHttpBeen);

  }

  /// 随机单式
  void hanoiOneGetGDBetsRandomSingle(VietnamHanoiBettingHandler hanoiBettingHandler,String oneNum, String playID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
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
    apiService.hanoiOneGetGDBets(openAccountHttpBeen);

  }

  /// 输入单式
  void hanoiOneGetGDBetsEditSingle(VietnamHanoiBettingHandler hanoiBettingHandler,List<String> oneNum, String playID) {
    CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
    if (oneNum.length <= 0) {
      hanoiBettingHandler.getCalculationBettingNumData(calculationBettingNumBeen);
      return;
    }

    VietnamHanoiHttpBeen openAccountHttpBeen = new VietnamHanoiHttpBeen();
    openAccountHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openAccountHttpBeen.play_id = playID;

//    oneNum = oneNum.replaceAll(",", ";");
//
//    openAccountHttpBeen.data_num = oneNum;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(hanoiBettingHandler);
    apiService.hanoiOneGetGDBets(openAccountHttpBeen);

  }

}