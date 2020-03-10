
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
class PlayModeHanoiOneLotteryController extends StatefulWidget{

  final List<Play11Choice5DataPlayBeen> playModeBeenList;
  final String colorVarietyID;

  const PlayModeHanoiOneLotteryController(
      {Key key,
        this.playModeBeenList,
        this.colorVarietyID
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayModeHanoiOneLotteryController(this.playModeBeenList, this.colorVarietyID);
  }

}

class _PlayModeHanoiOneLotteryController extends BaseController<PlayModeHanoiOneLotteryController> implements PlayMode11Choice5Handler {

  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  bool isChoiceType = false;//是否是有选择

  String colorVarietyID;


  _PlayModeHanoiOneLotteryController(this.playModeBeenList,
      this.colorVarietyID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((e) {
      GameService.instance.hanoiOneGetPlay(this, colorVarietyID);
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

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI}") {
      _PlayModeHanoiOneLottery(data);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_VIETNAME_HANOI_8}") {
      _PlayModeHanoi5Lottery(data);
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

  /// 河内一分彩
  _PlayModeHanoiOneLottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["145"];//前三
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//前三 直选

    List<Play11Choice5DataPlayBeen> dataTopThreePlayList = new List(); // 前三 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["146"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 147; i<= 150; i++) {
      //var dataTopThreePlayList = dataTopThreePlayBeen["$i"];//
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen["$i"];//三码
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 147) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 148) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 149) {
        topThreeMapBeen.name = "直选和值";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 150) {
        topThreeMapBeen.name = "直选跨度";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen);
    }
    /// 前三 组选
    var dataTopThreePlayBeen6 = dataThreeYardsPlay["151"]["play"];//

    for (int i = 152; i<= 155; i++) {
      if (i == 154) {
        continue;
      }
      //var dataTopThreePlayList = dataTopThreePlayBeen["$i"];//
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen6["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 1;
      if (i == 152) {
        //topThreeMapBeen.name = "组三";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 152) {
        //topThreeMapBeen.name = "组六";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
//      if (i == 9) {
//        //topThreeMapBeen.name = "混合组选";
//        topThreeMapBeen6.groupSelectionNum = 0;
//        topThreeMapBeen6.playModeSingleOrDouble = 1;
//      }
      if (i == 155) {
        //topThreeMapBeen.name = "组选和值";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen6);
    }

    var dataTopThreePlayBeen11 = dataThreeYardsPlay["156"]["play"];//11
    Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen11["157"];//三码 12
    var topThreeMapBeen11 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
    topThreeMapBeen11.groupSelectionNum = 1;
    topThreeMapBeen11.playModeSingleOrDouble = 2;
    topThreeMapBeen11.playMode = 1;

    choiceModeMap[threeYardsBeen] = dataTopThreePlayList;


    /// 中三
    Map<String, dynamic> middleThree = data["158"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["159"]["play"];

    for (int mi = 160; mi <= 163; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 2;
      if (mi == 160) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 161) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 162) {
        // middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 163) {
        //middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree19 = dataMiddleThreePlay["164"]["play"];//组选

    for (int mi = 165; mi <= 166; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree19["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 2;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree22 = dataMiddleThreePlay["167"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap = middleThree22["168"];//组选
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 2;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["169"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["170"]["play"];//后三 直选

    for (int lTi = 173; lTi <= 176; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 3;

      if (lTi == 173) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 174) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 175) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 176) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["171"]["play"];//后三 组选

    for (int lTi = 177; lTi <= 180; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 3;
      if (lTi == 177) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 178) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 179) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 180) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["172"]["play"];//后三 组选

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["181"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 3;

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["182"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["183"]["play"];//
    /// 后二 直选
    for(int two = 184; two <= 187; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 4;

      if (two == 184) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 185) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 186) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 187) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["199"]["play"];//
    /// 后二 组选
    for(int two = 200; two <= 203; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 4;

      if (two == 200) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 201) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 202) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 203) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;


    /// 前二
    Map<String, dynamic> dataTopTwo = data["188"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["189"]["play"];//
    /// 前二 直选
    for(int two = 190; two <= 193; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 5;

      if (two == 190) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 191) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 192) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 193) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["194"]["play"];//
    /// 前二 组选
    for(int two = 195; two <= 198; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 5;
      if (two == 195) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 196) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 197) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 198) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["204"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["205"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["206"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 6;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["207"];//前二
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["208"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 209; two <= 210; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 209) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 210) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["211"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 212; two <= 213; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 212) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 213) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["214"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 215; two <= 216; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 215) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 216) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["217"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 219; two <= 220; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 219) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 220) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["218"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 221; two <= 222; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 221) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 222) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["223"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["224"]["play"];//任二

    for (int op = 226; op <= 228; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 8;
      if (op == 226) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 227) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 228) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["225"]["play"];//任二

    for (int op = 229; op <= 232; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 8;
      if (op == 229) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 230) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 231) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 232) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }
    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["233"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["234"]["play"];//

    for (int op = 235; op <= 237; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 9;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["238"];//
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["239"]["play"];//

    for (int op = 240; op <= 249; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 10;

      if (op == 240) {
        Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["250"];
        var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
        dataInterestBeen.remark = dataInterestBeen105.remark;
      }

      if (op == 241) {
        Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["253"];
        var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
        dataInterestBeen.remark = dataInterestBeen108.remark;
      }

      if (op == 242) {
        Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["256"];
        var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
        dataInterestBeen.remark = dataInterestBeen111.remark;
      }

      if (op == 243) {
        Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["259"];
        var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
        dataInterestBeen.remark = dataInterestBeen114.remark;
      }

      if (op == 244) {
        Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["262"];
        var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
        dataInterestBeen.remark = dataInterestBeen117.remark;
      }

      if (op == 245) {
        Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["265"];
        var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
        dataInterestBeen.remark = dataInterestBeen120.remark;
      }

      if (op == 246) {
        Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["268"];
        var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
        dataInterestBeen.remark = dataInterestBeen123.remark;
      }

      if (op == 247) {
        Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["271"];
        var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
        dataInterestBeen.remark = dataInterestBeen126.remark;
      }

      if (op == 248) {
        Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["274"];
        var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
        dataInterestBeen.remark = dataInterestBeen129.remark;
      }

      if (op == 249) {
        Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["277"];
        var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
        dataInterestBeen.remark = dataInterestBeen132.remark;
      }

      dataNewDragonTigerBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;
  }

  /// 河内5分彩
  _PlayModeHanoi5Lottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["479"];//前三
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//前三 直选

    List<Play11Choice5DataPlayBeen> dataTopThreePlayList = new List(); // 前三 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["480"]["play"];//

    /// 前三 直选 2 3 4 5
    for (int i = 481; i<= 484; i++) {
      //var dataTopThreePlayList = dataTopThreePlayBeen["$i"];//
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen["$i"];//三码
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 481) {
        topThreeMapBeen.name = "直选复式";
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 482) {
        topThreeMapBeen.name = "直选单式";
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 483) {
        topThreeMapBeen.name = "直选和值";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 484) {
        topThreeMapBeen.name = "直选跨度";
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen);
    }
    /// 前三 组选
    var dataTopThreePlayBeen6 = dataThreeYardsPlay["485"]["play"];//

    for (int i = 486; i<= 488; i++) {
      //var dataTopThreePlayList = dataTopThreePlayBeen["$i"];//
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen6["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 1;
      if (i == 486) {
        //topThreeMapBeen.name = "组三";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 487) {
        //topThreeMapBeen.name = "组六";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 488) {
        //topThreeMapBeen.name = "组选和值";
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataTopThreePlayList.add(topThreeMapBeen6);
    }

    var dataTopThreePlayBeen11 = dataThreeYardsPlay["489"]["play"];//11
    Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen11["490"];//三码 12
    var topThreeMapBeen11 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
    topThreeMapBeen11.groupSelectionNum = 1;
    topThreeMapBeen11.playModeSingleOrDouble = 2;
    topThreeMapBeen11.playMode = 1;

    choiceModeMap[threeYardsBeen] = dataTopThreePlayList;


    /// 中三
    Map<String, dynamic> middleThree = data["491"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["492"]["play"];

    for (int mi = 493; mi <= 496; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 2;
      if (mi == 493) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 494) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 495) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 496) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree19 = dataMiddleThreePlay["497"]["play"];//组选

    for (int mi = 498; mi <= 499; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree19["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 2;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree22 = dataMiddleThreePlay["500"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap = middleThree22["501"];//组选
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 2;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeen);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["502"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["503"]["play"];//后三 直选

    for (int lTi = 504; lTi <= 507; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 3;

      if (lTi == 504) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 505) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 506) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 507) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["508"]["play"];//后三 组选

    for (int lTi = 509; lTi <= 512; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 3;
      if (lTi == 509) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 510) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 511) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 512) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["513"]["play"];//后三 其他

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["514"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 3;

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["515"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["516"]["play"];//
    /// 后二 直选
    for(int two = 517; two <= 520; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 4;

      if (two == 517) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 2;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 518) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 519) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 520) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["521"]["play"];//
    /// 后二 组选
    for(int two = 522; two <= 525; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 4;

      if (two == 522) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 523) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 524) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 525) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;


    /// 前二
    Map<String, dynamic> dataTopTwo = data["526"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["527"]["play"];//
    /// 前二 直选
    for(int two = 528; two <= 531; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 5;

      if (two == 528) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 529) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 530) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 531) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["532"]["play"];//
    /// 前二 组选
    for(int two = 533; two <= 536; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 5;
      if (two == 533) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 534) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 535) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 536) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["537"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["538"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["539"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 6;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["540"];//前二
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["541"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 542; two <= 543; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 542) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 543) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["544"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 545; two <= 546; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 545) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 546) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["547"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 548; two <= 549; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 548) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 549) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["550"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 551; two <= 552; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 551) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 552) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["553"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 554; two <= 555; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 7;
      if (two == 554) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 555) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["556"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["557"]["play"];//任二

    for (int op = 558; op <= 560; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 8;
      if (op == 558) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 559) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 560) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["561"]["play"];//任二

    for (int op = 562; op <= 565; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 8;
      if (op == 562) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 563) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 564) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 565) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }
    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["566"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["567"]["play"];//

    for (int op = 568; op <= 570; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 9;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["571"];//
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["572"]["play"];//

    for (int op = 573; op <= 609; op ++) {

      if (op == 573 || op == 577 || op == 581 || op == 585 || op == 589 ||
          op == 593 || op == 597 || op == 601 || op == 605 || op == 609) {

        Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
        var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataInterestBeen.groupSelectionNum = 1;
        dataInterestBeen.playModeSingleOrDouble = 2;
        dataInterestBeen.playMode = 10;

        if (op == 573) {
          Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["574"];
          var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
          dataInterestBeen.remark = dataInterestBeen105.remark;
        }

        if (op == 577) {
          Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["578"];
          var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
          dataInterestBeen.remark = dataInterestBeen108.remark;
        }

        if (op == 581) {
          Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["582"];
          var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
          dataInterestBeen.remark = dataInterestBeen111.remark;
        }

        if (op == 585) {
          Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["586"];
          var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
          dataInterestBeen.remark = dataInterestBeen114.remark;
        }

        if (op == 589) {
          Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["590"];
          var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
          dataInterestBeen.remark = dataInterestBeen117.remark;
        }

        if (op == 593) {
          Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["594"];
          var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
          dataInterestBeen.remark = dataInterestBeen120.remark;
        }

        if (op == 597) {
          Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["598"];
          var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
          dataInterestBeen.remark = dataInterestBeen123.remark;
        }

        if (op == 601) {
          Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["602"];
          var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
          dataInterestBeen.remark = dataInterestBeen126.remark;
        }

        if (op == 605) {
          Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["606"];
          var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
          dataInterestBeen.remark = dataInterestBeen129.remark;
        }

        if (op == 609) {
          Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["610"];
          var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
          dataInterestBeen.remark = dataInterestBeen132.remark;
        }

        dataNewDragonTigerBeenPlayList.add(dataInterestBeen);
      }
    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;
  }

}