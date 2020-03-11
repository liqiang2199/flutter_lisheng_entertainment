
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiService.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

import 'HanoiPlayModelChoiceInterface.dart';

class HanoiPlayModelChoiceUtils {

  bool isSingle = false;
  bool sumValue = false;
  bool isGroupSumNum = false;
  bool isDragonTiger = false;
  int cpChoiceNum = 3;
  String cpChoiceTitle = "";
  List<String> _groupTitleList = new List();

  HanoiPlayModelChoiceUtils._();

  static HanoiPlayModelChoiceUtils _instance;

  static HanoiPlayModelChoiceUtils getInstance() {
    if (_instance == null) {
      _instance = HanoiPlayModelChoiceUtils._();
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

  getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen, HanoiPlayModelChoiceInterface modelChoiceInterface) {

    switch(playBeen.playMode) {
      case 1:
        _topThreeChoicePlayModel(playBeen);
        break;
      case 2:
        _middleThreeChoicePlayModel(playBeen);
        break;
      case 3:
        _laterThreeChoicePlayModel(playBeen);
        break;
      case 4:
        _laterTwoChoicePlayModel(playBeen);
        break;
      case 5:
        _topTwoChoicePlayModel(playBeen);
        break;
      case 6:
        _choiceFiveTitleTip();
        cpChoiceNum = 5;
        break;
      case 7:
        _uncertainGallbladderChoicePlayModel(playBeen);
        break;
      case 8:
        _optionalChoicePlayModel(playBeen);
        break;
      case 9:
        _interestChoicePlayModel(playBeen);
        break;
      case 10:
        isDragonTiger = true;
        break;
    }
    if (_groupTitleList.length <= 0) {
      choiceTopThreeTitleTip();
    }
    if (modelChoiceInterface != null) {
      modelChoiceInterface.setHanoiPlayChoiceValue(isSingle, sumValue, cpChoiceNum, cpChoiceTitle,
          isGroupSumNum, isDragonTiger, _groupTitleList);
    }
  }

  /// 前三 直选
  _topThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    //前三 直选
    if (playBeen.id == 147 || playBeen.id == 481) {
      //复式
      cpChoiceNum = 3;
      choiceTopThreeTitleTip();
    }
    if (playBeen.id == 148 || playBeen.id == 482) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 149 || playBeen.id == 483) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 150 || playBeen.id == 484) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 152 || playBeen.id == 486) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 153 || playBeen.id == 487) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 154) {
      //混合组选
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 155 || playBeen.id == 488) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 157 || playBeen.id == 490) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 中三
  _middleThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 160 || playBeen.id == 493) {
      //复式
      cpChoiceNum = 3;
      _choiceMiddleThreeTitleTip();
    }
    if (playBeen.id == 161 || playBeen.id == 494) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 162 || playBeen.id == 495) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 163 || playBeen.id == 496) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 165 || playBeen.id == 498) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 166 || playBeen.id == 499) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 168 || playBeen.id == 501) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后三
  _laterThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 173 || playBeen.id == 504) {
      //复式
      cpChoiceNum = 3;
      _choiceLaterThreeTitleTip();
    }
    if (playBeen.id == 174 || playBeen.id == 505) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 175 || playBeen.id == 506) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 176 || playBeen.id == 507) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 177 || playBeen.id == 509) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 178 || playBeen.id == 510) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 179 || playBeen.id == 511) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 180 || playBeen.id == 512) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 181 || playBeen.id == 514) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后二
  _laterTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 184 || playBeen.id == 517) {
      //复式
      cpChoiceNum = 2;
      _choiceLaterTwoTitleTip();
    }
    if (playBeen.id == 185 || playBeen.id == 518) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 186 || playBeen.id == 519) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 187 || playBeen.id == 520) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 200 || playBeen.id == 522) {
      //组选 复式
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 201 || playBeen.id == 523) {
      //组选 单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 202 || playBeen.id == 524) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 203 || playBeen.id == 525) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 前二
  _topTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 190 || playBeen.id == 528) {
      //复式
      cpChoiceNum = 2;
      _choiceTopTwoTitleTip();
    }
    if (playBeen.id == 191 || playBeen.id == 529) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 192 || playBeen.id == 530) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 193 || playBeen.id == 531) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 195 || playBeen.id == 533) {
      //组选 复式
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 196 || playBeen.id == 534) {
      //组选 单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 198 || playBeen.id == 536) {
      //组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 197 || playBeen.id == 535) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
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
    if (playBeen.id == 226 || playBeen.id == 558) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 227 || playBeen.id == 559) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 228 || playBeen.id == 560) {
      //组选
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
   //任三
    if (playBeen.id == 229 || playBeen.id == 562) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 230 || playBeen.id == 563) {
      //单式
      cpChoiceNum = 0;
      isSingle = true;
    }
    if (playBeen.id == 231 || playBeen.id == 564) {
      //组选 和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 232 || playBeen.id == 565) {
      //组选 包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 趣味
  _interestChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    cpChoiceNum = 1;
    cpChoiceTitle = "号码";
    _choiceOneTitleTip(cpChoiceTitle);
  }

  /// 五位选号 文本提示 (默认)
  _choiceFiveTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
    _groupTitleList.add("百");
    _groupTitleList.add("十");
    _groupTitleList.add("个");
  }

  /// 后三位选号 文本提示 (默认) 位
  _choiceLaterThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
    _groupTitleList.add("百");
  }

  /// 中三位
  _choiceMiddleThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("千");
    _groupTitleList.add("百");
    _groupTitleList.add("十");
  }

  /// 前三位
  choiceTopThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("百");
    _groupTitleList.add("十");
    _groupTitleList.add("个");
  }

  /// 前二位选号 文本提示
  _choiceTopTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
  }

  /// 后二
  _choiceLaterTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("十");
    _groupTitleList.add("个");
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
      case 147://前三直选/复式
      case 149://前三直选/和值
      case 150://前三直选/跨度
      case 155://前三组选/和值
      case 157://前三直选/和值尾数

      case 481://前三直选/复式
      case 483://前三直选/和值
      case 484://前三直选/跨度
      case 488://前三组选/和值
      case 490://前三直选/和值尾数
        basNum = 1;
        break;
      case 152://前三组选/组三
      case 153://前三组选/组六
      case 231://任三/组三

      case 486://前三组选/组三
      case 487://前三组选/组六
      case 564://任三/组三
        basNum = 2;
        break;
      case 232://任三/组六

      case 565://任三/组六
        basNum = 3;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码)
  int getGamePlayModelSingleRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 148://前三直选/单式
      case 161://中三直选单式
      case 174://后三直选单式
      case 230://任三 单式

      case 482://前三直选/单式
      case 494://中三直选单式
      case 505://后三直选 单式
      case 563://任三 单式
        basNum = 3;
        break;
      case 191://前二直选单式
      case 185://后二直选单式
      case 196://前二组选单式
      case 201://后二组选单式
      case 227://任二单式
        //河内5分彩
      case 529://前二直选单式
      case 518://后二直选单式
      case 534://前二组选单式
      case 523://后二组选单式
      case 559://任二单式
        basNum = 2;
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
      , List<String> groupBitsList, VietnamHanoiBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      _postHanoiOneBetting(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      _postHanoi5Betting(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }
  }

  /// 河内一分彩
  _postHanoiOneBetting(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, VietnamHanoiBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    switch(playBeen.id) {
      case 147://前三/前三直选/复式（计算注数）
      case 160://中三/中三直选/复式（计算注数）
      case 173://后三/后三直选/复式（计算注数）



        if (choiceCpNumList.length >= 3) {
          VietnamHanoiService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 148://前三/前三直选/复式（计算注数）
      case 161://中三/中三直选/单式（计算注数）
      case 174://后三/后三直选/单式（计算注数）
      case 191://前二/直选/单试（计算注数）
      case 196://前二/组选/单式（计算注数）
      case 191://前二/直选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 149:
      case 150:
      case 152:
      case 153:
      case 155://前三/前三组选/组选和值（计算注数）
      case 157://前三/前三其他 /和值尾数（计算注数）
      case 162:
      case 163:
      case 165://中三/中三组选/和值尾数（计算注数）
      case 166:
      case 168://中三/中三组选/和值尾数（计算注数）
      case 175:
      case 176:
      case 177:
      case 178:
      case 179:
      case 181://后三/后三其他/和值尾数（计算注数）

      case 180://后三/后三组选/组选包胆（计算注数）
      case 198://前二/组选/包胆（计算注数）
      case 203://后二/组选/包胆（计算注数）

      case 200://后二/组选/复式（计算注数）
      case 195://前二/组选/复式（计算注数）

      case 197://前二/组选/和值（计算注数）
      case 192://前二/直选/和值（计算注数）
      case 193://前二/直选/跨度（计算注数）
      case 202://后二/组选/和值（计算注数）
      case 186://后二/直选/和值（计算注数）
      case 187://后二/直选/跨度（计算注数）

      case 235://趣味/特殊/一帆风顺（计算注数）
      case 236://趣味/特殊/好事成双（计算注数）
      case 237://趣味/特殊/三星报喜（计算注数）

      case 209://不定胆/五星不定胆/二码不定位（计算注数）
      case 210://不定胆/五星不定胆/二码不定位（计算注数）
      case 212://不定胆/前四不定胆 /一码不定位（计算注数）
      case 215://不定胆/前四不定胆 /一码不定位（计算注数）
      case 213://不定胆/前四不定胆 /二码不定位（计算注数）
      case 216://不定胆/前四不定胆 /二码不定位（计算注数）
      case 216://不定胆/前四不定胆 /二码不定位（计算注数）
      case 219://不定胆/三星不定胆一码/后三（计算注数）
      case 220://不定胆/三星不定胆一码/前三（计算注数）
      case 222://不定胆/三星不定胆二码/前三（计算注数）
      case 221://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 184:
      case 190:
      //前二/直选/复试（计算注数）
      //后二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          VietnamHanoiService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 226://任选/任二/复式（计算注数）
      case 229://任选/任三/复式（计算注数）
      case 206://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 5) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 227://任选/任二/单式（计算注数）
      case 230://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 228://任选/任二/组选（计算注数）
      case 231://任选/任三/组三（计算注数）
      case 232://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
    }
  }

  /// 河内5分彩
  _postHanoi5Betting(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, VietnamHanoiBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    switch(playBeen.id) {
      case 481://前三/前三直选/复式（计算注数）
      case 493://中三/中三直选/复式（计算注数）
      case 504://后三/后三直选/复式（计算注数）

        if (choiceCpNumList.length >= 3) {
          VietnamHanoiService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 482://前三/前三直选/单式（计算注数）
      case 494://中三/中三直选/单式（计算注数）
      case 505://后三/后三直选/单式（计算注数）
      case 518://后二/直选/单试（计算注数）
      case 523://后二/组选/单式（计算注数）
      case 529://前二/直选/单试（计算注数）
      case 534://前二/组选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 486://前三/ 组六
      case 487:// 前三/ 组三
      case 483:
      case 484:
      case 488://前三/前三组选/组选和值（计算注数）
      case 490://前三/前三其他 /和值尾数（计算注数）

      case 495://中三直选和值
      case 496://中三直选跨度
      case 498:// 中三/ 组六
      case 499://中三/ 组三
      case 501://中三/中三组选/和值尾数（计算注数）

      case 506://后三直选/和值
      case 507://后三直选/跨度
      case 509://后三组选/组六
      case 510://后三组选/组三
      case 511://后三组选/和值
      case 512:// 后三组选/包胆
      case 514://后三/后三其他/和值尾数（计算注数）

      case 535://前二/组选/和值（计算注数）
      case 536://前二/组选/包胆（计算注数）

      case 524://后二/组选/和值（计算注数）
      case 525://后二/组选/包胆（计算注数）

      case 522://后二/组选/复式（计算注数）
      case 533://前二/组选/复式（计算注数）

      case 524://前二/组选/和值（计算注数）
      case 519://前二/直选/和值（计算注数）
      case 520://前二/直选/跨度（计算注数）
      case 535://后二/组选/和值（计算注数）
      case 530://后二/直选/和值（计算注数）
      case 531://后二/直选/跨度（计算注数）

      case 568://趣味/特殊/一帆风顺（计算注数）
      case 569://趣味/特殊/好事成双（计算注数）
      case 570://趣味/特殊/三星报喜（计算注数）

      case 542://不定胆/五星不定胆/二码不定位（计算注数）
      case 543://不定胆/五星不定胆/二码不定位（计算注数）
      case 545://不定胆/前四不定胆 /一码不定位（计算注数）
      case 546://不定胆/前四不定胆 /一码不定位（计算注数）
      case 548://不定胆/后四不定胆 /二码不定位（计算注数）
      case 549://不定胆/后四不定胆 /二码不定位（计算注数）
      case 551://不定胆/三星不定胆一码/后三（计算注数）
      case 552://不定胆/三星不定胆一码/前三（计算注数）
      case 554://不定胆/三星不定胆二码/前三（计算注数）
      case 555://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 528:
      case 517:
      //前二/直选/复试（计算注数）
      //后二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          VietnamHanoiService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 558://任选/任二/复式（计算注数）
      case 562://任选/任三/复式（计算注数）
      case 539://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 5) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 559://任选/任二/单式（计算注数）
      case 563://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 560://任选/任二/组选（计算注数）
      case 564://任选/任三/组三（计算注数）
      case 565://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
    }
  }

  /// 新龙虎
  getGameHttpBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, VietnamHanoiBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    if (!isBetting) {
      hanoiBettingHandler.cleanDragonTigerStatus(true);
    }
    if (dragonTigerList.length <= 0) {
      hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
      return;
    }

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      getGameOneBettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      getGame5BettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

  }

  /// 新龙虎
  getGameOneBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, VietnamHanoiBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    var playIdIndex = 0;
    switch(playBeen.id) {
      case 240:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 250;

                break;
              case "虎":
                playIdIndex = 251;
                break;
              case "和":
                playIdIndex = 252;
                break;
            }
            VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 241:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 253;
              break;
            case "虎":
              playIdIndex = 254;
              break;
            case "和":
              playIdIndex = 255;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 242:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 256;
              break;
            case "虎":
              playIdIndex = 257;
              break;
            case "和":
              playIdIndex = 258;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 243:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 259;
              break;
            case "虎":
              playIdIndex = 260;
              break;
            case "和":
              playIdIndex = 261;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 244:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 262;
              break;
            case "虎":
              playIdIndex = 263;
              break;
            case "和":
              playIdIndex = 264;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 245:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 265;
              break;
            case "虎":
              playIdIndex = 266;
              break;
            case "和":
              playIdIndex = 267;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

  /// 新龙虎
  getGame5BettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, VietnamHanoiBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    var playIdIndex = 0;
    switch(playBeen.id) {
      case 573:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 574;

                break;
              case "虎":
                playIdIndex = 575;
                break;
              case "和":
                playIdIndex = 576;
                break;
            }
            VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 577:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 578;
              break;
            case "虎":
              playIdIndex = 579;
              break;
            case "和":
              playIdIndex = 580;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 581:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 582;
              break;
            case "虎":
              playIdIndex = 583;
              break;
            case "和":
              playIdIndex = 584;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 585:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 586;
              break;
            case "虎":
              playIdIndex = 587;
              break;
            case "和":
              playIdIndex = 588;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 589:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 590;
              break;
            case "虎":
              playIdIndex = 591;
              break;
            case "和":
              playIdIndex = 592;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 593:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 594;
              break;
            case "虎":
              playIdIndex = 595;
              break;
            case "和":
              playIdIndex = 596;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 597:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 598;
              break;
            case "虎":
              playIdIndex = 599;
              break;
            case "和":
              playIdIndex = 600;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 601:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 602;
              break;
            case "虎":
              playIdIndex = 603;
              break;
            case "和":
              playIdIndex = 604;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 605:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 606;
              break;
            case "虎":
              playIdIndex = 607;
              break;
            case "和":
              playIdIndex = 608;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 609:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 610;
              break;
            case "虎":
              playIdIndex = 611;
              break;
            case "和":
              playIdIndex = 612;
              break;
          }
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

}