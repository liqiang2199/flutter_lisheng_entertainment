
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
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
 * 11 选5 玩法选择
 */
class PlayModeHanoiOneLotteryController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayModeHanoiOneLotteryController();
  }

}

class _PlayModeHanoiOneLotteryController extends BaseController<PlayModeHanoiOneLotteryController> implements PlayMode11Choice5Handler {

  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  bool isChoiceType = false;//是否是有选择

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((e) {
      GameService.instance.hanoiOneGetPlay(this);
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
            , style: TextStyle(fontSize: 13.0,color: Color(colorId)),),
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

    Map<String, dynamic> dataThreeYards = data["0"];//前三
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//前三 直选

    List<Play11Choice5DataPlayBeen> dataTopThreePlayList = new List(); // 前三 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["1"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 2; i<= 5; i++) {
      //var dataTopThreePlayList = dataTopThreePlayBeen["$i"];//
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen["$i"];//三码
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 2) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 3) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 4) {
        topThreeMapBeen.name = "直选和值";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 5) {
        topThreeMapBeen.name = "直选跨度";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen);
    }
    /// 前三 组选
    var dataTopThreePlayBeen6 = dataThreeYardsPlay["6"]["play"];//

    for (int i = 7; i<= 10; i++) {
      //var dataTopThreePlayList = dataTopThreePlayBeen["$i"];//
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen6["$i"];//三码
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 1;
      if (i == 7) {
        //topThreeMapBeen.name = "组三";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 8) {
        //topThreeMapBeen.name = "组六";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 9) {
        //topThreeMapBeen.name = "混合组选";
        topThreeMapBeen6.groupSelectionNum = 0;
        topThreeMapBeen6.playModeSingleOrDouble = 1;
      }
      if (i == 10) {
        //topThreeMapBeen.name = "组选和值";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen6);
    }

    var dataTopThreePlayBeen11 = dataThreeYardsPlay["11"]["play"];//
    Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen11["12"];//三码
    var topThreeMapBeen11 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
    topThreeMapBeen11.groupSelectionNum = 1;
    topThreeMapBeen11.playModeSingleOrDouble = 2;
    topThreeMapBeen11.playMode = 1;

    choiceModeMap[threeYardsBeen] = dataTopThreePlayList;


    /// 中三
    Map<String, dynamic> middleThree = data["13"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["14"]["play"];

    for (int mi = 15; mi <= 18; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 2;
      if (mi == 15) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 16) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 17) {
       // middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 18) {
        //middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree19 = dataMiddleThreePlay["19"]["play"];//组选

    for (int mi = 20; mi <= 21; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree19["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 2;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree22 = dataMiddleThreePlay["22"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap = middleThree22["23"];//组选
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 2;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["24"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["25"]["play"];//后三 直选

    for (int lTi = 28; lTi <= 31; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 3;

      if (lTi == 28) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 29) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 30) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 31) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["26"]["play"];//后三 组选

    for (int lTi = 32; lTi <= 35; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 3;
      if (lTi == 32) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 33) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 34) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 35) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["27"]["play"];//后三 组选

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["36"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 3;

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["37"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["38"]["play"];//
    /// 后二 直选
    for(int two = 39; two <= 42; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 4;

      if (two == 39) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 40) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 41) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 42) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["54"]["play"];//
    /// 后二 组选
    for(int two = 55; two <= 58; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 4;

      if (two == 55) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 56) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 57) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 58) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;


    /// 前二
    Map<String, dynamic> dataTopTwo = data["43"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["44"]["play"];//
    /// 前二 直选
    for(int two = 45; two <= 48; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 5;

      if (two == 45) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 46) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 47) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 48) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["49"]["play"];//
    /// 前二 组选
    for(int two = 50; two <= 53; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 5;
      if (two == 50) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 51) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 52) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 53) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["59"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["60"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["61"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 6;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["62"];//前二
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["63"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 64; two <= 65; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 64) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 65) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["66"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 67; two <= 68; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 67) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 68) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["69"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 70; two <= 71; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 70) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 71) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["72"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 74; two <= 75; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 74) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 75) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["73"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 76; two <= 77; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 76) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 77) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["78"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["79"]["play"];//任二

    for (int op = 81; op <= 83; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 8;
      if (op == 81) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 82) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 83) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["80"]["play"];//任二

    for (int op = 84; op <= 87; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 8;
      if (op == 84) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 85) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 86) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 87) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }
    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["88"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["89"]["play"];//

    for (int op = 90; op <= 92; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 9;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["93"];//趣味
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["94"]["play"];//

    for (int op = 95; op <= 104; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 10;

      if (op == 95) {
        Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["105"];
        var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
        dataInterestBeen.remark = dataInterestBeen105.remark;
      }

      if (op == 96) {
        Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["108"];
        var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
        dataInterestBeen.remark = dataInterestBeen108.remark;
      }

      if (op == 97) {
        Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["111"];
        var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
        dataInterestBeen.remark = dataInterestBeen111.remark;
      }

      if (op == 98) {
        Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["114"];
        var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
        dataInterestBeen.remark = dataInterestBeen114.remark;
      }

      if (op == 99) {
        Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["117"];
        var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
        dataInterestBeen.remark = dataInterestBeen117.remark;
      }

      if (op == 100) {
        Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["120"];
        var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
        dataInterestBeen.remark = dataInterestBeen120.remark;
      }

      if (op == 101) {
        Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["123"];
        var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
        dataInterestBeen.remark = dataInterestBeen123.remark;
      }

      if (op == 102) {
        Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["126"];
        var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
        dataInterestBeen.remark = dataInterestBeen126.remark;
      }

      if (op == 103) {
        Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["129"];
        var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
        dataInterestBeen.remark = dataInterestBeen129.remark;
      }

      if (op == 104) {
        Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["132"];
        var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
        dataInterestBeen.remark = dataInterestBeen132.remark;
      }

      dataNewDragonTigerBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;

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

}