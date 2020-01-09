
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
class PlayMode11Choice5Controller extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayMode11Choice5Controller();
  }

}

class _PlayMode11Choice5Controller extends BaseController<PlayMode11Choice5Controller> implements PlayMode11Choice5Handler {

  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  bool isChoiceType = false;//是否是有选择

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((e) {
      GameService.instance.getPlay(this);
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
                case "三码":
                case "二码":
                case "任选":
                  playTypeName = "$typeNam${play11choice5dataPlayBeen.name}";
                  break;
                case "不定胆":
                  playTypeName = "${play11choice5dataPlayBeen.name}$typeNam";
                  break;
                case "定位胆":
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
          setState(() {

          });
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

    Map<String, dynamic> dataThreeYards = data["0"];//三码
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];//三码 直选 复式
//    Map<String, dynamic> dataThreeYardsOneD = dataThreeYards["1"]["4"];//三码 直选 单式
//    Map<String, dynamic> dataThreeYardsTwoF = dataThreeYards["2"]["5"];//三码 组合 复式
//    Map<String, dynamic> dataThreeYardsTwoD = dataThreeYards["2"]["6"];//三码 组合 单式
    List<Play11Choice5DataPlayBeen> threeYardsList = new List();
    for (int yards = 1; yards <= 2; yards++) {

      var dataThreeYardsPlay2 = dataThreeYardsPlay["$yards"]["play"];
      Map<String, dynamic> dataThreeYardsOneF = dataThreeYardsPlay2["${(2 * yards) + 1}"];//三码
      Map<String, dynamic> dataThreeYardsOneD = dataThreeYardsPlay2["${(2 * yards) + 2}"];//三码
      var play11Choice5DataPlayBeenF = Play11Choice5DataPlayBeen.fromJson(dataThreeYardsOneF);
      var play11Choice5DataPlayBeenD = Play11Choice5DataPlayBeen.fromJson(dataThreeYardsOneD);
      if (yards == 1) {
        play11Choice5DataPlayBeenF.name = "直选复式";

        play11Choice5DataPlayBeenD.name = "直选单式";
        play11Choice5DataPlayBeenF.isGroupSelection = false;
        play11Choice5DataPlayBeenD.isGroupSelection = false;
        play11Choice5DataPlayBeenF.groupSelectionNum = 3;
        play11Choice5DataPlayBeenD.groupSelectionNum = 0;

      } else {
        play11Choice5DataPlayBeenF.name = "组合复式";
        play11Choice5DataPlayBeenD.name = "组合单式";

        play11Choice5DataPlayBeenF.isGroupSelection = true;
        play11Choice5DataPlayBeenD.isGroupSelection = true;
        play11Choice5DataPlayBeenF.groupSelectionNum = 1;
        play11Choice5DataPlayBeenD.groupSelectionNum = 0;

      }

      play11Choice5DataPlayBeenF.playMode = 1;
      play11Choice5DataPlayBeenF.playModeTitle = "";
      play11Choice5DataPlayBeenF.playModeSingleOrDouble = 2;

      play11Choice5DataPlayBeenD.playMode = 1;
      play11Choice5DataPlayBeenD.playModeTitle = "";
      play11Choice5DataPlayBeenD.playModeSingleOrDouble = 1;

      threeYardsList.add(play11Choice5DataPlayBeenF);
      threeYardsList.add(play11Choice5DataPlayBeenD);

    }
    choiceModeMap[threeYardsBeen] = threeYardsList;

    /// 二码
    Map<String, dynamic> dataTwoYards = data["7"];//二码
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTwoYards);
    Map<String, dynamic> dataTwoYardsPlay = dataTwoYards["play"];//二码
    List<Play11Choice5DataPlayBeen> twoYardsList = new List();
    for (int yards = 8; yards <= 8; yards++) {

      var dataTwoYardsPlay2 = dataTwoYardsPlay["$yards"]["play"];
      Map<String, dynamic> dataTwoYardsOneF = dataTwoYardsPlay2["${yards + 2}"];//二码
      Map<String, dynamic> dataTwoYardsOneD = dataTwoYardsPlay2["${yards + 3}"];//二码
      var play11Choice5DataPlayBeenF = Play11Choice5DataPlayBeen.fromJson(dataTwoYardsOneF);
      var play11Choice5DataPlayBeenD = Play11Choice5DataPlayBeen.fromJson(dataTwoYardsOneD);
      if (yards == 8) {
        play11Choice5DataPlayBeenF.name = "直选复式";
        play11Choice5DataPlayBeenD.name = "直选单式";

        play11Choice5DataPlayBeenF.isGroupSelection = false;
        play11Choice5DataPlayBeenF.playMode = 2;
        play11Choice5DataPlayBeenF.playModeTitle = "";
        play11Choice5DataPlayBeenF.playModeSingleOrDouble = 2;

        play11Choice5DataPlayBeenD.isGroupSelection = false;
        play11Choice5DataPlayBeenD.playMode = 2;
        play11Choice5DataPlayBeenD.playModeTitle = "";
        play11Choice5DataPlayBeenD.playModeSingleOrDouble = 1;
      }
      twoYardsList.add(play11Choice5DataPlayBeenF);
      twoYardsList.add(play11Choice5DataPlayBeenD);
    }

//    List<Play11Choice5DataPlayBeen> threeYardsList = new List();
    Map<String, dynamic> dataTwoYardsTwoPlay = dataTwoYards["play"];//二码
    var dataTwoYardsTwoPlay2 = dataTwoYardsTwoPlay["9"]["play"];
    Map<String, dynamic> dataTwoYardsOneF = dataTwoYardsTwoPlay2["35"];//二码
    Map<String, dynamic> dataTwoYardsOneD = dataTwoYardsTwoPlay2["36"];//二码
    var play11Choice5DataPlayBeenF = Play11Choice5DataPlayBeen.fromJson(dataTwoYardsOneF);
    var play11Choice5DataPlayBeenD = Play11Choice5DataPlayBeen.fromJson(dataTwoYardsOneD);
    play11Choice5DataPlayBeenF.name = "组合复式";
    play11Choice5DataPlayBeenD.name = "组合单式";

    play11Choice5DataPlayBeenF.isGroupSelection = true;
    play11Choice5DataPlayBeenF.playMode = 2;
    play11Choice5DataPlayBeenF.playModeTitle = "";
    play11Choice5DataPlayBeenF.playModeSingleOrDouble = 2;

    play11Choice5DataPlayBeenD.isGroupSelection = true;
    play11Choice5DataPlayBeenD.playMode = 2;
    play11Choice5DataPlayBeenD.playModeTitle = "";
    play11Choice5DataPlayBeenD.playModeSingleOrDouble = 1;

    twoYardsList.add(play11Choice5DataPlayBeenF);
    twoYardsList.add(play11Choice5DataPlayBeenD);
    choiceModeMap[twoYardsBeen] = twoYardsList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["12"];//不定胆
    var uncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);

    Map<String, dynamic> uncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> uncertainGallbladderBeenF = uncertainGallbladderPlay["13"];//
    List<Play11Choice5DataPlayBeen> uncertainGallbladderList = new List();
    var uncertainGallbladderBeenD = Play11Choice5DataPlayBeen.fromJson(uncertainGallbladderBeenF);

    uncertainGallbladderBeenD.isGroupSelection = false;
    uncertainGallbladderBeenD.groupSelectionNum = 1;
    uncertainGallbladderBeenD.playMode = 3;
    uncertainGallbladderBeenD.playModeTitle = "选号";
    uncertainGallbladderBeenD.playModeSingleOrDouble = 1;

    uncertainGallbladderList.add(uncertainGallbladderBeenD);
    choiceModeMap[uncertainGallbladderBeen] = uncertainGallbladderList;

    /// 定胆
    Map<String, dynamic> dataCertainGallbladder = data["14"];//定胆
    var certainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataCertainGallbladder);
    Map<String, dynamic> certainGallbladderPlay = dataCertainGallbladder["play"];//

    Map<String, dynamic> certainGallbladderBeenF = certainGallbladderPlay["15"];//
    List<Play11Choice5DataPlayBeen> certainGallbladderList = new List();
    var certainGallbladderBeenD = Play11Choice5DataPlayBeen.fromJson(certainGallbladderBeenF);

    certainGallbladderBeenD.isGroupSelection = true;
    certainGallbladderBeenD.groupSelectionNum = 3;
    certainGallbladderBeenD.playMode = 4;
    certainGallbladderBeenD.playModeTitle = "选号";
    certainGallbladderBeenD.playModeSingleOrDouble = 0;

    certainGallbladderList.add(certainGallbladderBeenD);
    choiceModeMap[certainGallbladderBeen] = certainGallbladderList;

    /// 任选
    Map<String, dynamic> dataOptional = data["16"];//任选
    var OptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//二码



    /// 任选 复式
    var dataOptionalPlay17 = dataOptionalPlay["17"]["play"];

    List<Play11Choice5DataPlayBeen> optionalList = new List();
    for(int optional = 27; optional < 34; optional++) {
      Map<String, dynamic> optionalMapF = dataOptionalPlay17["$optional"];//复式

//      List<Play11Choice5DataPlayBeen> optionalList = new List();
      var optionalBeenF = Play11Choice5DataPlayBeen.fromJson(optionalMapF);

      optionalBeenF.isGroupSelection = false;
      optionalBeenF.playMode = 5;
      optionalBeenF.playModeTitle = "${optionalBeenF.name}";
      optionalBeenF.playModeSingleOrDouble = 2;

      optionalBeenF.name = "复式${optionalBeenF.name}";

      optionalList.add(optionalBeenF);
      choiceModeMap[OptionalBeen] = optionalList;

    }

    var dataOptionalPlay18 = dataOptionalPlay["18"]["play"];
    /// 任选 单式
    for(int optional = 19; optional < 25; optional++) {
      Map<String, dynamic> optionalMapF = dataOptionalPlay18["$optional"];//复式

      var optionalBeenD = Play11Choice5DataPlayBeen.fromJson(optionalMapF);

      optionalBeenD.isGroupSelection = false;
      optionalBeenD.playMode = 5;
      optionalBeenD.playModeTitle = "${optionalBeenD.name}";
      optionalBeenD.playModeSingleOrDouble = 1;
      optionalBeenD.name = "单式${optionalBeenD.name}";

      optionalList.add(optionalBeenD);
    }
    choiceModeMap[OptionalBeen] = optionalList;

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