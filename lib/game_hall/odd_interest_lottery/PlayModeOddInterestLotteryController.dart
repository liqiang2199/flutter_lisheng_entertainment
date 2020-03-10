
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataThreeYardsBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/PlayMode11Choice5Been.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import '../net/PlayMode11Choice5Handler.dart';

/**
 * 河内一分彩 玩法选择
 * 河内 5 分彩
 */
///
class PlayModeOddInterestLotteryController extends StatefulWidget{

  final List<Play11Choice5DataPlayBeen> playModeBeenList;
  final String colorVarietyID;

  const PlayModeOddInterestLotteryController(
      {Key key,
        this.playModeBeenList,
        this.colorVarietyID
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayModeOddInterestLotteryController(this.playModeBeenList, this.colorVarietyID);
  }

}

class _PlayModeOddInterestLotteryController extends BaseController<PlayModeOddInterestLotteryController> implements PlayMode11Choice5Handler {

  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  bool isChoiceType = false;//是否是有选择

  String colorVarietyID;


  _PlayModeOddInterestLotteryController(this.playModeBeenList,
      this.colorVarietyID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((e) {
      GameService.instance.oddInterestGetPlay(this, colorVarietyID);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (!isChoiceType) {
      var arguments = ModalRoute.of(context).settings.arguments;
      if (arguments != null) {
        playModeBeenList = arguments;

      }
    }

    return new Scaffold(
      appBar: CommonView().commonAppBarIntentData(context, "玩法选择", playModeBeenList),
      body: new ListView(
        children: _itemModeList(),
      ),
    );
  }

  List<Widget> _itemModeList() {
    List<Widget> modeWidget = new List();
    choiceModeMap?.forEach((modeK, modeV) {
      modeWidget.add(_playModeItem(modeK.name, modeV));
    });
    return modeWidget;
  }

  /**
   * 玩法的选择列表
   */
  ///
  Widget _playModeItem(String title, List<Play11Choice5DataPlayBeen> playModeBeen) {

    return new Column(
      children: <Widget>[

        new Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: new Row(
            children: <Widget>[

              new Container(
                child: new Text(
                  title,
                  style: TextStyle(
                    color: Color(ColorUtil.textColor_333333),
                    fontSize: 14.0,
                  ),
                ),
                width: 55.0,
              ),

              new Expanded(
                child: _gridList(title,playModeBeen),
              ),
            ],
          ),
        ),
        SpaceViewUtil.pading_Top_10(),

        CommonView().commonLine_NoMargin(context),

      ],
    );
  }


  Widget _gridList(String typeNam, List<Play11Choice5DataPlayBeen> playModeBeen) {

    return new Container(
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        //padding: const EdgeInsets.all(8.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 3.8,
        children: _gridListItemView(typeNam, playModeBeen),
        shrinkWrap: true,

      ),
    );
  }

  // 玩法 类型
  Widget _playTypeItem(String name, int colorId, String typeNam, Play11Choice5DataPlayBeen play11choice5dataPlayBeen) {
    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        height: 30.0  ,
        margin: EdgeInsets.only( left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          // 选中
          play11choice5dataPlayBeen.isChoice = !play11choice5dataPlayBeen.isChoice;
          for (int i = 0; i < playModeBeenList.length;i++) {
            if(play11choice5dataPlayBeen.id == playModeBeenList[i].id) {
              playModeBeenList.removeAt(i);
            }
          }
          if (play11choice5dataPlayBeen.isChoice) {
            //选中就添加
            if (!playModeBeenList.contains(play11choice5dataPlayBeen)) {
              //包含就直接移除
              String playTypeName = "";
              switch(typeNam) {
                case "后四":
                case "前三":
                case "中三":
                case "后三":
                case "后二":
                case "前二":
                case "新龙虎":
                  playTypeName = "$typeNam${play11choice5dataPlayBeen.name}";
                  break;
                case "定位胆":
                case "不定胆":
                case "任选":
                case "趣味":
                  playTypeName = "${play11choice5dataPlayBeen.name}";
                  break;
              }
              Play11Choice5DataPlayBeen dataPlayBeen = new Play11Choice5DataPlayBeen(
                  play11choice5dataPlayBeen.id, play11choice5dataPlayBeen.lottery_id,
                  play11choice5dataPlayBeen.play_id, playTypeName, play11choice5dataPlayBeen.is_group,
                  play11choice5dataPlayBeen.status, play11choice5dataPlayBeen.money_award,
                  play11choice5dataPlayBeen.money, play11choice5dataPlayBeen.remark);

              dataPlayBeen.isGroupSelection = play11choice5dataPlayBeen.isGroupSelection;
              dataPlayBeen.playMode = play11choice5dataPlayBeen.playMode;
              dataPlayBeen.playModeTitle = play11choice5dataPlayBeen.playModeTitle;
              dataPlayBeen.playModeSingleOrDouble = play11choice5dataPlayBeen.playModeSingleOrDouble;
              dataPlayBeen.groupSelectionNum = play11choice5dataPlayBeen.groupSelectionNum;

              playModeBeenList.add(dataPlayBeen);
            }

          } else {
            if (playModeBeenList.contains(play11choice5dataPlayBeen)) {
              //包含就直接移除
              playModeBeenList.remove(play11choice5dataPlayBeen);
            }
          }
          isChoiceType = true;
          if (mounted) {
            setState(() {

            });
          }
        },color: Color(ColorUtil.whiteColor),
          child: new Text(name
            , style: TextStyle(fontSize: name.length > 6 ? 11.0 : 13.0,color: Color(colorId)),),
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(colorId),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  List<Widget> _gridListItemView(String typeNam, List<Play11Choice5DataPlayBeen> playModeBeen) {
    List<Widget> gridListItem = new List();
    print("playModeBeen.length ${playModeBeen.length}");

    for (int i = 0; i < playModeBeen.length; i++) {
      if (playModeBeen[i].isChoice == null) {
        playModeBeen[i].isChoice = false;
      }
      gridListItem.add(_playTypeItem(playModeBeen[i].name,
          playModeBeen[i].isChoice ? ColorUtil.textColor_FF8814 : ColorUtil.textColor_888888, typeNam, playModeBeen[i]));
    }
    return gridListItem;
  }

  Map<Play11Choice5DataThreeYardsBeen, List<Play11Choice5DataPlayBeen>> choiceModeMap =
  new Map<Play11Choice5DataThreeYardsBeen, List<Play11Choice5DataPlayBeen>>();

  @override
  void playModeMapValue(Map<String, dynamic> mapStr) {


    Map<String, dynamic> data = mapStr["data"];
    if (data == null) {
      return;
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST}") {
      _PlayModeOddInterestLottery(data);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_4}") {
      _PlayModeOddInterest5Lottery(data);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_ODD_INTEREST_5}") {
      _PlayModeOddInterest10Lottery(data);
    }

    choiceModeMap.forEach((choiceK, choiceV) {
      //遍历选中
      for(int choice = 0; choice < choiceV.length; choice++) {
        for (int i = 0; i< playModeBeenList.length; i++) {
          if (choiceV[choice].id == playModeBeenList[i].id) {
            choiceV[choice].isChoice = true;
          }
        }
      }
    });

    if (mounted)
      setState(() {

      });
  }

  /// 奇趣一分彩
  _PlayModeOddInterestLottery(Map<String, dynamic> data) {

    Map<String, dynamic> dataAfterFourYards = data["935"];//后四
    var dataAfterFourYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataAfterFourYards);
    Map<String, dynamic> dataAfterFourYardsPlay = dataAfterFourYards["play"];//

    List<Play11Choice5DataPlayBeen> dataAfterFourPlayList = new List(); // 后四 列表

    var dataAfterFourPlayBeen = dataAfterFourYardsPlay["936"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 937; i<= 938; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataAfterFourPlayBeen["$i"];//
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 937) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 4;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 938) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      dataAfterFourPlayList.add(topThreeMapBeen);
    }

    choiceModeMap[dataAfterFourYardsBeen] = dataAfterFourPlayList;

    Map<String, dynamic> dataThreeYards = data["944"];//前三
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//前三 直选

    List<Play11Choice5DataPlayBeen> dataTopThreePlayList = new List(); // 前三 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["945"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 946; i<= 949; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen["$i"];//三码
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 2;
      if (i == 946) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 947) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 948) {
        topThreeMapBeen.name = "直选和值";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 949) {
        topThreeMapBeen.name = "直选跨度";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen);
    }
    /// 前三 组选
    var dataTopThreePlayBeen6 = dataThreeYardsPlay["950"]["play"];//

    for (int i = 951; i<= 953; i++) {

      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen6["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 951) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 952) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 953) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen6);
    }

    Map<String, dynamic> dataTopThreePlayMap1078 = dataTopThreePlayBeen6["1078"];//三码 组选包胆
    var topThreeMapBeen1078 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap1078);
    topThreeMapBeen1078.groupSelectionNum = 1;
    topThreeMapBeen1078.playModeSingleOrDouble = 2;
    topThreeMapBeen1078.playMode = 2;
    dataTopThreePlayList.add(topThreeMapBeen1078);

    var dataTopThreePlayBeen11 = dataThreeYardsPlay["954"]["play"];//11
    Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen11["955"];//三码 12
    var topThreeMapBeen11 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
    topThreeMapBeen11.groupSelectionNum = 1;
    topThreeMapBeen11.playModeSingleOrDouble = 2;
    topThreeMapBeen11.playMode = 2;
    dataTopThreePlayList.add(topThreeMapBeen11);

    choiceModeMap[threeYardsBeen] = dataTopThreePlayList;


    /// 中三
    Map<String, dynamic> middleThree = data["956"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["957"]["play"];

    for (int mi = 958; mi <= 961; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 3;
      if (mi == 958) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 959) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 960) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 961) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree19 = dataMiddleThreePlay["962"]["play"];//组选

    for (int mi = 963; mi <= 964; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree19["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 3;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    Map<String, dynamic> middleThreeDataMap1079 = middleThree19["1079"];//包胆
    var middleThreePlayBeen1079 = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap1079);
    middleThreePlayBeen1079.playMode = 3;
    middleThreePlayBeen1079.groupSelectionNum = 1;
    middleThreePlayBeen1079.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen1079);

    var middleThree22 = dataMiddleThreePlay["965"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap = middleThree22["966"];//和值
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 3;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["967"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["968"]["play"];//后三 直选

    for (int lTi = 969; lTi <= 972; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 4;

      if (lTi == 969) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 970) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 971) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 972) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["973"]["play"];//后三 组选

    for (int lTi = 974; lTi <= 976; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 4;
      if (lTi == 974) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 975) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 976) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 180) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    //组选包胆
    Map<String, dynamic> dataLaterThreePlayBeenLTi1080 = dataLaterThreePlayBeen26Play["1080"];
    var dataLaterThreePlayBeen1080 = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi1080);
    dataLaterThreePlayBeen1080.playMode = 4;
    dataLaterThreePlayBeen1080.groupSelectionNum = 1;
    dataLaterThreePlayBeen1080.playModeSingleOrDouble = 2;
    dataLaterThreePlayList.add(dataLaterThreePlayBeen1080);


    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["977"]["play"];//后三 组选

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["978"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 4;

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["990"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["991"]["play"];//
    /// 后二 直选
    for(int two = 992; two <= 995; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 5;

      if (two == 992) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 993) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 994) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 995) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["996"]["play"];//
    /// 后二 组选
    for(int two = 997; two <= 1000; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 5;

      if (two == 997) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 998) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 999) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1000) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;


    /// 前二
    Map<String, dynamic> dataTopTwo = data["979"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["980"]["play"];//
    /// 前二 直选
    for(int two = 981; two <= 984; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 6;

      if (two == 981) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 982) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 983) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 984) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["985"]["play"];//
    /// 前二 组选
    for(int two = 986; two <= 989; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 6;
      if (two == 986) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 987) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 988) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 989) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["1001"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["1002"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["1003"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 7;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["1004"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["1005"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 1006; two <= 1007; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1006) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 1007) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["1008"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 1009; two <= 1010; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1009) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 1010) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["1011"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 1012; two <= 1013; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1012) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 1013) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["1014"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 1015; two <= 1016; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1015) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 1016) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["1017"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 1018; two <= 1019; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1018) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 1019) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["1020"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["1021"]["play"];//任二

    for (int op = 1022; op <= 1024; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1022) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1023) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 1024) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["1025"]["play"];//任二

    for (int op = 1026; op <= 1029; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1026) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1027) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 1028) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 1029) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任四
    Map<String, dynamic> dataOptional1081 = dataOptionalPlay["1081"]["play"];//任二

    for (int op = 1082; op <= 1083; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional1081["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1026) {
        dataOptionalBeen.name = "任四复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1027) {
        dataOptionalBeen.name = "任四单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["1030"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["1031"]["play"];//

    for (int op = 1032; op <= 1034; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 10;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["1036"];//
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["1037"]["play"];//

    for (int op = 1038; op <= 1074; op ++) {

      if (op == 1038 || op == 1042 || op == 1046 || op == 1050 || op == 1054 || op == 1058
          ||op == 1062 || op == 1066 || op == 1070 || op == 1074) {

        Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
        var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataInterestBeen.groupSelectionNum = 1;
        dataInterestBeen.playModeSingleOrDouble = 2;
        dataInterestBeen.playMode = 11;

        if (op == 1038) {
          Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["1039"];
          var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
          dataInterestBeen.remark = dataInterestBeen105.remark;
        }

        if (op == 1042) {
          Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["1043"];
          var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
          dataInterestBeen.remark = dataInterestBeen108.remark;
        }

        if (op == 1046) {
          Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["1047"];
          var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
          dataInterestBeen.remark = dataInterestBeen111.remark;
        }

        if (op == 1050) {
          Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["1051"];
          var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
          dataInterestBeen.remark = dataInterestBeen114.remark;
        }

        if (op == 1054) {
          Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["1055"];
          var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
          dataInterestBeen.remark = dataInterestBeen117.remark;
        }

        if (op == 1058) {
          Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["1059"];
          var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
          dataInterestBeen.remark = dataInterestBeen120.remark;
        }

        if (op == 1062) {
          Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["1063"];
          var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
          dataInterestBeen.remark = dataInterestBeen123.remark;
        }

        if (op == 1066) {
          Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["1067"];
          var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
          dataInterestBeen.remark = dataInterestBeen126.remark;
        }

        if (op == 1070) {
          Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["1071"];
          var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
          dataInterestBeen.remark = dataInterestBeen129.remark;
        }

        if (op == 1074) {
          Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["1075"];
          var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
          dataInterestBeen.remark = dataInterestBeen132.remark;
        }

        dataNewDragonTigerBeenPlayList.add(dataInterestBeen);

      }


    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;
  }

  /// 奇趣5分彩
  _PlayModeOddInterest5Lottery(Map<String, dynamic> data) {

    Map<String, dynamic> dataAfterFourYards = data["1084"];//后四
    var dataAfterFourYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataAfterFourYards);
    Map<String, dynamic> dataAfterFourYardsPlay = dataAfterFourYards["play"];//

    List<Play11Choice5DataPlayBeen> dataAfterFourPlayList = new List(); // 后四 列表

    var dataAfterFourPlayBeen = dataAfterFourYardsPlay["1085"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 1086; i<= 1087; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataAfterFourPlayBeen["$i"];//
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 1086) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 4;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1087) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      dataAfterFourPlayList.add(topThreeMapBeen);
    }

    choiceModeMap[dataAfterFourYardsBeen] = dataAfterFourPlayList;

    Map<String, dynamic> dataThreeYards = data["1088"];//前三
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//前三 直选

    List<Play11Choice5DataPlayBeen> dataTopThreePlayList = new List(); // 前三 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["1089"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 1090; i<= 1093; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen["$i"];//三码
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 2;
      if (i == 1090) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1091) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 1092) {
        topThreeMapBeen.name = "直选和值";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1093) {
        topThreeMapBeen.name = "直选跨度";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen);
    }
    /// 前三 组选
    var dataTopThreePlayBeen6 = dataThreeYardsPlay["1094"]["play"];//

    for (int i = 1095; i<= 1098; i++) {

      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen6["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 1095) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1096) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1097) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1098) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen6);
    }


    var dataTopThreePlayBeen11 = dataThreeYardsPlay["1099"]["play"];//11
    Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen11["1100"];//三码 12
    var topThreeMapBeen11 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
    topThreeMapBeen11.groupSelectionNum = 1;
    topThreeMapBeen11.playModeSingleOrDouble = 2;
    topThreeMapBeen11.playMode = 2;
    dataTopThreePlayList.add(topThreeMapBeen11);

    choiceModeMap[threeYardsBeen] = dataTopThreePlayList;


    /// 中三
    Map<String, dynamic> middleThree = data["1101"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["1102"]["play"];

    for (int mi = 1103; mi <= 1106; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 3;
      if (mi == 1103) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 1104) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 1105) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 1106) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree19 = dataMiddleThreePlay["1107"]["play"];//组选

    for (int mi = 1108; mi <= 1110; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree19["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 3;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree22 = dataMiddleThreePlay["1111"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap = middleThree22["1112"];//和值
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 3;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["1113"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["1114"]["play"];//后三 直选

    for (int lTi = 1115; lTi <= 1118; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 4;

      if (lTi == 1115) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 1116) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 1117) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 1118) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["1119"]["play"];//后三 组选

    for (int lTi = 1120; lTi <= 1123; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 4;
      if (lTi == 1120) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 1121) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 1122) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 1123) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }


    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["1124"]["play"];//后三 组选

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["1125"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 4;

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["1137"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["1138"]["play"];//
    /// 后二 直选
    for(int two = 1139; two <= 1142; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 5;

      if (two == 1139) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1140) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 1141) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1142) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["1143"]["play"];//
    /// 后二 组选
    for(int two = 1144; two <= 1147; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 5;

      if (two == 1144) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1145) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 1146) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1147) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;


    /// 前二
    Map<String, dynamic> dataTopTwo = data["1126"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["1127"]["play"];//
    /// 前二 直选
    for(int two = 1128; two <= 1131; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 6;

      if (two == 1128) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1129) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 1130) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1131) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["1132"]["play"];//
    /// 前二 组选
    for(int two = 1133; two <= 1136; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 6;
      if (two == 1133) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1134) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 1135) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1136) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["1148"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["1149"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["1150"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 7;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["1151"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["1152"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 1153; two <= 1154; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1153) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 1154) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["1155"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 1156; two <= 1157; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1156) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 1157) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["1158"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 1159; two <= 1160; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1159) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 1160) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["1161"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 1162; two <= 1163; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1162) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 1163) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["1164"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 1165; two <= 1166; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1165) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 1166) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["1167"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["1168"]["play"];//任二

    for (int op = 1169; op <= 1171; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1169) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1170) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 1171) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["1172"]["play"];//任二

    for (int op = 1173; op <= 1176; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1173) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1174) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 1175) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 1176) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任四
    Map<String, dynamic> dataOptional1081 = dataOptionalPlay["1177"]["play"];//

    for (int op = 1178; op <= 1179; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional1081["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1178) {
        dataOptionalBeen.name = "任四复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1179) {
        dataOptionalBeen.name = "任四单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["1180"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["1181"]["play"];//

    for (int op = 1182; op <= 1184; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 10;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["1185"];//
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["1186"]["play"];//

    for (int op = 1187; op <= 1223; op ++) {

      if (op == 1187 || op == 1191 || op == 1195 || op == 1199 || op == 1203 || op == 1207
          ||op == 1211 || op == 1215 || op == 1219 || op == 1223) {

        Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
        var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataInterestBeen.groupSelectionNum = 1;
        dataInterestBeen.playModeSingleOrDouble = 2;
        dataInterestBeen.playMode = 11;

        if (op == 1187) {
          Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["1188"];
          var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
          dataInterestBeen.remark = dataInterestBeen105.remark;
        }

        if (op == 1191) {
          Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["1192"];
          var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
          dataInterestBeen.remark = dataInterestBeen108.remark;
        }

        if (op == 1195) {
          Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["1196"];
          var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
          dataInterestBeen.remark = dataInterestBeen111.remark;
        }

        if (op == 1199) {
          Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["1200"];
          var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
          dataInterestBeen.remark = dataInterestBeen114.remark;
        }

        if (op == 1203) {
          Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["1204"];
          var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
          dataInterestBeen.remark = dataInterestBeen117.remark;
        }

        if (op == 1207) {
          Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["1208"];
          var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
          dataInterestBeen.remark = dataInterestBeen120.remark;
        }

        if (op == 1211) {
          Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["1212"];
          var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
          dataInterestBeen.remark = dataInterestBeen123.remark;
        }

        if (op == 1215) {
          Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["1216"];
          var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
          dataInterestBeen.remark = dataInterestBeen126.remark;
        }

        if (op == 1219) {
          Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["1220"];
          var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
          dataInterestBeen.remark = dataInterestBeen129.remark;
        }

        if (op == 1223) {
          Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["1224"];
          var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
          dataInterestBeen.remark = dataInterestBeen132.remark;
        }

        dataNewDragonTigerBeenPlayList.add(dataInterestBeen);

      }


    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;
  }

  /// 奇趣10分彩
  _PlayModeOddInterest10Lottery(Map<String, dynamic> data) {

    Map<String, dynamic> dataAfterFourYards = data["1227"];//后四
    var dataAfterFourYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataAfterFourYards);
    Map<String, dynamic> dataAfterFourYardsPlay = dataAfterFourYards["play"];//

    List<Play11Choice5DataPlayBeen> dataAfterFourPlayList = new List(); // 后四 列表

    var dataAfterFourPlayBeen = dataAfterFourYardsPlay["1228"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 1229; i<= 1230; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataAfterFourPlayBeen["$i"];//
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 1229) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 4;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1230) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      dataAfterFourPlayList.add(topThreeMapBeen);
    }

    choiceModeMap[dataAfterFourYardsBeen] = dataAfterFourPlayList;

    Map<String, dynamic> dataThreeYards = data["1231"];//前三
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//前三 直选

    List<Play11Choice5DataPlayBeen> dataTopThreePlayList = new List(); // 前三 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["1232"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 1233; i<= 1236; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen["$i"];//三码
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 2;
      if (i == 1233) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1234) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 1235) {
        topThreeMapBeen.name = "直选和值";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1236) {
        topThreeMapBeen.name = "直选跨度";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen);
    }
    /// 前三 组选
    var dataTopThreePlayBeen6 = dataThreeYardsPlay["1237"]["play"];//

    for (int i = 1238; i<= 1241; i++) {

      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen6["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 1238) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1239) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1240) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1241) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen6);
    }


    var dataTopThreePlayBeen11 = dataThreeYardsPlay["1242"]["play"];//11
    Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen11["1243"];//三码 12
    var topThreeMapBeen11 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
    topThreeMapBeen11.groupSelectionNum = 1;
    topThreeMapBeen11.playModeSingleOrDouble = 2;
    topThreeMapBeen11.playMode = 2;
    dataTopThreePlayList.add(topThreeMapBeen11);

    choiceModeMap[threeYardsBeen] = dataTopThreePlayList;


    /// 中三
    Map<String, dynamic> middleThree = data["1244"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["1245"]["play"];

    for (int mi = 1246; mi <= 1249; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 3;
      if (mi == 1246) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 1247) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 1248) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 1249) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree19 = dataMiddleThreePlay["1250"]["play"];//组选

    for (int mi = 1251; mi <= 1253; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree19["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 3;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree22 = dataMiddleThreePlay["1254"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap = middleThree22["1255"];//和值
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 3;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["1256"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["1257"]["play"];//后三 直选

    for (int lTi = 1258; lTi <= 1261; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 4;

      if (lTi == 1258) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 1259) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 1260) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 1261) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["1262"]["play"];//后三 组选

    for (int lTi = 1263; lTi <= 1266; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 4;
      if (lTi == 1263) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 1264) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 1265) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 1266) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }


    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["1267"]["play"];//后三 组选

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["1268"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 4;

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["1280"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["1281"]["play"];//
    /// 后二 直选
    for(int two = 1282; two <= 1285; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 5;

      if (two == 1282) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1283) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 1284) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1285) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["1286"]["play"];//
    /// 后二 组选
    for(int two = 1287; two <= 1290; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 5;

      if (two == 1287) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1288) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 1289) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1290) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;


    /// 前二
    Map<String, dynamic> dataTopTwo = data["1269"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["1270"]["play"];//
    /// 前二 直选
    for(int two = 1271; two <= 1274; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 6;

      if (two == 1271) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1272) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 1273) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 1274) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["1275"]["play"];//
    /// 前二 组选
    for(int two = 1276; two <= 1279; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 6;
      if (two == 1276) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1277) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 1278) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 1279) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["1291"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["1292"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["1293"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 7;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["1294"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["1295"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 1296; two <= 1297; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1296) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 1297) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["1298"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 1299; two <= 1300; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1299) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 1300) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["1301"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 1302; two <= 1303; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1302) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 1303) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["1304"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 1305; two <= 1306; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1305) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 1306) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["1307"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 1308; two <= 1309; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 8;
      if (two == 1308) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 1309) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["1310"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["1311"]["play"];//任二

    for (int op = 1312; op <= 1314; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1312) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1313) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 1314) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["1315"]["play"];//任二

    for (int op = 1316; op <= 1319; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1316) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1317) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 1318) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 1319) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任四
    Map<String, dynamic> dataOptional1081 = dataOptionalPlay["1320"]["play"];//

    for (int op = 1321; op <= 1322; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional1081["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 9;
      if (op == 1321) {
        dataOptionalBeen.name = "任四复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 1322) {
        dataOptionalBeen.name = "任四单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["1323"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["1324"]["play"];//

    for (int op = 1325; op <= 1327; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 10;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["1328"];//
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["1329"]["play"];//

    for (int op = 1330; op <= 1366; op ++) {

      if (op == 1330 || op == 1334 || op == 1338 || op == 1342 || op == 1346 || op == 1350
          ||op == 1354 || op == 1358 || op == 1362 || op == 1366) {

        Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
        var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataInterestBeen.groupSelectionNum = 1;
        dataInterestBeen.playModeSingleOrDouble = 2;
        dataInterestBeen.playMode = 11;

        if (op == 1330) {
          Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["1331"];
          var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
          dataInterestBeen.remark = dataInterestBeen105.remark;
        }

        if (op == 1334) {
          Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["1335"];
          var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
          dataInterestBeen.remark = dataInterestBeen108.remark;
        }

        if (op == 1338) {
          Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["1339"];
          var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
          dataInterestBeen.remark = dataInterestBeen111.remark;
        }

        if (op == 1342) {
          Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["1343"];
          var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
          dataInterestBeen.remark = dataInterestBeen114.remark;
        }

        if (op == 1346) {
          Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["1347"];
          var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
          dataInterestBeen.remark = dataInterestBeen117.remark;
        }

        if (op == 1350) {
          Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["1351"];
          var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
          dataInterestBeen.remark = dataInterestBeen120.remark;
        }

        if (op == 1354) {
          Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["1355"];
          var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
          dataInterestBeen.remark = dataInterestBeen123.remark;
        }

        if (op == 1358) {
          Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["1359"];
          var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
          dataInterestBeen.remark = dataInterestBeen126.remark;
        }

        if (op == 1362) {
          Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["1363"];
          var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
          dataInterestBeen.remark = dataInterestBeen129.remark;
        }

        if (op == 1366) {
          Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["1367"];
          var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
          dataInterestBeen.remark = dataInterestBeen132.remark;
        }

        dataNewDragonTigerBeenPlayList.add(dataInterestBeen);

      }


    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;
  }


}