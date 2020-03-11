

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

      GameService.instance.chongqingTimePlay(this, _colorVarietyID);
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

    if(_colorVarietyID == "${Constant.GAME_NUM_CHONGQING_1}") {
      _chongqingTimeLottery(data);
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

  /// 重庆时时彩
  _chongqingTimeLottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["1370"];//五星
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];

    List<Play11Choice5DataPlayBeen> dataFiveStarsPlayList = new List(); // 五星 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["1371"]["play"];///五星

    /// 五星 直选  282 284
    Map<String, dynamic> dataFiveStarsPlayMapZ = dataTopThreePlayBeen["1373"];//五星 复式
    var dataFiveStarsMapBeenZ = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapZ);
    dataFiveStarsMapBeenZ.playMode = 1;
    dataFiveStarsMapBeenZ.name = "直选复式";
    dataFiveStarsMapBeenZ.groupSelectionNum = 3;
    dataFiveStarsMapBeenZ.playModeSingleOrDouble = 2;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenZ);


    Map<String, dynamic> dataFiveStarsPlayMapD = dataTopThreePlayBeen["1374"];//五星 单式
    var dataFiveStarsMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapD);
    dataFiveStarsMapBeenD.playMode = 1;
    dataFiveStarsMapBeenD.name = "直选单式";
    dataFiveStarsMapBeenD.groupSelectionNum = 0;
    dataFiveStarsMapBeenD.playModeSingleOrDouble = 1;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenD);

    /// 五星 组选
    var dataTopThreePlayBeen285 = dataThreeYardsPlay["1372"]["play"];//

    for (int i = 1375; i<= 1380; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataTopThreePlayBeen285["$i"];//五星 组选
      var topThreeMapBeen = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen.playMode = 1;
      if (i == 1375) {
        topThreeMapBeen.groupSelectionNum = 1;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1376) {
        topThreeMapBeen.groupSelectionNum = 2;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1377) {
        topThreeMapBeen.groupSelectionNum = 2;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1378) {
        topThreeMapBeen.groupSelectionNum = 2;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1379) {
        topThreeMapBeen.groupSelectionNum = 2;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      if (i == 1380) {
        topThreeMapBeen.groupSelectionNum = 2;
        topThreeMapBeen.playModeSingleOrDouble = 2;
      }
      dataFiveStarsPlayList.add(topThreeMapBeen);
    }

    choiceModeMap[threeYardsBeen] = dataFiveStarsPlayList;

    /// 前四
    Map<String, dynamic> dataBeforeFour = data["1381"];//前四
    var dataBeforeFourBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataBeforeFour);
    var dataBeforeFourBeen1381 = dataBeforeFour["play"];//
    List<Play11Choice5DataPlayBeen> dataBeforeFourPlayList = new List(); // 前四 列表

    var dataTopThreePlayBeen1382 = dataBeforeFourBeen1381["1382"]["play"];//
    Map<String, dynamic> dataBeforeFourPlayMapF1384 = dataTopThreePlayBeen1382["1384"];//五星 复式
    var dataBeforeFourMapBeenF = Play11Choice5DataPlayBeen.fromJson(dataBeforeFourPlayMapF1384);
    dataBeforeFourMapBeenF.playMode = 2;
    dataBeforeFourMapBeenF.groupSelectionNum = 0;
    dataBeforeFourMapBeenF.name = "直选复式";
    dataBeforeFourMapBeenF.playModeSingleOrDouble = 1;
    dataBeforeFourPlayList.add(dataBeforeFourMapBeenF);

    Map<String, dynamic> dataBeforeFourPlayMapD1385 = dataTopThreePlayBeen1382["1385"];//五星 复式
    var dataBeforeFourMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataBeforeFourPlayMapD1385);
    dataBeforeFourMapBeenD.playMode = 2;
    dataBeforeFourMapBeenD.name = "直选单式";
    dataBeforeFourMapBeenD.groupSelectionNum = 0;
    dataBeforeFourMapBeenD.playModeSingleOrDouble = 1;
    dataBeforeFourPlayList.add(dataBeforeFourMapBeenD);

    /// 后四组选
    var dataPlayBeen1383 = dataBeforeFourBeen1381["1383"]["play"];//

    for (int i = 1386; i<= 1388; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataPlayBeen1383["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 2;
      if (i == 1386) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1387) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1388) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataBeforeFourPlayList.add(topThreeMapBeen6);
    }

    choiceModeMap[dataBeforeFourBeen] = dataBeforeFourPlayList;

    /// 后四
    Map<String, dynamic> dataLaterFour = data["1389"];//
    var laterFourBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterFour);
    var dataLaterFourBeen1389 = dataLaterFour["play"];//
    List<Play11Choice5DataPlayBeen> dataLaterFourPlayList = new List(); // 后四 列表

    var dataTopThreePlayBeen1390 = dataLaterFourBeen1389["1390"]["play"];//
    Map<String, dynamic> dataLaterFourPlayMapF = dataTopThreePlayBeen1390["1392"];//五星 复式
    var dataLaterFourMapBeenF = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapF);
    dataLaterFourMapBeenF.playMode = 3;
    dataLaterFourMapBeenF.groupSelectionNum = 0;
    dataLaterFourMapBeenF.name = "直选复式";
    dataLaterFourMapBeenF.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenF);

    Map<String, dynamic> dataLaterFourPlayMapD = dataTopThreePlayBeen1390["1393"];//五星 复式
    var dataLaterFourMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapD);
    dataLaterFourMapBeenD.playMode = 3;
    dataLaterFourMapBeenD.name = "直选单式";
    dataLaterFourMapBeenD.groupSelectionNum = 0;
    dataLaterFourMapBeenD.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenD);

    /// 后四组选
    var dataPlayBeen1391 = dataLaterFourBeen1389["1391"]["play"];//

    for (int i = 1394; i<= 1396; i++) {
      Map<String, dynamic> dataTopThreePlayMap = dataPlayBeen1391["$i"];//三码
      if (dataTopThreePlayMap == null || dataTopThreePlayMap.length <= 0) {
        continue;
      }
      var topThreeMapBeen6 = Play11Choice5DataPlayBeen.fromJson(dataTopThreePlayMap);
      topThreeMapBeen6.playMode = 3;
      if (i == 1394) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1395) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      if (i == 1396) {
        topThreeMapBeen6.groupSelectionNum = 1;
        topThreeMapBeen6.playModeSingleOrDouble = 2;
      }
      dataLaterFourPlayList.add(topThreeMapBeen6);
    }

    choiceModeMap[laterFourBeen] = dataLaterFourPlayList;


    /// 前三
    Map<String, dynamic> topThree = data["1397"];//前三
    var topThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(topThree);
    Map<String, dynamic> dataTopThreePlay = topThree["play"];//前三

    List<Play11Choice5DataPlayBeen> topThreeList = new List();

    Map<String, dynamic> topThree1398 = dataTopThreePlay["1398"]["play"];

    for (int mi = 1400; mi <= 1401; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree1398["$mi"];//前三
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 4;
      if (mi == 1400) {
        topThreePlayBeen.name = "直选复式";
        topThreePlayBeen.groupSelectionNum = 3;
        topThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 1401) {
        topThreePlayBeen.name = "直选单式";
        topThreePlayBeen.groupSelectionNum = 0;
        topThreePlayBeen.playModeSingleOrDouble = 1;
      }
      topThreeList.add(topThreePlayBeen);
    }

    var topThree1399 = dataTopThreePlay["1399"]["play"];//组选

    for (int mi = 1402; mi <= 1404; mi++) {
      Map<String, dynamic> middleThreeDataMap = topThree1399["$mi"];//组选
      var topThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      topThreePlayBeen.playMode = 4;
      topThreePlayBeen.groupSelectionNum = 1;
      topThreePlayBeen.playModeSingleOrDouble = 2;

      topThreeList.add(topThreePlayBeen);
    }


    choiceModeMap[topThreeBeen] = topThreeList;

    /// 中三
    Map<String, dynamic> middleThree = data["1405"];//中三
    var twoYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(middleThree);
    Map<String, dynamic> dataMiddleThreePlay = middleThree["play"];//中三

    List<Play11Choice5DataPlayBeen> middleThreeList = new List();

    Map<String, dynamic> middleThree1406 = dataMiddleThreePlay["1406"]["play"];

    for (int mi = 1408; mi <= 1409; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree1406["$mi"];//中三
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 5;
      if (mi == 1408) {
        middleThreePlayBeen.name = "直选复式";
        middleThreePlayBeen.groupSelectionNum = 3;
        middleThreePlayBeen.playModeSingleOrDouble = 2;
      }

      if (mi == 1409) {
        middleThreePlayBeen.name = "直选单式";
        middleThreePlayBeen.groupSelectionNum = 0;
        middleThreePlayBeen.playModeSingleOrDouble = 1;
      }
      middleThreeList.add(middleThreePlayBeen);
    }

    var middleThree318 = dataMiddleThreePlay["1407"]["play"];//组选

    for (int mi = 1410; mi <= 1412; mi++) {
      Map<String, dynamic> middleThreeDataMap = middleThree318["$mi"];//组选
      var middleThreePlayBeen = Play11Choice5DataPlayBeen.fromJson(middleThreeDataMap);
      middleThreePlayBeen.playMode = 5;
      middleThreePlayBeen.groupSelectionNum = 1;
      middleThreePlayBeen.playModeSingleOrDouble = 2;

      middleThreeList.add(middleThreePlayBeen);
    }


    choiceModeMap[twoYardsBeen] = middleThreeList;

    /// 后三
    Map<String, dynamic> dataLaterThree = data["1413"];//后三
    List<Play11Choice5DataPlayBeen> dataLaterThreePlayList = new List();

    var dataLaterThreeBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterThree);
    Map<String, dynamic> dataLaterThreePlay = dataLaterThree["play"];//

    Map<String, dynamic> dataLaterThreePlayBeen1414Play = dataLaterThreePlay["1414"]["play"];//后三 直选

    for (int lTi = 331; lTi <= 334; lTi++) {
      Map<String, dynamic> dataLaterThreePlayBeenLTi = dataLaterThreePlayBeen1414Play["$lTi"];
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


}