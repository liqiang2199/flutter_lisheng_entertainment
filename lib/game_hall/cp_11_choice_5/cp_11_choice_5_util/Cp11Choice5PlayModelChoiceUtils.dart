
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/CalculationBettingNumHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/GameGd11Choice5Service.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

import 'Cp11Choice5PlayModelChoiceInterface.dart';

class Cp11Choice5PlayModelChoiceUtils {

  bool isSingle = false;
  bool sumValue = false;
  bool isGroupSumNum = false;
  bool isDragonTiger = false;
  int cpChoiceNum = 3;
  String cpChoiceTitle = "";
  List<String> _groupTitleList = new List();

  Cp11Choice5PlayModelChoiceUtils._();

  static Cp11Choice5PlayModelChoiceUtils _instance;

  static Cp11Choice5PlayModelChoiceUtils getInstance() {
    if (_instance == null) {
      _instance = Cp11Choice5PlayModelChoiceUtils._();
    }
    _instance.isSingle = false;
    _instance.sumValue = false;
    _instance.isGroupSumNum = false;
    _instance.isDragonTiger = false;
    _instance.cpChoiceNum = 3;
    _instance.cpChoiceTitle = "";
    _instance._groupTitleList.clear();
    return _instance;
  }

  getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen, Cp11Choice5PlayModelChoiceInterface modelChoiceInterface) {

    switch(playBeen.playMode) {
      case 1:
        _topThreeChoicePlayModel(playBeen);
        break;
      case 2:
        _topTwoChoicePlayModel(playBeen);
        break;
      case 3:
        _uncertainGallbladderChoicePlayModel(playBeen);
        break;
      case 4:
        //定位胆
        cpChoiceNum = 3;
        choiceTopThreeTitleTip();
        break;
      case 5:
        _optionalChoicePlayModel(playBeen);
        break;
    }
    if (_groupTitleList.length <= 0) {
      choiceTopThreeTitleTip();
    }
    if (modelChoiceInterface != null) {
      modelChoiceInterface.set11Choice5PlayChoiceValue(isSingle, sumValue, cpChoiceNum, cpChoiceTitle,
          isGroupSumNum, isDragonTiger, _groupTitleList);
    }
  }

  /// 前三 直选
  _topThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    //前三 直选
    if (playBeen.id == 4 || playBeen.id == 481) {
      //复式
      cpChoiceNum = 3;
      choiceTopThreeTitleTip();
    }
    if (playBeen.id == 5 || playBeen.id == 482) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    //组选
    if (playBeen.id == 7 || playBeen.id == 481) {
      //复式
      cpChoiceNum = 1;
      _choiceOneTitleTip("选号");
    }
    if (playBeen.id == 6 || playBeen.id == 482) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
  }

  /// 前二
  _topTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 11 || playBeen.id == 528) {
      //复式
      cpChoiceNum = 2;
      _choiceLaterTwoTitleTip();
    }
    if (playBeen.id == 12 || playBeen.id == 529) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    //组选
    if (playBeen.id == 39 || playBeen.id == 528) {
      //复式
      cpChoiceNum = 1;
      _choiceOneTitleTip("选号");
    }
    if (playBeen.id == 40 || playBeen.id == 529) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
  }

  /// 不定胆
  _uncertainGallbladderChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    cpChoiceNum = 1;
    cpChoiceTitle = "不定胆";
    _choiceOneTitleTip(cpChoiceTitle);
  }

  /// 任选
  _optionalChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    // 任二

    if (playBeen.id == 21 || playBeen.id == 22 || playBeen.id == 23 || playBeen.id ==24
        || playBeen.id == 25 || playBeen.id == 26 || playBeen.id == 27 || playBeen.id == 28) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 29 || playBeen.id == 30 || playBeen.id == 31 || playBeen.id == 32
        || playBeen.id == 33 || playBeen.id == 34 || playBeen.id == 35 || playBeen.id == 36) {
      //复式
      cpChoiceNum = 1;
      cpChoiceTitle = "${playBeen.name}";
      _choiceOneTitleTip(cpChoiceTitle);
    }

  }



  /// 前三位
  choiceTopThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("第一位");
    _groupTitleList.add("第二位");
    _groupTitleList.add("第三位");
  }

  /// 前二
  _choiceLaterTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("第一位");
    _groupTitleList.add("第二位");
  }

  /// 只有一位选号
  _choiceOneTitleTip(String title) {
    _groupTitleList.clear();
    _groupTitleList.add(title);
  }




  /// 玩法类型随机基数 (复式 可以选号)
  int getGamePlayModelRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 4://前三直选/复式
        basNum = 1;
        break;
      case 11://前2直选/复式
      case 39://前2组合/复式
      case 30://任选 2 中 2
        basNum = 2;
        break;
      case 31://任选 3 中 3
        basNum = 3;
        break;
      case 32://任选 4 中 4
        basNum = 4;
        break;
      case 33://任选 5 中 5
        basNum = 5;
        break;
      case 34://任选 6 中 5
        basNum = 6;
        break;
      case 35://任选 7 中 5
        basNum = 7;
        break;
      case 36://任选 8 中 5
        basNum = 8;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码)
  int getGamePlayModelSingleRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 5://前三直选/单式
      case 6://前三组选/单式
        basNum = 3;//2倍长度
        break;
      case 12://前二直选/单式
      case 40://前二组选/单式
        basNum = 2;
        break;
      case 22://任选 2 中 2
        basNum = 2;
        break;
      case 23://任选 3 中 3
        basNum = 3;
        break;
      case 24://任选 4 中 4
        basNum = 4;
        break;
      case 25://任选 5 中 5
        basNum = 5;
        break;
      case 26://任选 6 中 5
        basNum = 6;
        break;
      case 27://任选 7 中 5
        basNum = 7;
        break;
      case 28://任选 8 中 5
        basNum = 8;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码 11 选 5 为 2个数字一组)
  int getGamePlayModelSingleRandomBaseLength(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 2;
    switch(playBeen.id) {
      case 5://前三直选/单式
      case 6://前三组选/单式
        basNum = 6;//2倍长度
        break;
      case 12://前二直选/单式
      case 40://前二组选/单式
        basNum = 4;
        break;
      case 22://任选 2 中 2
        basNum = 4;
        break;
      case 23://任选 3 中 3
        basNum = 6;
        break;
      case 24://任选 4 中 4
        basNum = 8;
        break;
      case 25://任选 5 中 5
        basNum = 10;
        break;
      case 26://任选 6 中 5
        basNum = 12;
        break;
      case 27://任选 7 中 5
        basNum = 14;
        break;
      case 28://任选 8 中 5
        basNum = 16;
        break;
    }
    return basNum;

  }

  /**
   * playBeen 获取是哪种 玩法
   * choiceCpNumList 获取选中的彩票
   * hanoiBettingHandler 通知界面
   */
  /// 请求投注数量
  getGameHttpBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, CalculationBettingNumHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    if (colorVarietyID == "${Constant.GAME_NUM_11_CHOICE_5_GD}") {
      // 广东11 选 5
      _postHanoiOneBetting(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

  }

  /// 广东11 选 5
  _postHanoiOneBetting(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, CalculationBettingNumHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    switch(playBeen.id) {
      case 4://前三/前三直选/复式（计算注数）
      case 17://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 3) {
          GameGd11Choice5Service.instance.certainGallbladderCombinationCompound(choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], hanoiBettingHandler,"${ playBeen.id}", isBetting, multiple);
        }

        break;
      case 40://前二/组选/单试（计算注数）

      case 21://前二/组选/单试（计算注数）
      case 22://前二/组选/单试（计算注数）
      case 23://前二/组选/单试（计算注数）
      case 24://前二/组选/单试（计算注数）
      case 25://前二/组选/单试（计算注数）
      case 26://前二/组选/单试（计算注数）
      case 27://前二/组选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,hanoiBettingHandler,"${ playBeen.id}", isBetting, multiple);
        }

        break;

      case 12://前二/直选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,hanoiBettingHandler,"${ playBeen.id}", isBetting, multiple);
        }

        break;

      case 5://前二/组选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,hanoiBettingHandler,"${ playBeen.id}", isBetting, multiple);
        }

        break;
      case 7://前三/前三组选/复式（计算注数）

      case 39://前二/组选/复式（计算注数）

      case 29://前二/组选/复式（计算注数）
      case 30://前二/组选/复式（计算注数）
      case 31://前二/组选/复式（计算注数）
      case 32://前二/组选/复式（计算注数）
      case 33://前二/组选/复式（计算注数）
      case 34://前二/组选/复式（计算注数）
      case 35://前二/组选/复式（计算注数）
      case 36://前二/组选/复式（计算注数）

      case 15://不定胆（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0], hanoiBettingHandler
              , "${ playBeen.id}", isBetting, multiple);
        }

        break;
      case 11://前二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          GameGd11Choice5Service.instance.twoYardDirectlyElectedCompound(choiceCpNumList[0]
              , choiceCpNumList[1], hanoiBettingHandler, isBetting, multiple);
        }

        break;
    }
  }


}