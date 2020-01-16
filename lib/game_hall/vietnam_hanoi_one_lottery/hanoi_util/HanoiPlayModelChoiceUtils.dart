
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
    if (playBeen.id == 147) {
      //复式
      cpChoiceNum = 3;
      choiceTopThreeTitleTip();
    }
    if (playBeen.id == 148) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 149) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 150) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 152) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 153) {
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
    if (playBeen.id == 155) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 157) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 中三
  _middleThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 160) {
      //复式
      cpChoiceNum = 3;
      _choiceMiddleThreeTitleTip();
    }
    if (playBeen.id == 161) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 162) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 163) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 165) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 166) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 168) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后三
  _laterThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 173) {
      //复式
      cpChoiceNum = 3;
      _choiceLaterThreeTitleTip();
    }
    if (playBeen.id == 174) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 175) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 176) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 177) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 178) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 179) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 180) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 181) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后二
  _laterTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 184) {
      //复式
      cpChoiceNum = 3;
      _choiceLaterTwoTitleTip();
    }
    if (playBeen.id == 185) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 186) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 187) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 200) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 201) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 202) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 203) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 前二
  _topTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 190) {
      //复式
      cpChoiceNum = 3;
      _choiceTopTwoTitleTip();
    }
    if (playBeen.id == 191) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 192) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 193) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 195) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 196) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 198) {
      //组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 197) {
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
    if (playBeen.id == 226) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 227) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 228) {
      //组选
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
   //任三
    if (playBeen.id == 229) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 230) {
      //单式
      cpChoiceNum = 0;
      isSingle = true;
    }
    if (playBeen.id == 231) {
      //组三
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 232) {
      //组六
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
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
    _groupTitleList.add("万位");
    _groupTitleList.add("千位");
    _groupTitleList.add("百位");
    _groupTitleList.add("十位");
    _groupTitleList.add("个位");
  }

  /// 后三位选号 文本提示 (默认)
  _choiceLaterThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万位");
    _groupTitleList.add("千位");
    _groupTitleList.add("百位");
  }

  /// 中三位
  _choiceMiddleThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("千位");
    _groupTitleList.add("百位");
    _groupTitleList.add("十位");
  }

  /// 前三位
  choiceTopThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万位");
    _groupTitleList.add("千位");
    _groupTitleList.add("百位");
  }

  /// 前二位选号 文本提示
  _choiceTopTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万位");
    _groupTitleList.add("千位");
  }

  /// 后二
  _choiceLaterTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("十位");
    _groupTitleList.add("个位");
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
      case 147:
      case 149:
      case 150:
      case 155:
      case 157:
        basNum = 1;
        break;
      case 152:
      case 153:
      case 231:
      case 231:
        basNum = 2;
        break;
      case 232:
        basNum = 3;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码)
  int getGamePlayModelSingleRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 148:
      case 161:
      case 154:
      case 230:
        basNum = 3;
        break;
      case 191:
      case 227:
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
  getGameHttpBettingNum(Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, VietnamHanoiBettingHandler hanoiBettingHandler, bool isBetting, int multiple) {

    switch(playBeen.id) {
      case 147:
      case 160:
      case 173:
        //前三/前三直选/复式（计算注数）
        //中三/中三直选/复式（计算注数）
        //后三/后三直选/复式（计算注数）
        if (choiceCpNumList.length >= 3) {
          VietnamHanoiService.instance.hanoiOneGetGDBets(hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple);
        }

        break;
      case 148://前三/前三直选/复式（计算注数）
      case 161://中三/中三直选/单式（计算注数）
      case 174://后三/后三直选/单式（计算注数）
      case 191://前二/直选/单试（计算注数）
      case 196://前二/组选/单式（计算注数）
      case 191://前二/直选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsEditSingle(hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple);
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
          VietnamHanoiService.instance.hanoiOneGetGDBetsSpan(hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple);
        }

        break;
      case 184:
      case 190:
        //前二/直选/复试（计算注数）
        //后二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          VietnamHanoiService.instance.hanoiOneGetGDBets(hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple);
        }

        break;
      case 226://任选/任二/复式（计算注数）
      case 229://任选/任三/复式（计算注数）
      case 206://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 5) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptional(hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4],"${ playBeen.id}", isBetting, multiple);
        }

        break;
      case 227://任选/任二/单式（计算注数）
      case 230://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptionalGroup(hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple);
        }

        break;
      case 228://任选/任二/组选（计算注数）
      case 231://任选/任三/组三（计算注数）
      case 232://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          VietnamHanoiService.instance.hanoiOneGetGDBetsOptionalGroup(hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple);
        }

        break;
    }
  }

  /// 新龙虎
  getGameHttpBettingNumDragonTiger(Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, VietnamHanoiBettingHandler hanoiBettingHandler, bool isBetting, int multiple) {
    if (!isBetting) {
      hanoiBettingHandler.cleanDragonTigerStatus(true);
    }
    if (dragonTigerList.length <= 0) {
      hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
      return;
    }
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
            VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(hanoiBettingHandler, dragonTigerList, "$playIdIndex", isBetting, multiple);
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
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(hanoiBettingHandler, dragonTigerList, "$playIdIndex", isBetting, multiple);
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
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(hanoiBettingHandler, dragonTigerList, "$playIdIndex", isBetting, multiple);
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
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(hanoiBettingHandler, dragonTigerList, "$playIdIndex", isBetting, multiple);
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
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(hanoiBettingHandler, dragonTigerList, "$playIdIndex", isBetting, multiple);
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
          VietnamHanoiService.instance.hanoiOneGetGDBetsDragonTiger(hanoiBettingHandler, dragonTigerList, "$playIdIndex", isBetting, multiple);
        }

        break;

    }
  }

}