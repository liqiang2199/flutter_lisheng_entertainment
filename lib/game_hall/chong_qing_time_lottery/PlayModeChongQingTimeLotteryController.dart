

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataThreeYardsBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import '../net/PlayMode11Choice5Handler.dart';

/**
 * 重庆时时彩
 */
///
class PlayModeChongQingTimeLotteryController extends StatefulWidget{

  final List<Play11Choice5DataPlayBeen> playModeBeenList;
  final String colorVarietyID;

  const PlayModeChongQingTimeLotteryController({
    Key key,
    this.playModeBeenList,
    this.colorVarietyID
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayModeChongQingTimeLotteryController(this.playModeBeenList, this.colorVarietyID);
  }

}

class _PlayModeChongQingTimeLotteryController extends BaseController<PlayModeChongQingTimeLotteryController> implements PlayMode11Choice5Handler {

  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  bool isChoiceType = false;//是否是有选择

  String _colorVarietyID;


  _PlayModeChongQingTimeLotteryController(
      this.playModeBeenList,
      this._colorVarietyID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((e) {

      GameService.instance.tencentGetPlay(this, _colorVarietyID);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (!isChoiceType) {
      Map arguments = ModalRoute.of(context).settings.arguments;
      if (arguments != null) {

        arguments.forEach((k,v){
          if (k.toString() == "playModeBeenList") {
            playModeBeenList = v;
          }
          if (k.toString() == "ColorVarietyID") {
            _colorVarietyID = v;
          }
        });


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
                case "后四":
                case "后二":
                case "前二":
                case "龙虎":
                case "五星":
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

    if(_colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
      _tencentOneLottery(data);
    }

    if(_colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
      _tencentFiveLottery(data);
    }

    if(_colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
      _tencent10Lottery(data);
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

  /// 腾讯一分彩
  _tencentOneLottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["280"];//五星
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];

    List<Play11Choice5DataPlayBeen> dataFiveStarsPlayList = new List(); // 五星 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["281"]["play"];///五星

    /// 五星 直选  282 284
    Map<String, dynamic> dataFiveStarsPlayMapZ = dataTopThreePlayBeen["282"];//五星 复式
    var dataFiveStarsMapBeenZ = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapZ);
    dataFiveStarsMapBeenZ.playMode = 1;
    dataFiveStarsMapBeenZ.name = "直选复式";
    dataFiveStarsMapBeenZ.groupSelectionNum = 3;
    dataFiveStarsMapBeenZ.playModeSingleOrDouble = 2;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenZ);


    Map<String, dynamic> dataFiveStarsPlayMapD = dataTopThreePlayBeen["284"];//五星 单式
    var dataFiveStarsMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapD);
    dataFiveStarsMapBeenD.playMode = 1;
    dataFiveStarsMapBeenD.name = "直选单式";
    dataFiveStarsMapBeenD.groupSelectionNum = 0;
    dataFiveStarsMapBeenD.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenD);

    /// 五星 组选
    var dataTopThreePlayBeen285 = dataThreeYardsPlay["285"]["play"];//

    for (int i = 286; i<= 290; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen285["$i"];//五星 组选
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 286) {
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 287) {
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 288) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 289) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 290) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataFiveStarsPlayList.add(topThreeMapBeen);
    }

    var dataTopThreePlayBeen292 = dataThreeYardsPlay["292"]["play"];//
    //总和大小单双
    Map<String, dynamic> dataFiveStarsPlayMapDXDS = dataTopThreePlayBeen292["293"];//五星 复式
    var dataFiveStarsMapBeenDXDS = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapDXDS);
    dataFiveStarsMapBeenDXDS.playMode = 1;
    dataFiveStarsMapBeenDXDS.groupSelectionNum = 0;
    dataFiveStarsMapBeenDXDS.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenDXDS);

    choiceModeMap[threeYardsBeen] = dataFiveStarsPlayList;

    /// 后四
    Map<String, dynamic> dataLaterFour = data["294"];//五星
    var laterFourBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterFour);
    var dataLaterFourBeen294 = dataLaterFour["play"];//
    List<Play11Choice5DataPlayBeen> dataLaterFourPlayList = new List(); // 后四 列表

    var dataTopThreePlayBeen295 = dataLaterFourBeen294["295"]["play"];//
    Map<String, dynamic> dataLaterFourPlayMapF = dataTopThreePlayBeen295["297"];//五星 复式
    var dataLaterFourMapBeenF = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapF);
    dataLaterFourMapBeenF.playMode = 2;
    dataLaterFourMapBeenF.groupSelectionNum = 0;
    dataLaterFourMapBeenF.name = "直选复式";
    dataLaterFourMapBeenF.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenF);

    Map<String, dynamic> dataLaterFourPlayMapD = dataTopThreePlayBeen295["298"];//五星 复式
    var dataLaterFourMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapD);
    dataLaterFourMapBeenD.playMode = 2;
    dataLaterFourMapBeenD.name = "直选单式";
    dataLaterFourMapBeenD.groupSelectionNum = 0;
    dataLaterFourMapBeenD.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenD);

    /// 后四组选
    var dataPlayBeen296 = dataLaterFourBeen294["296"]["play"];//

    for (int i = 300; i<= 303; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataPlayBeen296["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 300) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 301) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 302) {
        topThreeMapBeen6.groupSelectionNum = 0;
        topThreeMapBeen6.playModeSingleOrDouble = 1;
      }
      if (i == 303) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataLaterFourPlayList.add(topThreeMapBeen6);
    }

    choiceModeMap[laterFourBeen] = dataLaterFourPlayList;


    /// 前三
    Map<String, dynamic> topThree = data["304"];//前三
    var topThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(topThree);
    Map<String, dynamic> dataTopThreePlay = topThree["play"];//前三

    List<Play11Choice5DataPlayBeen> topThreeList = new List();

    Map<String, dynamic> topThree305 = dataTopThreePlay["305"]["play"];

    for (int mi = 308; mi <= 311; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree305["$mi"];//前三
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 3;
      if (mi == 308) {
        topThreePlayBeen.name = "直选复式";
        topThreePlayBeen.groupSelectionNum = 3;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 309) {
        topThreePlayBeen.name = "直选单式";
        topThreePlayBeen.groupSelectionNum = 0;
        topThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 310) {
        topThreePlayBeen.groupSelectionNum = 1;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 311) {
        topThreePlayBeen.groupSelectionNum = 1;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }
      topThreeList.add(topThreePlayBeen);
    }

    var topThree306 = dataTopThreePlay["306"]["play"];//组选

    for (int mi = 312; mi <= 314; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree306["$mi"];//组选
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 3;
      topThreePlayBeen.groupSelectionNum = 1;
      topThreePlayBeen.playModeSingleOrDouble = 2;

      topThreeList.add(topThreePlayBeen);
    }

    var middleThree22 = dataTopThreePlay["307"]["play"];//其他

    Map<String, dynamic> middleThreeDataMap = middleThree22["315"];//尾选和值
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 3;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    topThreeList.add(middleThreePlayBeen);

    choiceModeMap[topThreeBeen] = topThreeList;

    /// 中三
    Map<String, dynamic> middleThree = data["316"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["317"]["play"];

    for (int mi = 320; mi <= 323; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 4;
      if (mi == 320) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 321) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 322) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 323) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree318 = dataMiddleThreePlay["318"]["play"];//组选

    for (int mi = 324; mi <= 325; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree318["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 4;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree319 = dataMiddleThreePlay["319"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap326 = middleThree319["326"];// 和值尾数
    var middleThreePlayBeenSum = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap326);
    middleThreePlayBeenSum.playMode = 4;
    middleThreePlayBeenSum.groupSelectionNum = 1;
    middleThreePlayBeenSum.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeenSum);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["327"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["328"]["play"];//后三 直选

    for (int lTi = 331; lTi <= 334; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 5;

      if (lTi == 331) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 332) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 333) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 334) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["329"]["play"];//后三 组选

    for (int lTi = 335; lTi <= 337; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 5;
      if (lTi == 335) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 336) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 337) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["330"]["play"];//后三 和值尾数

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["338"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 5;
    dataLaterThreePlayList.add(dataLaterThreePlayBeen);

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 前二
    Map<String, dynamic> dataTopTwo = data["339"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["340"]["play"];//
    /// 前二 直选
    for(int two = 342; two <= 345; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 6;

      if (two == 342) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 343) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 344) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 345) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["341"]["play"];//
    /// 前二 组选
    for(int two = 346; two <= 349; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 6;
      if (two == 346) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 347) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 348) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 349) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["350"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["351"]["play"];//
    /// 后二 直选
    for(int two = 353; two <= 356; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 7;

      if (two == 353) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 354) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 355) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 356) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["352"]["play"];//
    /// 后二 组选
    for(int two = 357; two <= 358; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 7;

      if (two == 357) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 358) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["359"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["360"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["361"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 8;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["362"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["363"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 368; two <= 369; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 368) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 369) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["364"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 370; two <= 371; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 370) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 371) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["365"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 372; two <= 373; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 372) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 373) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["366"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 374; two <= 375; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 374) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 375) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["367"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 376; two <= 377; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 376) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 377) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["378"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["379"]["play"];//任二

    for (int op = 382; op <= 384; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 10;
      if (op == 382) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 383) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 384) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["380"]["play"];//任二

    for (int op = 385; op <= 388; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 10;
      if (op == 385) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 386) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 387) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 388) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    if (dataOptionalPlay["381"] != null) {
      /// 任四
      Map<String, dynamic> dataOptional381 = dataOptionalPlay["381"]["play"];//任二

      for (int op = 389; op <= 390; op ++) {
        Map<String, dynamic> dataOptionalPlayOP = dataOptional381["$op"];
        var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataOptionalBeen.playMode = 10;
        if (op == 389) {
          dataOptionalBeen.name = "任四复式";
          dataOptionalBeen.groupSelectionNum = 5;
          dataOptionalBeen.playModeSingleOrDouble = 2;
        }

        if (op == 390) {
          dataOptionalBeen.name = "任四单式";
          dataOptionalBeen.groupSelectionNum = 0;
          dataOptionalBeen.playModeSingleOrDouble = 1;
        }

        dataOptionalBeenPlayList.add(dataOptionalBeen);
      }
    }

    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["391"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["392"]["play"];//

    for (int op = 393; op <= 396; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 11;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 龙虎
    Map<String, dynamic> dataDragonTiger = data["397"];//
    if (dataDragonTiger != null) {
      var dataDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataDragonTiger);
      List<Play11Choice5DataPlayBeen> dataDragonTigerBeenPlayList = new List();

      Map<String, dynamic> dataDragonTigerPlay = dataDragonTiger["play"];//

      Map<String, dynamic> dataInterest398 = dataDragonTigerPlay["398"]["play"];//

      for (int op = 399; op <= 407; op ++) {
        Map<String, dynamic> dataOptionalPlayOP = dataInterest398["$op"];
        var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataInterestBeen.groupSelectionNum = 1;
        dataInterestBeen.playModeSingleOrDouble = 2;
        dataInterestBeen.playMode = 12;

        if (op == 399) {
          Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["399"];
          var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
          dataInterestBeen.remark = dataInterestBeen105.remark;
        }

        if (op == 400) {
          Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["400"];
          var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
          dataInterestBeen.remark = dataInterestBeen108.remark;
        }

        if (op == 401) {
          Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["401"];
          var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
          dataInterestBeen.remark = dataInterestBeen111.remark;
        }

        if (op == 402) {
          Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["402"];
          var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
          dataInterestBeen.remark = dataInterestBeen114.remark;
        }

        if (op == 403) {
          Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["403"];
          var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
          dataInterestBeen.remark = dataInterestBeen117.remark;
        }

        if (op == 404) {
          Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["404"];
          var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
          dataInterestBeen.remark = dataInterestBeen120.remark;
        }

        if (op == 405) {
          Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["405"];
          var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
          dataInterestBeen.remark = dataInterestBeen123.remark;
        }

        if (op == 406) {
          Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["406"];
          var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
          dataInterestBeen.remark = dataInterestBeen126.remark;
        }

        if (op == 407) {
          Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["407"];
          var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
          dataInterestBeen.remark = dataInterestBeen129.remark;
        }


        dataDragonTigerBeenPlayList.add(dataInterestBeen);
      }

      choiceModeMap[dataDragonTigerBeen] = dataDragonTigerBeenPlayList;
    }

    /// 新龙虎
    Map<String, dynamic> dataNewDragonTiger = data["435"];//
    var dataNewDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataNewDragonTiger);
    List<Play11Choice5DataPlayBeen> dataNewDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataNewDragonTigerPlay = dataNewDragonTiger["play"];//

    Map<String, dynamic> dataInterest94 = dataNewDragonTigerPlay["436"]["play"];//

    for (int op = 437; op <= 446; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest94["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 13;



      if (op == 437) {
        Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["447"];
        var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
        dataInterestBeen.remark = dataInterestBeen105.remark;
      }

      if (op == 438) {
        Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["450"];
        var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
        dataInterestBeen.remark = dataInterestBeen108.remark;
      }

      if (op == 439) {
        Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["453"];
        var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
        dataInterestBeen.remark = dataInterestBeen111.remark;
      }

      if (op == 440) {
        Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["456"];
        var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
        dataInterestBeen.remark = dataInterestBeen114.remark;
      }

      if (op == 441) {
        Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["459"];
        var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
        dataInterestBeen.remark = dataInterestBeen117.remark;
      }

      if (op == 442) {
        Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["462"];
        var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
        dataInterestBeen.remark = dataInterestBeen120.remark;
      }

      if (op == 443) {
        Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["465"];
        var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
        dataInterestBeen.remark = dataInterestBeen123.remark;
      }

      if (op == 444) {
        Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["468"];
        var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
        dataInterestBeen.remark = dataInterestBeen126.remark;
      }

      if (op == 445) {
        Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["471"];
        var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
        dataInterestBeen.remark = dataInterestBeen129.remark;
      }

      if (op == 446) {
        Map<String, dynamic> dataOptionalPlayOPPlay132 = dataOptionalPlayOP["play"]["474"];
        var dataInterestBeen132  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay132);
        dataInterestBeen.remark = dataInterestBeen132.remark;
      }

      dataNewDragonTigerBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataNewDragonTigerBeen] = dataNewDragonTigerBeenPlayList;
  }

  /// 腾讯5分彩
  _tencentFiveLottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["613"];//五星
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];

    List<Play11Choice5DataPlayBeen> dataFiveStarsPlayList = new List(); // 五星 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["614"]["play"];///五星

    /// 五星 直选  282 284
    Map<String, dynamic> dataFiveStarsPlayMapZ = dataTopThreePlayBeen["615"];//五星 复式
    var dataFiveStarsMapBeenZ = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapZ);
    dataFiveStarsMapBeenZ.playMode = 1;
    dataFiveStarsMapBeenZ.name = "直选复式";
    dataFiveStarsMapBeenZ.groupSelectionNum = 3;
    dataFiveStarsMapBeenZ.playModeSingleOrDouble = 2;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenZ);


    Map<String, dynamic> dataFiveStarsPlayMapD = dataTopThreePlayBeen["616"];//五星 单式
    var dataFiveStarsMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapD);
    dataFiveStarsMapBeenD.playMode = 1;
    dataFiveStarsMapBeenD.name = "直选单式";
    dataFiveStarsMapBeenD.groupSelectionNum = 0;
    dataFiveStarsMapBeenD.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenD);

    /// 五星 组选
    var dataTopThreePlayBeen285 = dataThreeYardsPlay["617"]["play"];//

    for (int i = 618; i<= 622; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen285["$i"];//五星 组选
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 618) {
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 619) {
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 620) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 621) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 622) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataFiveStarsPlayList.add(topThreeMapBeen);
    }

    var dataTopThreePlayBeen292 = dataThreeYardsPlay["623"]["play"];//
    //总和大小单双
    Map<String, dynamic> dataFiveStarsPlayMapDXDS = dataTopThreePlayBeen292["624"];//五星 复式
    var dataFiveStarsMapBeenDXDS = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapDXDS);
    dataFiveStarsMapBeenDXDS.playMode = 1;
    dataFiveStarsMapBeenDXDS.groupSelectionNum = 0;
    dataFiveStarsMapBeenDXDS.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenDXDS);

    choiceModeMap[threeYardsBeen] = dataFiveStarsPlayList;

    /// 后四
    Map<String, dynamic> dataLaterFour = data["625"];//五星
    var laterFourBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterFour);
    var dataLaterFourBeen294 = dataLaterFour["play"];//
    List<Play11Choice5DataPlayBeen> dataLaterFourPlayList = new List(); // 后四 列表

    var dataTopThreePlayBeen295 = dataLaterFourBeen294["626"]["play"];//
    Map<String, dynamic> dataLaterFourPlayMapF = dataTopThreePlayBeen295["627"];//五星 复式
    var dataLaterFourMapBeenF = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapF);
    dataLaterFourMapBeenF.playMode = 2;
    dataLaterFourMapBeenF.groupSelectionNum = 0;
    dataLaterFourMapBeenF.name = "直选复式";
    dataLaterFourMapBeenF.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenF);

    Map<String, dynamic> dataLaterFourPlayMapD = dataTopThreePlayBeen295["628"];//五星 复式
    var dataLaterFourMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapD);
    dataLaterFourMapBeenD.playMode = 2;
    dataLaterFourMapBeenD.name = "直选单式";
    dataLaterFourMapBeenD.groupSelectionNum = 0;
    dataLaterFourMapBeenD.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenD);

    /// 后四组选
    var dataPlayBeen296 = dataLaterFourBeen294["629"]["play"];//

    for (int i = 630; i<= 633; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataPlayBeen296["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 630) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 631) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 632) {
        topThreeMapBeen6.groupSelectionNum = 0;
        topThreeMapBeen6.playModeSingleOrDouble = 1;
      }
      if (i == 633) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataLaterFourPlayList.add(topThreeMapBeen6);
    }

    choiceModeMap[laterFourBeen] = dataLaterFourPlayList;


    /// 前三
    Map<String, dynamic> topThree = data["634"];//前三
    var topThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(topThree);
    Map<String, dynamic> dataTopThreePlay = topThree["play"];//前三

    List<Play11Choice5DataPlayBeen> topThreeList = new List();

    Map<String, dynamic> topThree305 = dataTopThreePlay["635"]["play"];

    for (int mi = 636; mi <= 639; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree305["$mi"];//前三
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 3;
      if (mi == 636) {
        topThreePlayBeen.name = "直选复式";
        topThreePlayBeen.groupSelectionNum = 3;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 637) {
        topThreePlayBeen.name = "直选单式";
        topThreePlayBeen.groupSelectionNum = 0;
        topThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 638) {
        topThreePlayBeen.groupSelectionNum = 1;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 639) {
        topThreePlayBeen.groupSelectionNum = 1;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }
      topThreeList.add(topThreePlayBeen);
    }

    var topThree306 = dataTopThreePlay["640"]["play"];//组选

    for (int mi = 641; mi <= 643; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree306["$mi"];//组选
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 3;
      topThreePlayBeen.groupSelectionNum = 1;
      topThreePlayBeen.playModeSingleOrDouble = 2;

      topThreeList.add(topThreePlayBeen);
    }

    var middleThree22 = dataTopThreePlay["644"]["play"];//其他

    Map<String, dynamic> middleThreeDataMap = middleThree22["645"];//尾选和值
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 3;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    topThreeList.add(middleThreePlayBeen);

    choiceModeMap[topThreeBeen] = topThreeList;

    /// 中三
    Map<String, dynamic> middleThree = data["646"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["647"]["play"];

    for (int mi = 648; mi <= 651; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 4;
      if (mi == 648) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 649) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 650) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 651) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree318 = dataMiddleThreePlay["652"]["play"];//组选

    for (int mi = 653; mi <= 654; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree318["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 4;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree319 = dataMiddleThreePlay["655"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap326 = middleThree319["656"];// 和值尾数
    var middleThreePlayBeenSum = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap326);
    middleThreePlayBeenSum.playMode = 4;
    middleThreePlayBeenSum.groupSelectionNum = 1;
    middleThreePlayBeenSum.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeenSum);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["657"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["658"]["play"];//后三 直选

    for (int lTi = 659; lTi <= 662; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 5;

      if (lTi == 659) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 660) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 661) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 662) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["663"]["play"];//后三 组选

    for (int lTi = 664; lTi <= 666; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 5;
      if (lTi == 664) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 665) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 666) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["667"]["play"];//后三 和值尾数

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["668"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 5;
    dataLaterThreePlayList.add(dataLaterThreePlayBeen);

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 前二
    Map<String, dynamic> dataTopTwo = data["669"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["670"]["play"];//
    /// 前二 直选
    for(int two = 671; two <= 674; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 6;

      if (two == 671) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 672) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 673) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 674) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["675"]["play"];//
    /// 前二 组选
    for(int two = 676; two <= 679; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 6;
      if (two == 676) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 677) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 678) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 679) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["680"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["681"]["play"];//
    /// 后二 直选
    for(int two = 682; two <= 685; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 7;

      if (two == 682) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 683) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 684) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 685) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["686"]["play"];//
    /// 后二 组选
    for(int two = 687; two <= 690; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 7;

      if (two == 687) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 688) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }
      if (two == 689) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      if (two == 690) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["691"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["692"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["693"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 8;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["694"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["695"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 696; two <= 697; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 696) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 697) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["698"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 699; two <= 700; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 699) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 700) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["701"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 702; two <= 703; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 702) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 703) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["704"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 705; two <= 706; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 705) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 706) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["707"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 708; two <= 709; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 708) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 709) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["710"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["711"]["play"];//任二

    for (int op = 712; op <= 714; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 10;
      if (op == 712) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 713) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 714) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["715"]["play"];//任二

    for (int op = 716; op <= 719; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 10;
      if (op == 716) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 717) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 718) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 719) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    if (dataOptionalPlay["381"] != null) {
      /// 任四
      Map<String, dynamic> dataOptional381 = dataOptionalPlay["381"]["play"];//任二

      for (int op = 389; op <= 390; op ++) {
        Map<String, dynamic> dataOptionalPlayOP = dataOptional381["$op"];
        var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
        dataOptionalBeen.playMode = 10;
        if (op == 389) {
          dataOptionalBeen.name = "任四复式";
          dataOptionalBeen.groupSelectionNum = 5;
          dataOptionalBeen.playModeSingleOrDouble = 2;
        }

        if (op == 390) {
          dataOptionalBeen.name = "任四单式";
          dataOptionalBeen.groupSelectionNum = 0;
          dataOptionalBeen.playModeSingleOrDouble = 1;
        }

        dataOptionalBeenPlayList.add(dataOptionalBeen);
      }
    }

    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["720"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["721"]["play"];//

    for (int op = 722; op <= 725; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 11;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 龙虎
    Map<String, dynamic> dataDragonTiger = data["726"];//
    if (dataDragonTiger != null) {
      var dataDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataDragonTiger);
      List<Play11Choice5DataPlayBeen> dataDragonTigerBeenPlayList = new List();

      Map<String, dynamic> dataDragonTigerPlay = dataDragonTiger["play"];//

      Map<String, dynamic> dataInterest398 = dataDragonTigerPlay["727"]["play"];//

      for (int op = 728; op <= 764; op ++) {
        if(op == 728 || op == 732 || op == 736 || op == 740 || op == 744 || op == 748 || op == 752
            || op == 756 || op == 760 || op == 764) {

          Map<String, dynamic> dataOptionalPlayOP = dataInterest398["$op"];
          var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
          dataInterestBeen.groupSelectionNum = 1;
          dataInterestBeen.playModeSingleOrDouble = 2;
          dataInterestBeen.playMode = 12;

          if (op == 728) {
            Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["729"];
            var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
            dataInterestBeen.remark = dataInterestBeen105.remark;
          }

          if (op == 732) {
            Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["733"];
            var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
            dataInterestBeen.remark = dataInterestBeen108.remark;
          }

          if (op == 736) {
            Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["737"];
            var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
            dataInterestBeen.remark = dataInterestBeen111.remark;
          }

          if (op == 740) {
            Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["741"];
            var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
            dataInterestBeen.remark = dataInterestBeen114.remark;
          }

          if (op == 744) {
            Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["745"];
            var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
            dataInterestBeen.remark = dataInterestBeen117.remark;
          }

          if (op == 748) {
            Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["749"];
            var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
            dataInterestBeen.remark = dataInterestBeen120.remark;
          }

          if (op == 752) {
            Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["753"];
            var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
            dataInterestBeen.remark = dataInterestBeen123.remark;
          }

          if (op == 756) {
            Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["757"];
            var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
            dataInterestBeen.remark = dataInterestBeen126.remark;
          }

          if (op == 760) {
            Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["761"];
            var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
            dataInterestBeen.remark = dataInterestBeen129.remark;
          }

          if (op == 764) {
            Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["765"];
            var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
            dataInterestBeen.remark = dataInterestBeen129.remark;
          }


          dataDragonTigerBeenPlayList.add(dataInterestBeen);

        }
      }

      choiceModeMap[dataDragonTigerBeen] = dataDragonTigerBeenPlayList;
    }

  }

  /// 腾讯10分彩
  _tencent10Lottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["768"];//五星
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];

    List<Play11Choice5DataPlayBeen> dataFiveStarsPlayList = new List(); // 五星 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["769"]["play"];///五星

    /// 五星 直选  282 284
    Map<String, dynamic> dataFiveStarsPlayMapZ = dataTopThreePlayBeen["770"];//五星 复式
    var dataFiveStarsMapBeenZ = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapZ);
    dataFiveStarsMapBeenZ.playMode = 1;
    dataFiveStarsMapBeenZ.name = "直选复式";
    dataFiveStarsMapBeenZ.groupSelectionNum = 3;
    dataFiveStarsMapBeenZ.playModeSingleOrDouble = 2;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenZ);


    Map<String, dynamic> dataFiveStarsPlayMapD = dataTopThreePlayBeen["771"];//五星 单式
    var dataFiveStarsMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapD);
    dataFiveStarsMapBeenD.playMode = 1;
    dataFiveStarsMapBeenD.name = "直选单式";
    dataFiveStarsMapBeenD.groupSelectionNum = 0;
    dataFiveStarsMapBeenD.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenD);

    /// 五星 组选
    var dataTopThreePlayBeen285 = dataThreeYardsPlay["772"]["play"];//

    for (int i = 773; i<= 777; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen285["$i"];//五星 组选
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 773) {
        topThreeMapBeen.groupSelectionNum = 3;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 774) {
        topThreeMapBeen.groupSelectionNum = 0;
        topThreeMapBeen.playModeSingleOrDouble = 1;
      }
      if (i == 775) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 776) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 777) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataFiveStarsPlayList.add(topThreeMapBeen);
    }

    var dataTopThreePlayBeen292 = dataThreeYardsPlay["778"]["play"];//
    //总和大小单双
    Map<String, dynamic> dataFiveStarsPlayMapDXDS = dataTopThreePlayBeen292["779"];//五星 复式
    var dataFiveStarsMapBeenDXDS = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapDXDS);
    dataFiveStarsMapBeenDXDS.playMode = 1;
    dataFiveStarsMapBeenDXDS.groupSelectionNum = 0;
    dataFiveStarsMapBeenDXDS.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenDXDS);

    choiceModeMap[threeYardsBeen] = dataFiveStarsPlayList;

    /// 后四
    Map<String, dynamic> dataLaterFour = data["780"];//
    var laterFourBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterFour);
    var dataLaterFourBeen294 = dataLaterFour["play"];//
    List<Play11Choice5DataPlayBeen> dataLaterFourPlayList = new List(); // 后四 列表

    var dataTopThreePlayBeen295 = dataLaterFourBeen294["781"]["play"];//
    Map<String, dynamic> dataLaterFourPlayMapF = dataTopThreePlayBeen295["782"];//五星 复式
    var dataLaterFourMapBeenF = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapF);
    dataLaterFourMapBeenF.playMode = 2;
    dataLaterFourMapBeenF.groupSelectionNum = 0;
    dataLaterFourMapBeenF.name = "直选复式";
    dataLaterFourMapBeenF.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenF);

    Map<String, dynamic> dataLaterFourPlayMapD = dataTopThreePlayBeen295["783"];//五星 复式
    var dataLaterFourMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapD);
    dataLaterFourMapBeenD.playMode = 2;
    dataLaterFourMapBeenD.name = "直选单式";
    dataLaterFourMapBeenD.groupSelectionNum = 0;
    dataLaterFourMapBeenD.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenD);

    /// 后四组选
    var dataPlayBeen296 = dataLaterFourBeen294["784"]["play"];//

    for (int i = 785; i<= 788; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataPlayBeen296["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 785) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 786) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 787) {
        topThreeMapBeen6.groupSelectionNum = 0;
        topThreeMapBeen6.playModeSingleOrDouble = 1;
      }
      if (i == 788) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataLaterFourPlayList.add(topThreeMapBeen6);
    }

    choiceModeMap[laterFourBeen] = dataLaterFourPlayList;


    /// 前三
    Map<String, dynamic> topThree = data["789"];//前三
    var topThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(topThree);
    Map<String, dynamic> dataTopThreePlay = topThree["play"];//前三

    List<Play11Choice5DataPlayBeen> topThreeList = new List();

    Map<String, dynamic> topThree305 = dataTopThreePlay["790"]["play"];

    for (int mi = 791; mi <= 794; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree305["$mi"];//前三
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 3;
      if (mi == 791) {
        topThreePlayBeen.name = "直选复式";
        topThreePlayBeen.groupSelectionNum = 3;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 792) {
        topThreePlayBeen.name = "直选单式";
        topThreePlayBeen.groupSelectionNum = 0;
        topThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 793) {
        topThreePlayBeen.groupSelectionNum = 1;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 794) {
        topThreePlayBeen.groupSelectionNum = 1;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }
      topThreeList.add(topThreePlayBeen);
    }

    var topThree306 = dataTopThreePlay["795"]["play"];//组选

    for (int mi = 796; mi <= 798; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree306["$mi"];//组选
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 3;
      topThreePlayBeen.groupSelectionNum = 1;
      topThreePlayBeen.playModeSingleOrDouble = 2;

      topThreeList.add(topThreePlayBeen);
    }

    var middleThree22 = dataTopThreePlay["799"]["play"];//其他

    Map<String, dynamic> middleThreeDataMap = middleThree22["800"];//尾选和值
    var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
    middleThreePlayBeen.playMode = 3;
    middleThreePlayBeen.groupSelectionNum = 1;
    middleThreePlayBeen.playModeSingleOrDouble = 2;

    topThreeList.add(middleThreePlayBeen);

    choiceModeMap[topThreeBeen] = topThreeList;

    /// 中三
    Map<String, dynamic> middleThree = data["801"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree14 = dataMiddleThreePlay["802"]["play"];

    for (int mi = 803; mi <= 806; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree14["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 4;
      if (mi == 803) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 804) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }

      if (mi == 805) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 806) {
        middleThreePlayBeen.groupSelectionNum = 1;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree318 = dataMiddleThreePlay["807"]["play"];//组选

    for (int mi = 808; mi <= 809; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree318["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 4;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree319 = dataMiddleThreePlay["810"]["play"];//组选

    Map<String, dynamic> middleThreeDataMap326 = middleThree319["811"];// 和值尾数
    var middleThreePlayBeenSum = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap326);
    middleThreePlayBeenSum.playMode = 4;
    middleThreePlayBeenSum.groupSelectionNum = 1;
    middleThreePlayBeenSum.playModeSingleOrDouble = 2;

    middleThreeList.add(middleThreePlayBeenSum);

    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["812"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen25Play = dataLaterThreePlay["813"]["play"];//后三 直选

    for (int lTi = 814; lTi <= 817; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen25Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 5;

      if (lTi == 814) {
        dataLaterThreePlayBeen.name = "直选复式";
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 815) {
        dataLaterThreePlayBeen.name = "直选单式";
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 816) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if(lTi == 817) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen26Play = dataLaterThreePlay["818"]["play"];//后三 组选

    for (int lTi = 819; lTi <= 821; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen26Play["$lTi"];
      var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
      dataLaterThreePlayBeen.playMode = 5;
      if (lTi == 819) {
        dataLaterThreePlayBeen.groupSelectionNum = 3;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      if (lTi == 820) {
        dataLaterThreePlayBeen.groupSelectionNum = 0;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 1;
      }
      if(lTi == 821) {
        dataLaterThreePlayBeen.groupSelectionNum = 1;
        dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
      }
      dataLaterThreePlayList.add(dataLaterThreePlayBeen);
    }

    Map<String, dynamic> dataLaterThreePlayBeen27Play = dataLaterThreePlay["822"]["play"];//后三 和值尾数

    Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen27Play["823"];
    var dataLaterThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(dataLaterThreePlayBeenLTi);
    dataLaterThreePlayBeen.groupSelectionNum = 1;
    dataLaterThreePlayBeen.playModeSingleOrDouble = 2;
    dataLaterThreePlayBeen.playMode = 5;
    dataLaterThreePlayList.add(dataLaterThreePlayBeen);

    choiceModeMap[dataLaterThreeBeen] = dataLaterThreePlayList;

    /// 前二
    Map<String, dynamic> dataTopTwo = data["824"];//前二
    var dataTopTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataTopTwo);
    List<Play11Choice5DataPlayBeen> dataTopTwoPlayList = new List();

    Map<String, dynamic> dataTopTwoPlay = dataTopTwo["play"];//
    Map<String, dynamic> dataTopTwoPlay44 = dataTopTwoPlay["825"]["play"];//
    /// 前二 直选
    for(int two = 826; two <= 829; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataTopTwoPlay44["$two"];
      var dataTopTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);

      dataTopTwoBeenDirectly.playMode = 6;

      if (two == 826) {
        dataTopTwoBeenDirectly.name = "直选复式";
        dataTopTwoBeenDirectly.groupSelectionNum = 3;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 827) {
        dataTopTwoBeenDirectly.name = "直选单式";
        dataTopTwoBeenDirectly.groupSelectionNum = 0;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 828) {
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 829) {
        dataTopTwoBeenDirectly.name = "直选跨度";
        dataTopTwoBeenDirectly.groupSelectionNum = 1;
        dataTopTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay49 = dataTopTwoPlay["830"]["play"];//
    /// 前二 组选
    for(int two = 831; two <= 834; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataLaterTwoPlay49["$two"];
      var dataTopTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataTopTwoBeenGroup.playMode = 6;
      if (two == 831) {
        dataTopTwoBeenGroup.name = "组选复式";
        dataTopTwoBeenGroup.groupSelectionNum = 3;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 832) {
        dataTopTwoBeenGroup.name = "组选单式";
        dataTopTwoBeenGroup.groupSelectionNum = 0;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 1;
      }

      if (two == 833) {
        dataTopTwoBeenGroup.name = "组选和值";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 834) {
        dataTopTwoBeenGroup.name = "组选包胆";
        dataTopTwoBeenGroup.groupSelectionNum = 1;
        dataTopTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataTopTwoPlayList.add(dataTopTwoBeenGroup);
    }

    choiceModeMap[dataTopTwoBeen] = dataTopTwoPlayList;

    /// 后二
    Map<String, dynamic> dataLaterTwo = data["835"];//后二
    var dataLaterTwoBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterTwo);
    List<Play11Choice5DataPlayBeen> dataLaterTwoPlayList = new List();

    Map<String, dynamic> dataLaterTwoPlay = dataLaterTwo["play"];//
    Map<String, dynamic> dataLaterTwoPlay38 = dataLaterTwoPlay["836"]["play"];//
    /// 后二 直选
    for(int two = 837; two <= 840; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay38["$two"];
      var dataLaterTwoBeenDirectly  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenDirectly.playMode = 7;

      if (two == 837) {
        dataLaterTwoBeenDirectly.name = "直选复式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 3;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 838) {
        dataLaterTwoBeenDirectly.name = "直选单式";
        dataLaterTwoBeenDirectly.groupSelectionNum = 0;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 1;
      }

      if (two == 839) {
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }

      if (two == 840) {
        dataLaterTwoBeenDirectly.name = "直选跨度";
        dataLaterTwoBeenDirectly.groupSelectionNum = 1;
        dataLaterTwoBeenDirectly.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenDirectly);
    }

    Map<String, dynamic> dataLaterTwoPlay54 = dataLaterTwoPlay["841"]["play"];//
    /// 后二 组选
    for(int two = 842; two <= 845; two++) {
      Map<String, dynamic> dataLaterTwoPlayTwoI = dataLaterTwoPlay54["$two"];
      var dataLaterTwoBeenGroup  = Play11Choice5DataPlayBeen.fromJson(dataLaterTwoPlayTwoI);
      dataLaterTwoBeenGroup.playMode = 7;

      if (two == 842) {
        dataLaterTwoBeenGroup.name = "组选复式";
        dataLaterTwoBeenGroup.groupSelectionNum = 3;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }

      if (two == 843) {
        dataLaterTwoBeenGroup.name = "组选单式";
        dataLaterTwoBeenGroup.groupSelectionNum = 0;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 1;
      }
      if (two == 844) {
        dataLaterTwoBeenGroup.name = "组选和值";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      if (two == 845) {
        dataLaterTwoBeenGroup.name = "组选包胆";
        dataLaterTwoBeenGroup.groupSelectionNum = 1;
        dataLaterTwoBeenGroup.playModeSingleOrDouble = 2;
      }
      dataLaterTwoPlayList.add(dataLaterTwoBeenGroup);
    }

    choiceModeMap[dataLaterTwoBeen] = dataLaterTwoPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["846"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["847"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["848"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 8;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 不定胆
    Map<String, dynamic> dataUncertainGallbladder = data["849"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["850"]["play"];//五星不定胆
    /// 不定胆 五星
    for(int two = 851; two <= 852; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 851) {
        dataUncertainGallbladderBeenUnGa.name = "五星二码不定位";

      }

      if (two == 852) {
        dataUncertainGallbladderBeenUnGa.name = "五星三码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder66 = dataUncertainGallbladderPlay["853"]["play"];//五星不定胆
    /// 不定胆 前四
    for(int two = 854; two <= 855; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder66["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 854) {
        dataUncertainGallbladderBeenUnGa.name = "前四一码不定位";

      }

      if (two == 855) {
        dataUncertainGallbladderBeenUnGa.name = "前四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder69 = dataUncertainGallbladderPlay["856"]["play"];//五星不定胆
    /// 不定胆 后四
    for(int two = 857; two <= 858; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder69["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 857) {
        dataUncertainGallbladderBeenUnGa.name = "后四一码不定位";

      }

      if (two == 858) {
        dataUncertainGallbladderBeenUnGa.name = "后四二码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder72 = dataUncertainGallbladderPlay["859"]["play"];//五星不定胆
    /// 不定胆 一码不定位
    for(int two = 860; two <= 861; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder72["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 860) {
        dataUncertainGallbladderBeenUnGa.name = "后三一码不定位";

      }

      if (two == 861) {
        dataUncertainGallbladderBeenUnGa.name = "前三一码不定位";

      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    Map<String, dynamic> dataUncertainGallbladder73 = dataUncertainGallbladderPlay["862"]["play"];//五星不定胆
    /// 不定胆 二码不定位
    for(int two = 863; two <= 864; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder73["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 9;
      if (two == 863) {
        dataUncertainGallbladderBeenUnGa.name = "后三二码不定位";
      }

      if (two == 864) {
        dataUncertainGallbladderBeenUnGa.name = "前三二码不定位";
      }
      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }

    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;


    /// 任选
    Map<String, dynamic> dataOptional = data["865"];//任选
    var dataOptionalBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataOptional);
    List<Play11Choice5DataPlayBeen> dataOptionalBeenPlayList = new List();

    Map<String, dynamic> dataOptionalPlay = dataOptional["play"];//

    Map<String, dynamic> dataOptional79 = dataOptionalPlay["866"]["play"];//任二

    for (int op = 867; op <= 869; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional79["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 10;
      if (op == 867) {
        dataOptionalBeen.name = "任二复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 868) {
        dataOptionalBeen.name = "任二单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 869) {
        dataOptionalBeen.name = "任二组选";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }

    /// 任三
    Map<String, dynamic> dataOptional80 = dataOptionalPlay["870"]["play"];//任二

    for (int op = 871; op <= 874; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataOptional80["$op"];
      var dataOptionalBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataOptionalBeen.playMode = 10;
      if (op == 871) {
        dataOptionalBeen.name = "任三复式";
        dataOptionalBeen.groupSelectionNum = 5;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }

      if (op == 872) {
        dataOptionalBeen.name = "任三单式";
        dataOptionalBeen.groupSelectionNum = 0;
        dataOptionalBeen.playModeSingleOrDouble = 1;
      }

      if (op == 873) {
        dataOptionalBeen.name = "任三组三";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      if (op == 874) {
        dataOptionalBeen.name = "任三组六";
        dataOptionalBeen.groupSelectionNum = 1;
        dataOptionalBeen.playModeSingleOrDouble = 2;
      }
      dataOptionalBeenPlayList.add(dataOptionalBeen);
    }


    choiceModeMap[dataOptionalBeen] = dataOptionalBeenPlayList;


    /// 趣味
    Map<String, dynamic> dataInterest = data["875"];//趣味
    var dataInterestBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataInterest);
    List<Play11Choice5DataPlayBeen> dataInterestBeenPlayList = new List();

    Map<String, dynamic> dataInterestPlay = dataInterest["play"];//

    Map<String, dynamic> dataInterest89 = dataInterestPlay["876"]["play"];//

    for (int op = 877; op <= 880; op ++) {
      Map<String, dynamic> dataOptionalPlayOP = dataInterest89["$op"];
      var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
      dataInterestBeen.groupSelectionNum = 1;
      dataInterestBeen.playModeSingleOrDouble = 2;
      dataInterestBeen.playMode = 11;

      dataInterestBeenPlayList.add(dataInterestBeen);
    }

    choiceModeMap[dataInterestBeen] = dataInterestBeenPlayList;

    /// 龙虎
    Map<String, dynamic> dataDragonTiger = data["881"];//
    if (dataDragonTiger != null) {
      var dataDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataDragonTiger);
      List<Play11Choice5DataPlayBeen> dataDragonTigerBeenPlayList = new List();

      Map<String, dynamic> dataDragonTigerPlay = dataDragonTiger["play"];//

      Map<String, dynamic> dataInterest398 = dataDragonTigerPlay["882"]["play"];//

      for (int op = 883; op <= 919; op ++) {
        if(op == 883 || op == 887 || op == 891 || op == 895 || op == 899 || op == 903 || op == 907
            || op == 911 || op == 915 || op == 919) {

          Map<String, dynamic> dataOptionalPlayOP = dataInterest398["$op"];
          var dataInterestBeen  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOP);
          dataInterestBeen.groupSelectionNum = 1;
          dataInterestBeen.playModeSingleOrDouble = 2;
          dataInterestBeen.playMode = 12;

          if (op == 883) {
            Map<String, dynamic> dataOptionalPlayOPPlay105 = dataOptionalPlayOP["play"]["884"];
            var dataInterestBeen105  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay105);
            dataInterestBeen.remark = dataInterestBeen105.remark;
          }

          if (op == 887) {
            Map<String, dynamic> dataOptionalPlayOPPlay108 = dataOptionalPlayOP["play"]["888"];
            var dataInterestBeen108  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay108);
            dataInterestBeen.remark = dataInterestBeen108.remark;
          }

          if (op == 891) {
            Map<String, dynamic> dataOptionalPlayOPPlay111 = dataOptionalPlayOP["play"]["892"];
            var dataInterestBeen111  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay111);
            dataInterestBeen.remark = dataInterestBeen111.remark;
          }

          if (op == 895) {
            Map<String, dynamic> dataOptionalPlayOPPlay114 = dataOptionalPlayOP["play"]["896"];
            var dataInterestBeen114  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay114);
            dataInterestBeen.remark = dataInterestBeen114.remark;
          }

          if (op == 899) {
            Map<String, dynamic> dataOptionalPlayOPPlay117 = dataOptionalPlayOP["play"]["900"];
            var dataInterestBeen117  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay117);
            dataInterestBeen.remark = dataInterestBeen117.remark;
          }

          if (op == 903) {
            Map<String, dynamic> dataOptionalPlayOPPlay120 = dataOptionalPlayOP["play"]["904"];
            var dataInterestBeen120  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay120);
            dataInterestBeen.remark = dataInterestBeen120.remark;
          }

          if (op == 907) {
            Map<String, dynamic> dataOptionalPlayOPPlay123 = dataOptionalPlayOP["play"]["908"];
            var dataInterestBeen123  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay123);
            dataInterestBeen.remark = dataInterestBeen123.remark;
          }

          if (op == 911) {
            Map<String, dynamic> dataOptionalPlayOPPlay126 = dataOptionalPlayOP["play"]["912"];
            var dataInterestBeen126  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay126);
            dataInterestBeen.remark = dataInterestBeen126.remark;
          }

          if (op == 915) {
            Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["916"];
            var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
            dataInterestBeen.remark = dataInterestBeen129.remark;
          }

          if (op == 919) {
            Map<String, dynamic> dataOptionalPlayOPPlay129 = dataOptionalPlayOP["play"]["920"];
            var dataInterestBeen129  = Play11Choice5DataPlayBeen.fromJson(dataOptionalPlayOPPlay129);
            dataInterestBeen.remark = dataInterestBeen129.remark;
          }


          dataDragonTigerBeenPlayList.add(dataInterestBeen);

        }
      }

      choiceModeMap[dataDragonTigerBeen] = dataDragonTigerBeenPlayList;
    }

  }

}