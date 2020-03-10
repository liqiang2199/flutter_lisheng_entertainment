
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
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

  /// 五星
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
      cpChoiceNum = 1;
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

    _choiceOneTitleTip(cpChoiceTitle);
  }

  /// 不定胆
  _uncertainGallbladderChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    cpChoiceNum = 1;
    cpChoiceTitle = "不定胆";
    _choiceOneTitleTip(cpChoiceTitle);
  }


  /// 定位胆
  _interestChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    cpChoiceNum = 1;
    cpChoiceTitle = "定位胆";
    _choiceOneTitleTip(cpChoiceTitle);
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
   * hanoiBettingHandler 通知界面
   */
  /// 请求投注数量
  getGameHttpBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, LuckyAirshipPlayModelChoiceInterface hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

//    if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
//      postTencentOneGameBettingNum(context, playBeen, choiceCpNumList, groupBitsList
//          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
//    }
//
//    if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
//      postTencentFiveGameBettingNum(context, playBeen, choiceCpNumList, groupBitsList
//          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
//    }
//
//    if (colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
//      postTencent10GameBettingNum(context, playBeen, choiceCpNumList, groupBitsList
//          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
//    }

  }

  /// 腾讯一分彩
  postTencentOneGameBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, TencentCnetBettingHandler hanoiBettingHandler, bool isBetting,
      int multiple, String colorVarietyID) {
    switch(playBeen.id) {
      case 308://前三/前三直选/复式（计算注数）
      case 320://中三/中三直选/复式（计算注数）
      case 331://后三/后三直选/复式（计算注数）
        if (choiceCpNumList.length >= 3) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 298://后四/后四直选/单式（计算注数）
      case 309://前三/前三直选/单式（计算注数）
      case 321://中三/中三直选/单式（计算注数）
      case 332://后三/后三直选/单式（计算注数）
      case 343://前二/直选/单试（计算注数）
      case 347://前二/组选/单式（计算注数）
      case 354://后二/直选/单式（计算注数）
      case 358://后二/组选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 286://五星/五星组选/组选120（计算注数）

      case 300://后四/后四组选/组选24（计算注数）
      case 302://后四/组选/6（计算注数）

      case 310://前三/前三组选/组选和值（计算注数）
      case 311://前三/前三组选/直选跨度（计算注数）
      case 312://前三/前三组选/组三（计算注数）
      case 313://前三/前三组选/组六（计算注数）
      case 314://前三/前三组选/和值（计算注数）
      case 315://前三/前三其他 /和值尾数（计算注数）

      case 323://中三/中三直选/直选跨度（计算注数）
      case 322://中三/中三直选/直选和值（计算注数）
      case 324://中三/中三组选/组三（计算注数）
      case 325://中三/中三组选/组六（计算注数）
      case 326://中三/中三组选/和值尾数（计算注数）

      case 333://后三/后三直选/直选和值（计算注数）
      case 334://后三/后三直选/直选跨度（计算注数）
      case 335://后三/后三直选/组三（计算注数）
      case 336://后三/后三直选/组六（计算注数）
      case 337://后三/后三组选/组选和值（计算注数）

      case 344://前二/直选/直选和值（计算注数）
      case 345://前二/直选/跨度（计算注数）
      case 346://前二/组选/复式（计算注数）
      case 348://前二/组选/和值（计算注数）
      case 349://前二/组选/包胆（计算注数）

      case 355://后二/直选/直选和值（计算注数）
      case 356://后二/直选/跨度（计算注数）
      case 357://后二/组选/复式（计算注数）
      case 477://后二/组选/和值（计算注数）
      case 478://后二/组选/包胆（计算注数）

      case 393://趣味/特殊/一帆风顺（计算注数）
      case 394://趣味/特殊/好事成双（计算注数）
      case 395://趣味/特殊/三星报喜（计算注数）
      case 396://趣味/特殊/四季发财（计算注数）

      case 368://不定胆/五星不定胆/二码不定位（计算注数）
      case 369://不定胆/五星不定胆/三码不定位（计算注数）
      case 370://不定胆/前四不定胆 /一码不定位（计算注数）
      case 371://不定胆/前四不定胆 /一码不定位（计算注数）
      case 372://不定胆/后四不定胆 /二码不定位（计算注数）
      case 373://不定胆/后四不定胆 /二码不定位（计算注数）
      case 374://不定胆/三星不定胆一码/后三（计算注数）
      case 375://不定胆/三星不定胆一码/前三（计算注数）
      case 376://不定胆/三星不定胆二码/前三（计算注数）
      case 377://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 342://前二/直选/复试（计算注数）
      case 353://后二/直选/复试（计算注数）

        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}"
              , true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 382://任选/任二/复式（计算注数）
      case 385://任选/任三/复式（计算注数）
      case 361://定位胆/定位胆/定位胆（计算注数）
      case 282://五星/五星直选/复式（计算注数）
        if (choiceCpNumList.length >= 5) {
          TencentCentService.instance.tencentFiveGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3]
              , choiceCpNumList[4],"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 383://任选/任二/单式（计算注数）
      case 386://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 384://任选/任二/组选（计算注数）
      case 387://任选/任三/组三（计算注数）
      case 388://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 297://后四/后四直选/复式（计算注数）
        if (choiceCpNumList.length >= 4) {
          TencentCentService.instance.tencentFourGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }
        break;
      case 287://五星/组选/60（计算注数）//重号
      case 288://五星/组选/30（计算注数）
      case 289://五星/组选/20（计算注数）
      case 290://五星/组选/10（计算注数）

      case 301://后四/组选/12（计算注数）//重号
//      case 302://后四/组选/6（计算注数）
      case 303://后四/组选/4（计算注数）
        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentDuplicateNumberGroupChoiceGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }
        break;
    }
  }


  /// 请求大小单双
  postSizeSingleAndDouble(BuildContext context, Play11Choice5DataPlayBeen playBeen
      , List<String> sizeSingleDoubleList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {


    if (sizeSingleDoubleList.length >= 1) {
      //(1=总和大，2=总和小，3=总和单，4=总和双)
      List<String> sizeSingleAndDoubleList = new List();


      sizeSingleDoubleList.forEach((value) {
        if (value == "大") {
          sizeSingleAndDoubleList.add("1");
        }
        if (value == "小") {
          sizeSingleAndDoubleList.add("2");
        }
        if (value == "单") {
          sizeSingleAndDoubleList.add("3");
        }
        if (value == "双") {
          sizeSingleAndDoubleList.add("4");
        }
      });
      TencentCentService.instance.tencentGetGDBetsSpan(context,hanoiBettingHandler, sizeSingleAndDoubleList
          ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
    }
  }

  /// 新龙虎
  getGameHttpBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    if (!isBetting) {
      hanoiBettingHandler.cleanDragonTigerStatus(true);
    }
    if (dragonTigerList.length <= 0) {
      hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
      return;
    }

    if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
      getGameOneBettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }


  }

  /// 腾讯一分彩
  getGameOneBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    var playIdIndex = 0;
    switch(playBeen.id) {
      case 437:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 447;

                break;
              case "虎":
                playIdIndex = 448;
                break;
              case "和":
                playIdIndex = 449;
                break;
            }
            TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 438:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 450;
              break;
            case "虎":
              playIdIndex = 451;
              break;
            case "和":
              playIdIndex = 452;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 439:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 453;
              break;
            case "虎":
              playIdIndex = 454;
              break;
            case "和":
              playIdIndex = 455;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 440:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 456;
              break;
            case "虎":
              playIdIndex = 457;
              break;
            case "和":
              playIdIndex = 458;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 441:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 459;
              break;
            case "虎":
              playIdIndex = 460;
              break;
            case "和":
              playIdIndex = 461;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 442:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 462;
              break;
            case "虎":
              playIdIndex = 463;
              break;
            case "和":
              playIdIndex = 464;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 443:// 新龙虎/新龙虎/2v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 465;
              break;
            case "虎":
              playIdIndex = 466;
              break;
            case "和":
              playIdIndex = 467;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 444:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 468;
              break;
            case "虎":
              playIdIndex = 469;
              break;
            case "和":
              playIdIndex = 470;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 445:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 471;
              break;
            case "虎":
              playIdIndex = 472;
              break;
            case "和":
              playIdIndex = 473;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 446:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 474;
              break;
            case "虎":
              playIdIndex = 475;
              break;
            case "和":
              playIdIndex = 476;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

}