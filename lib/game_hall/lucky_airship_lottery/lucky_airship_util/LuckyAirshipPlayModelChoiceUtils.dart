
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/lucky_airship/LuckyAirshipHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/lucky_airship/LuckyAirshipService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/tencent_game/TencentCentService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/tencent_game/TencentCnetBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

import 'LuckyAirshipPlayModelChoiceInterface.dart';


class LuckyAirshipPlayModelChoiceUtils {

  bool isSingle = false;
  bool sumValue = false;
  bool isGroupSumNum = false;
  bool isDragonTiger = false;
  bool isContainsRepeat = false;
  bool isFiveStarsTotalNum = false;// 是否是五星中和
  int cpChoiceNum = 3;
  String cpChoiceTitle = "";
  List<String> _groupTitleList = new List();

  LuckyAirshipPlayModelChoiceUtils._();

  static LuckyAirshipPlayModelChoiceUtils _instance;

  static LuckyAirshipPlayModelChoiceUtils getInstance() {
    if (_instance == null) {
      _instance = LuckyAirshipPlayModelChoiceUtils._();
    }
    _instance.isSingle = false;
    _instance.sumValue = false;
    _instance.isGroupSumNum = false;
    _instance.isDragonTiger = false;
    _instance.isFiveStarsTotalNum = false;
    _instance.isContainsRepeat = false;
    _instance.cpChoiceNum = 3;
    _instance.cpChoiceTitle = "";
    _instance._groupTitleList.clear();
    return _instance;
  }

  getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen, LuckyAirshipPlayModelChoiceInterface modelChoiceInterface) {

    switch(playBeen.playMode) {
      case 1:
        _onePlayModel(playBeen);
        break;
      case 2:
        _twoPlayModel(playBeen);
        break;
      case 3:
        _interestChoicePlayModel(playBeen);
        break;
      case 4:
        _bigAndSmallPlayModel(playBeen);
        break;
      case 5:
        _bigAndSmallPlayModel(playBeen);
        break;
      case 6:
        _bigAndSmallPlayModel(playBeen);
        break;

    }

    if (modelChoiceInterface != null) {
      modelChoiceInterface.setLuckyAirshipPlayChoiceValue(isSingle, cpChoiceNum, cpChoiceTitle,
          isGroupSumNum, isDragonTiger, _groupTitleList);
    }
  }

  ///
  _onePlayModel(Play11Choice5DataPlayBeen playBeen) {


    if (playBeen.id == 124 ) {
      // 前一复式
      cpChoiceNum = 1;
      cpChoiceTitle = "第一位";
      _choiceOneTitleTip(cpChoiceTitle);
    }

  }

  /// 前二
  _twoPlayModel(Play11Choice5DataPlayBeen playBeen) {


    if (playBeen.id == 127 ) {
      // 前二复式
      cpChoiceNum = 2;
      _choiceTopTwoTitleTip();
    }

    if (playBeen.id == 128 ) {
      // 前二单式
      isSingle = true;
      cpChoiceNum = 0;
    }

  }

  /// 大小
  _bigAndSmallPlayModel(Play11Choice5DataPlayBeen playBeen) {

    if(playBeen.id == 142 || playBeen.id == 1535 || playBeen.id == 1540) {
      cpChoiceTitle = "第一位";
    }
    if(playBeen.id == 143 || playBeen.id == 1536 || playBeen.id == 1541) {
      cpChoiceTitle = "第二位";
    }
    if(playBeen.id == 144 || playBeen.id == 1537 || playBeen.id == 1542) {
      cpChoiceTitle = "第三位";
    }
    cpChoiceNum = 1;
    isDragonTiger = true;
//    _choiceOneTitleTip(cpChoiceTitle);
  }

  /// 不定胆
  _uncertainGallbladderChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    cpChoiceNum = 1;
    cpChoiceTitle = "不定胆";
    _choiceOneTitleTip(cpChoiceTitle);
  }


  /// 定位胆
  _interestChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    cpChoiceNum = 10;
    cpChoiceTitle = "定位胆";
    _groupTitleList.clear();
    _groupTitleList.add("第一名");
    _groupTitleList.add("第二名");
    _groupTitleList.add("第三名");
    _groupTitleList.add("第四名");
    _groupTitleList.add("第五名");
    _groupTitleList.add("第六名");
    _groupTitleList.add("第七名");
    _groupTitleList.add("第八名");
    _groupTitleList.add("第九名");
    _groupTitleList.add("第十名");
  }


  /// 前二位选号 文本提示
  _choiceTopTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("第一位");
    _groupTitleList.add("第二位");
  }


  /// 只有一位选号
  _choiceOneTitleTip(String title) {
    _groupTitleList.clear();
    _groupTitleList.add(title);
  }

  /// 大小 单双 龙虎
  getBigAndSmallPlayModelTitleName(Play11Choice5DataPlayBeen playBeen) {

    if(playBeen.id == 142 || playBeen.id == 1535 || playBeen.id == 1540) {
      cpChoiceTitle = "第一位";
    }
    if(playBeen.id == 143 || playBeen.id == 1536 || playBeen.id == 1541) {
      cpChoiceTitle = "第二位";
    }
    if(playBeen.id == 144 || playBeen.id == 1537 || playBeen.id == 1542) {
      cpChoiceTitle = "第三位";
    }
    return cpChoiceTitle;
  }


  /// 玩法类型随机基数 (复式 可以选号)
  int getGamePlayModelRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 127://前二 复式
        basNum = 2;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码)
  int getGamePlayModelSingleRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 128:// 前二单式
        basNum = 4;
        break;
    }
    return basNum;

  }

//  /// 玩法类型随机基数 (单式 可输入号码)
//  int getGamePlayModelSingleRandomTotalNumBase(Play11Choice5DataPlayBeen playBeen) {
//    int basNum = 1;
//    switch(playBeen.id) {
//      case 297:// 后四 直选单式
//      case 628:// 后四 直选单式 5分彩
//        basNum = 4;
//        break;
//      case 792:// 前三 直选单式
//      case 804:// 中三 直选单式
//      case 815:// 后三 直选单式
//      case 872:// 任选 三 单式
//        basNum = 3;
//        break;
//    }
//    return basNum;
//
//  }

  /**
   * playBeen 获取是哪种 玩法
   * choiceCpNumList 获取选中的彩票
   */
  /// 请求投注数量
  getGameHttpBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      ,  LuckyAirshipHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    if (colorVarietyID == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
      postLuckyAirshipGameBettingNum(context, playBeen, choiceCpNumList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

  }

  /// 幸运飞艇
  postLuckyAirshipGameBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , LuckyAirshipHandler hanoiBettingHandler, bool isBetting,
      int multiple, String colorVarietyID) {
    switch(playBeen.id) {
      case 124://前一/复式（计算注数）
        if (choiceCpNumList.length >= 1) {
          LuckyAirshipService.instance.luckyAirshipOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;

      case 127://前二/复式（计算注数）
      case 1531://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 2) {
          LuckyAirshipService.instance.hanoiOneGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 128://前二/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          LuckyAirshipService.instance.luckyAirshipGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;

      case 142://大小
      case 143://大小
      case 144://大小

      case 1535://单双
      case 1536://单双
      case 1537://单双

      case 1540://龙虎
      case 1541://龙虎
      case 1542://龙虎
        if (choiceCpNumList.length >= 1) {
          LuckyAirshipService.instance.luckyAirshipDragonTigerGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
    }
  }




}