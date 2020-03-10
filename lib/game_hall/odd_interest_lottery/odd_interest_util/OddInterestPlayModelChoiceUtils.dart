
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/odd_interest/OddInterestHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/odd_interest/OddInterestService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiService.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

import 'OddInterestPlayModelChoiceInterface.dart';


class OddInterestPlayModelChoiceUtils {

  bool isSingle = false;
  bool sumValue = false;
  bool isGroupSumNum = false;
  bool isDragonTiger = false;
  int cpChoiceNum = 3;
  String cpChoiceTitle = "";
  List<String> _groupTitleList = new List();

  OddInterestPlayModelChoiceUtils._();

  static OddInterestPlayModelChoiceUtils _instance;

  static OddInterestPlayModelChoiceUtils getInstance() {
    if (_instance == null) {
      _instance = OddInterestPlayModelChoiceUtils._();
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

  getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen, OddInterestPlayModelChoiceInterface modelChoiceInterface) {

    switch(playBeen.playMode) {
      case 1:
        _laterFourChoicePlayModel(playBeen);
        break;
      case 2:
        _topThreeChoicePlayModel(playBeen);
        break;
      case 3:
        _middleThreeChoicePlayModel(playBeen);
        break;
      case 4:
        _laterThreeChoicePlayModel(playBeen);
        break;
      case 5:
        _laterTwoChoicePlayModel(playBeen);
        break;
      case 6:
        _topTwoChoicePlayModel(playBeen);
        break;
      case 7:
        _choiceFiveTitleTip();
        cpChoiceNum = 5;
        break;
      case 8:
        _uncertainGallbladderChoicePlayModel(playBeen);
        break;
      case 9:
        _optionalChoicePlayModel(playBeen);
        break;
      case 10:
        _interestChoicePlayModel(playBeen);
        break;
      case 11:
        isDragonTiger = true;
        break;
    }
    if (_groupTitleList.length <= 0) {
      choiceTopThreeTitleTip();
    }
    if (modelChoiceInterface != null) {
      modelChoiceInterface.setOddInterestPlayChoiceValue(isSingle, sumValue, cpChoiceNum, cpChoiceTitle,
          isGroupSumNum, isDragonTiger, _groupTitleList);
    }
  }

  /// 后四
  _laterFourChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    //前三 直选
    if (playBeen.id == 937 || playBeen.id == 1086 || playBeen.id == 1229) {
      //复式
      cpChoiceNum = 4;
      _choiceLaterFourTitleTip();
    }
    if (playBeen.id == 938 || playBeen.id == 1087 || playBeen.id == 1230) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }

  }

  /// 前三 直选
  _topThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    //前三 直选
    if (playBeen.id == 846 || playBeen.id == 1090 || playBeen.id == 1233) {
      //复式
      cpChoiceNum = 3;
      choiceTopThreeTitleTip();
    }
    if (playBeen.id == 947 || playBeen.id == 1091 || playBeen.id == 1234) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 948 || playBeen.id == 1092 || playBeen.id == 1235) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 949 || playBeen.id == 1093 || playBeen.id == 1236) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 951 || playBeen.id == 1095 || playBeen.id == 1238) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 952 || playBeen.id == 1096 || playBeen.id == 1239) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 953 || playBeen.id == 1097 || playBeen.id == 1240) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 1078 || playBeen.id == 1098 || playBeen.id == 1241) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 955 || playBeen.id == 1100 || playBeen.id == 1243) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 中三
  _middleThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 958 || playBeen.id == 1103 || playBeen.id == 1246) {
      //复式
      cpChoiceNum = 3;
      _choiceMiddleThreeTitleTip();
    }
    if (playBeen.id == 959 || playBeen.id == 1104 || playBeen.id == 1247) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 969 || playBeen.id == 1105 || playBeen.id == 1248) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 961 || playBeen.id == 1106 || playBeen.id == 1249) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 963 || playBeen.id == 1108 || playBeen.id == 1251) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 964 || playBeen.id == 1109 || playBeen.id == 1252) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 1079 || playBeen.id == 1110 || playBeen.id == 1253) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 966 || playBeen.id == 1112 || playBeen.id == 1255) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后三
  _laterThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 969 || playBeen.id == 1115 || playBeen.id == 1258) {
      //复式
      cpChoiceNum = 3;
      _choiceLaterThreeTitleTip();
    }
    if (playBeen.id == 970 || playBeen.id == 1116 || playBeen.id == 1259) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 971 || playBeen.id == 1117 || playBeen.id == 1260) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 972 || playBeen.id == 1118 || playBeen.id == 1261) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 974 || playBeen.id == 1120 || playBeen.id == 1263) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 975 || playBeen.id == 1121 || playBeen.id == 1264) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 976 || playBeen.id == 1122 || playBeen.id == 1265) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 1080 || playBeen.id == 1123 || playBeen.id == 1266) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 978 || playBeen.id == 1125 || playBeen.id == 1268) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后二
  _laterTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 992 || playBeen.id == 1139 || playBeen.id == 1282) {
      //复式
      cpChoiceNum = 2;
      _choiceLaterTwoTitleTip();
    }
    if (playBeen.id == 993 || playBeen.id == 1140 || playBeen.id == 1283) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 994 || playBeen.id == 1141 || playBeen.id == 1284) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 995 || playBeen.id == 1142 || playBeen.id == 1285) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 997 || playBeen.id == 1144 || playBeen.id == 1287) {
      //组选 复式
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 998 || playBeen.id == 1145 || playBeen.id == 1288) {
      //组选 单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 999 || playBeen.id == 1146 || playBeen.id == 1289) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 1000 || playBeen.id == 1147 || playBeen.id == 1290) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 前二
  _topTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 981 || playBeen.id == 1128 || playBeen.id == 1271) {
      //复式
      cpChoiceNum = 2;
      _choiceTopTwoTitleTip();
    }
    if (playBeen.id == 982 || playBeen.id == 1129 || playBeen.id == 1272) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 983 || playBeen.id == 1130 || playBeen.id == 1273) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 984 || playBeen.id == 1131 || playBeen.id == 1274) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 986 || playBeen.id == 1133 || playBeen.id == 1276) {
      //组选 复式
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 987 || playBeen.id == 1134 || playBeen.id == 1277) {
      //组选 单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 988 || playBeen.id == 1135 || playBeen.id == 1278) {
      //组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 989 || playBeen.id == 1136 || playBeen.id == 1279) {
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
    if (playBeen.id == 1022 || playBeen.id == 1069 || playBeen.id == 1312) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 1023 || playBeen.id == 1070 || playBeen.id == 1313) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 1024 || playBeen.id == 1071 || playBeen.id == 1314) {
      //组选
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
   //任三
    if (playBeen.id == 1026 || playBeen.id == 1073 || playBeen.id == 1316) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 1027 || playBeen.id == 1074 || playBeen.id == 1317) {
      //单式
      cpChoiceNum = 0;
      isSingle = true;
    }
    if (playBeen.id == 1028 || playBeen.id == 1075 || playBeen.id == 1318) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 1029 || playBeen.id == 1076 || playBeen.id == 1319) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }

    //任四
    if (playBeen.id == 1082 || playBeen.id == 1178 || playBeen.id == 1321) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 1083 || playBeen.id == 1179 || playBeen.id == 1322) {
      //单式
      cpChoiceNum = 0;
      isSingle = true;
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

  /// 后四位选号 文本提示 (默认) 位
  _choiceLaterFourTitleTip() {
    _groupTitleList.clear();
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
      case 951://前三组选/组三
      case 963://中三组选/组三
      case 974://后三组选/组三
      case 1024://任2/组三
      case 1028://任三/组三
        //奇趣5分彩
      case 1095://前三组选/组三
      case 1108://中三组选/组三
      case 1120://后三组选/组三
      case 1069://任2/复式
      case 1073://任三/组三
      //奇趣10分彩
      case 1238://前三组选/组三
      case 1251://中三组选/组三
      case 1263://后三组选/组三
      case 1069://任2/复式
      case 1318://任三/组三
        basNum = 2;
        break;
      //case 946://前三/直选复式
      case 952://前三组选/组六
      //case 958://中三/直选复式
      case 964://中三组选/组六
      case 975://后三组选/组六
      case 1029://任三/组六
      //奇趣5分彩
      case 1096://前三组选/组六
      case 1109://中三组选/组六
      case 1121://后三组选/组六
      case 1074://任三/组六
      //奇趣10分彩
      case 1239://前三组选/组六
      case 1252://中三组选/组六
      case 1264://后三组选/组六
      case 1319://任三/组六

        basNum = 3;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码)
  int getGamePlayModelSingleRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 938://后四直选/单式
      case 1083://任四直选/单式
        //奇趣5分彩
      case 1087://后四直选/单式
      case 1179://任四直选/单式
      //奇趣10分彩
      case 1230://后四直选/单式
      case 1322://任四直选/单式
        basNum = 4;
        break;
      case 947://前三直选/单式
      case 959://中三直选单式
      case 970://后三直选单式
      case 1027://任三 单式
        //奇趣5分彩
      case 1091://前三直选/单式
      case 1104://中三直选单式
      case 1116://后三直选单式
      case 1174://任三 单式
      //奇趣10分彩
      case 1234://前三直选/单式
      case 1247://中三直选单式
      case 1259://后三直选单式
      case 1317://任三 单式
        basNum = 3;
        break;
      case 982://前二直选单式
      case 993://后二直选单式
      case 987://前二组选单式
      case 998://后二组选单式
      case 1023://任二单式
      //奇趣5分彩
      case 1129://前二直选单式
      case 1140://后二直选单式
      case 1134://前二组选单式
      case 1145://后二组选单式
      case 1170://任二单式

      //奇趣10分彩
      case 1272://前二直选单式
      case 1283://后二直选单式
      case 1277://前二组选单式
      case 1288://后二组选单式
      case 1313://任二单式
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
      , List<String> groupBitsList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
      _postOddInterestBetting(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      _postOddInterest5Betting(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      _postOddInterest10Betting(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }
  }

  /// 奇趣一分彩
  _postOddInterestBetting(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    switch(playBeen.id) {
      case 937://后四/后四直选/复式（计算注数）

        if (choiceCpNumList.length >= 4) {
          OddInterestService.instance.oddInterestLaterFourGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 946://前三/前三直选/复式（计算注数）
      case 958://中三/中三直选/复式（计算注数）
      case 969://后三/后三直选/复式（计算注数）

        if (choiceCpNumList.length >= 3) {
          OddInterestService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 938://后四/后四直选/单式（计算注数）
      case 947://前三/前三直选/单式（计算注数）
      case 959://中三/中三直选/单式（计算注数）
      case 970://后三/后三直选/单式（计算注数）
      case 993://后二/直选/单试（计算注数）
      case 998://后二/组选/单式（计算注数）
      case 982://前二/直选/单试（计算注数）
      case 987://前二/组选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 951://前三/ 组六
      case 952:// 前三/ 组三
      case 948://直选和值
      case 949://直选跨度
      case 953://前三/前三组选/组选和值（计算注数）
      case 955://前三/前三其他 /和值尾数（计算注数）

      case 960://中三直选和值
      case 961://中三直选跨度
      case 963:// 中三/ 组六
      case 964://中三/ 组三
      case 1079://中三/中三组选/包胆（计算注数）
      case 966://中三/中三组选/和值尾数（计算注数）

      case 971://后三直选/和值
      case 972://后三直选/跨度
      case 974://后三组选/组六
      case 975://后三组选/组三
      case 976://后三组选/和值
      case 1080:// 后三组选/包胆
      case 978://后三/后三其他/和值尾数（计算注数）

      case 999://后二/组选/和值（计算注数）
      case 1000://后二/组选/包胆（计算注数）

      case 997://后二/组选/复式（计算注数）
      case 986://前二/组选/复式（计算注数）

      case 988://前二/组选/和值（计算注数）
      case 989://前二/组选/包胆（计算注数）
      case 983://前二/直选/和值（计算注数）
      case 984://前二/直选/跨度（计算注数）
      case 994://后二/直选/和值（计算注数）
      case 995://后二/直选/跨度（计算注数）

      case 1032://趣味/特殊/一帆风顺（计算注数）
      case 1033://趣味/特殊/好事成双（计算注数）
      case 1034://趣味/特殊/三星报喜（计算注数）

      case 1006://不定胆/五星不定胆/二码不定位（计算注数）
      case 1007://不定胆/五星不定胆/二码不定位（计算注数）
      case 1009://不定胆/前四不定胆 /一码不定位（计算注数）
      case 1010://不定胆/前四不定胆 /一码不定位（计算注数）
      case 1012://不定胆/后四不定胆 /二码不定位（计算注数）
      case 1013://不定胆/后四不定胆 /二码不定位（计算注数）
      case 1015://不定胆/三星不定胆一码/后三（计算注数）
      case 1016://不定胆/三星不定胆一码/前三（计算注数）
      case 1018://不定胆/三星不定胆二码/前三（计算注数）
      case 1019://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 981:
      case 992:
      //前二/直选/复试（计算注数）
      //后二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          OddInterestService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1022://任选/任二/复式（计算注数）
      case 1026://任选/任三/复式（计算注数）
      case 1082://任选/任四/复式（计算注数）
      case 1003://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 5) {
          OddInterestService.instance.hanoiOneGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1023://任选/任二/单式（计算注数）
      case 1027://任选/任三/单式（计算注数）
      case 1083://任选/任四/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1024://任选/任二/组选（计算注数）
      case 1028://任选/任三/组三（计算注数）
      case 1029://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
    }
  }

  /// 奇趣5分彩
  _postOddInterest5Betting(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    switch(playBeen.id) {
      case 1086://后四/后四直选/复式（计算注数）

        if (choiceCpNumList.length >= 4) {
          OddInterestService.instance.oddInterestLaterFourGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1090://前三/前三直选/复式（计算注数）
      case 1103://中三/中三直选/复式（计算注数）
      case 1115://后三/后三直选/复式（计算注数）

        if (choiceCpNumList.length >= 3) {
          OddInterestService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1087://后四/后四直选/单式（计算注数）
      case 1091://前三/前三直选/单式（计算注数）
      case 1104://中三/中三直选/单式（计算注数）
      case 1116://后三/后三直选/单式（计算注数）
      case 1140://后二/直选/单试（计算注数）
      case 1145://后二/组选/单式（计算注数）
      case 1129://前二/直选/单试（计算注数）
      case 1134://前二/组选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1095://前三/ 组六
      case 1096:// 前三/ 组三
      case 1092:
      case 1093:
      case 1097://前三/前三组选/组选和值（计算注数）
      case 1098://前三/前三组选/包胆（计算注数）
      case 1100://前三/前三其他 /和值尾数（计算注数）

      case 1105://中三直选和值
      case 1106://中三直选跨度
      case 1108:// 中三/ 组六
      case 1109://中三/ 组三
      case 1112://中三/中三组选/和值尾数（计算注数）

      case 1117://后三直选/和值
      case 1118://后三直选/跨度
      case 1120://后三组选/组六
      case 1121://后三组选/组三
      case 1122://后三组选/和值
      case 1123:// 后三组选/包胆
      case 1125://后三/后三其他/和值尾数（计算注数）

      case 1144://后二/组选/复式（计算注数）
      case 1133://前二/组选/复式（计算注数）

      case 1135://前二/组选/和值（计算注数）
      case 1136://前二/组选/包胆（计算注数）
      case 1130://前二/直选/和值（计算注数）
      case 1131://前二/直选/跨度（计算注数）
      case 1146://后二/组选/和值（计算注数）
      case 1141://后二/直选/和值（计算注数）
      case 1142://后二/直选/跨度（计算注数）
      case 1147://后二/组选/包胆（计算注数）

      case 1182://趣味/特殊/一帆风顺（计算注数）
      case 1183://趣味/特殊/好事成双（计算注数）
      case 1184://趣味/特殊/三星报喜（计算注数）

      case 1153://不定胆/五星不定胆/二码不定位（计算注数）
      case 1154://不定胆/五星不定胆/二码不定位（计算注数）
      case 1156://不定胆/前四不定胆 /一码不定位（计算注数）
      case 1157://不定胆/前四不定胆 /一码不定位（计算注数）
      case 1159://不定胆/后四不定胆 /二码不定位（计算注数）
      case 1160://不定胆/后四不定胆 /二码不定位（计算注数）
      case 1162://不定胆/三星不定胆一码/后三（计算注数）
      case 1163://不定胆/三星不定胆一码/前三（计算注数）
      case 1165://不定胆/三星不定胆二码/前三（计算注数）
      case 1166://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1128:
      case 1139:
      //前二/直选/复试（计算注数）
      //后二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          OddInterestService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1169://任选/任二/复式（计算注数）
      case 1173://任选/任三/复式（计算注数）
      case 1178://任选/任三/复式（计算注数）
      case 1150://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 5) {
          OddInterestService.instance.hanoiOneGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1170://任选/任二/单式（计算注数）
      case 1174://任选/任三/单式（计算注数）
      case 1179://任选/任四/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1171://任选/任二/组选（计算注数）
      case 1175://任选/任三/组三（计算注数）
      case 1176://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
    }
  }

  /// 奇趣10分彩
  _postOddInterest10Betting(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    switch(playBeen.id) {
      case 1229://后四/后四直选/复式（计算注数）

        if (choiceCpNumList.length >= 4) {
          OddInterestService.instance.oddInterestLaterFourGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1233://前三/前三直选/复式（计算注数）
      case 1246://中三/中三直选/复式（计算注数）
      case 1258://后三/后三直选/复式（计算注数）

        if (choiceCpNumList.length >= 3) {
          OddInterestService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1230://后四/后四直选/单式（计算注数）
      case 1234://前三/前三直选/单式（计算注数）
      case 1247://中三/中三直选/单式（计算注数）
      case 1259://后三/后三直选/单式（计算注数）
      case 1283://后二/直选/单试（计算注数）
      case 1288://后二/组选/单式（计算注数）
      case 1272://前二/直选/单试（计算注数）
      case 1277://前二/组选/单试（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1238://前三/ 组六
      case 1239:// 前三/ 组三
      case 1235:
      case 1236:
      case 1240://前三/前三组选/组选和值（计算注数）
      case 1241://前三/前三组选/包胆（计算注数）
      case 1243://前三/前三其他 /和值尾数（计算注数）

      case 1248://中三直选和值
      case 1249://中三直选跨度
      case 1251:// 中三/ 组六
      case 1252://中三/ 组三
      case 1253://中三/ 包胆
      case 1255://中三/中三组选/和值尾数（计算注数）

      case 1260://后三直选/和值
      case 1261://后三直选/跨度
      case 1263://后三组选/组六
      case 1264://后三组选/组三
      case 1265://后三组选/和值
      case 1266:// 后三组选/包胆
      case 1268://后三/后三其他/和值尾数（计算注数）

      case 1287://后二/组选/复式（计算注数）
      case 1276://前二/组选/复式（计算注数）

      case 1278://前二/组选/和值（计算注数）
      case 1279://前二/组选/包胆（计算注数）
      case 1273://前二/直选/和值（计算注数）
      case 1274://前二/直选/跨度（计算注数）
      case 1289://后二/组选/和值（计算注数）
      case 1285://后二/直选/和值（计算注数）
      case 1284://后二/直选/跨度（计算注数）
      case 1290://后二/组选/包胆（计算注数）

      case 1325://趣味/特殊/一帆风顺（计算注数）
      case 1326://趣味/特殊/好事成双（计算注数）
      case 1327://趣味/特殊/三星报喜（计算注数）

      case 1296://不定胆/五星不定胆/二码不定位（计算注数）
      case 1297://不定胆/五星不定胆/二码不定位（计算注数）
      case 1299://不定胆/前四不定胆 /一码不定位（计算注数）
      case 1300://不定胆/前四不定胆 /一码不定位（计算注数）
      case 1302://不定胆/后四不定胆 /二码不定位（计算注数）
      case 1303://不定胆/后四不定胆 /二码不定位（计算注数）
      case 1305://不定胆/三星不定胆一码/后三（计算注数）
      case 1306://不定胆/三星不定胆一码/前三（计算注数）
      case 1308://不定胆/三星不定胆二码/前三（计算注数）
      case 1309://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1271:
      case 1282:
      //前二/直选/复试（计算注数）
      //后二/直选/复试（计算注数）
        if (choiceCpNumList.length >= 2) {
          OddInterestService.instance.hanoiOneGetGDBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1312://任选/任二/复式（计算注数）
      case 1316://任选/任三/复式（计算注数）
      case 1321://任选/任四/复式（计算注数）
      case 1293://定位胆/定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 5) {
          OddInterestService.instance.hanoiOneGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1313://任选/任二/单式（计算注数）
      case 1317://任选/任三/单式（计算注数）
      case 1322://任选/任四/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 1314://任选/任二/组选（计算注数）
      case 1318://任选/任三/组三（计算注数）
      case 1319://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          OddInterestService.instance.hanoiOneGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
    }
  }


  /// 新龙虎
  getGameHttpBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    if (!isBetting) {
      hanoiBettingHandler.cleanDragonTigerStatus(true);
    }
    if (dragonTigerList.length <= 0) {
      hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
      return;
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
      getGameOneBettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      getGame5BettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      getGame10BettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

  }

  /// 新龙虎
  getGameOneBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    var playIdIndex = 0;
    switch(playBeen.id) {
      case 1038:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 1039;

                break;
              case "虎":
                playIdIndex = 1040;
                break;
              case "和":
                playIdIndex = 1041;
                break;
            }
            OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 1042:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1043;
              break;
            case "虎":
              playIdIndex = 1044;
              break;
            case "和":
              playIdIndex = 1045;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 1046:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1047;
              break;
            case "虎":
              playIdIndex = 1048;
              break;
            case "和":
              playIdIndex = 1049;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1050:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1051;
              break;
            case "虎":
              playIdIndex = 1052;
              break;
            case "和":
              playIdIndex = 1053;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1054:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1055;
              break;
            case "虎":
              playIdIndex = 1056;
              break;
            case "和":
              playIdIndex = 1057;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1058:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1059;
              break;
            case "虎":
              playIdIndex = 1060;
              break;
            case "和":
              playIdIndex = 1061;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1062:// 新龙虎/新龙虎/2v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1063;
              break;
            case "虎":
              playIdIndex = 1064;
              break;
            case "和":
              playIdIndex = 1065;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1066:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1067;
              break;
            case "虎":
              playIdIndex = 1068;
              break;
            case "和":
              playIdIndex = 1069;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1070:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1071;
              break;
            case "虎":
              playIdIndex = 1072;
              break;
            case "和":
              playIdIndex = 1073;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1074:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1075;
              break;
            case "虎":
              playIdIndex = 1076;
              break;
            case "和":
              playIdIndex = 1077;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

  /// 新龙虎
  getGame5BettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    var playIdIndex = 0;
    switch(playBeen.id) {
      case 1187:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 1188;

                break;
              case "虎":
                playIdIndex = 1189;
                break;
              case "和":
                playIdIndex = 1190;
                break;
            }
            OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 1191:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1192;
              break;
            case "虎":
              playIdIndex = 1193;
              break;
            case "和":
              playIdIndex = 1194;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 1195:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1196;
              break;
            case "虎":
              playIdIndex = 1197;
              break;
            case "和":
              playIdIndex = 1198;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1199:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1200;
              break;
            case "虎":
              playIdIndex = 1201;
              break;
            case "和":
              playIdIndex = 1202;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1203:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1204;
              break;
            case "虎":
              playIdIndex = 1205;
              break;
            case "和":
              playIdIndex = 1206;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1207:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1208;
              break;
            case "虎":
              playIdIndex = 1209;
              break;
            case "和":
              playIdIndex = 1210;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1211:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1212;
              break;
            case "虎":
              playIdIndex = 1213;
              break;
            case "和":
              playIdIndex = 1214;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1215:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1216;
              break;
            case "虎":
              playIdIndex = 1217;
              break;
            case "和":
              playIdIndex = 1218;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1219:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1220;
              break;
            case "虎":
              playIdIndex = 1221;
              break;
            case "和":
              playIdIndex = 1222;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1223:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1224;
              break;
            case "虎":
              playIdIndex = 1225;
              break;
            case "和":
              playIdIndex = 1226;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

  /// 新龙虎
  getGame10BettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, OddInterestHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    var playIdIndex = 0;
    switch(playBeen.id) {
      case 1330:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 1331;

                break;
              case "虎":
                playIdIndex = 1332;
                break;
              case "和":
                playIdIndex = 1333;
                break;
            }
            OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 1334:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1335;
              break;
            case "虎":
              playIdIndex = 1336;
              break;
            case "和":
              playIdIndex = 1337;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 1338:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1339;
              break;
            case "虎":
              playIdIndex = 1340;
              break;
            case "和":
              playIdIndex = 1341;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1342:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1343;
              break;
            case "虎":
              playIdIndex = 1344;
              break;
            case "和":
              playIdIndex = 1345;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1346:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1347;
              break;
            case "虎":
              playIdIndex = 1348;
              break;
            case "和":
              playIdIndex = 1349;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1350:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1351;
              break;
            case "虎":
              playIdIndex = 1352;
              break;
            case "和":
              playIdIndex = 1353;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1354:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1355;
              break;
            case "虎":
              playIdIndex = 1356;
              break;
            case "和":
              playIdIndex = 1357;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1358:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1359;
              break;
            case "虎":
              playIdIndex = 1360;
              break;
            case "和":
              playIdIndex = 1361;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1362:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1363;
              break;
            case "虎":
              playIdIndex = 1364;
              break;
            case "和":
              playIdIndex = 1365;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 1366:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 1367;
              break;
            case "虎":
              playIdIndex = 1368;
              break;
            case "和":
              playIdIndex = 1369;
              break;
          }
          OddInterestService.instance.hanoiOneGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

}