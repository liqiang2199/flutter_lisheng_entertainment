

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
 * 幸运飞艇 玩法选择
 */
///
class PlayModeLuckyAirshipLotteryController extends StatefulWidget{

  final List<Play11Choice5DataPlayBeen> playModeBeenList;
  final String colorVarietyID;

  const PlayModeLuckyAirshipLotteryController({
    Key key,
    this.playModeBeenList,
    this.colorVarietyID
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayModeLuckyAirshipLotteryController(this.playModeBeenList, this.colorVarietyID);
  }

}

class _PlayModeLuckyAirshipLotteryController extends BaseController<PlayModeLuckyAirshipLotteryController> implements PlayMode11Choice5Handler {

  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  bool isChoiceType = false;//是否是有选择

  String _colorVarietyID;


  _PlayModeLuckyAirshipLotteryController(
      this.playModeBeenList,
      this._colorVarietyID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((e) {

      GameService.instance.luckyAirshipPlay(this, _colorVarietyID);
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
                case "前一":
                case "前二":
                case "大小":
                case "单双":
                case "龙虎":
                  playTypeName = "$typeNam${play11choice5dataPlayBeen.name}";
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
      _luckyAirshipLottery(data);
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

  /// 幸运飞艇
  _luckyAirshipLottery(Map<String, dynamic> data) {
    Map<String, dynamic> dataThreeYards = data["122"];//前一
    var threeYardsBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataThreeYards);
    Map<String, dynamic> dataThreeYardsPlay = dataThreeYards["play"];

    List<Play11Choice5DataPlayBeen> dataFiveStarsPlayList = new List(); // 前一 列表

    var dataTopThreePlayBeen = dataThreeYardsPlay["123"]["play"];///五星

    /// 前一 复式
    Map<String, dynamic> dataFiveStarsPlayMapZ = dataTopThreePlayBeen["124"];//前一 复式
    var dataFiveStarsMapBeenZ = Play11Choice5DataPlayBeen.fromJson(dataFiveStarsPlayMapZ);
    dataFiveStarsMapBeenZ.playMode = 1;
    dataFiveStarsMapBeenZ.name = "复式";
    dataFiveStarsMapBeenZ.groupSelectionNum = 1;
    dataFiveStarsMapBeenZ.playModeSingleOrDouble = 2;
    dataFiveStarsPlayList.add(dataFiveStarsMapBeenZ);

    choiceModeMap[threeYardsBeen] = dataFiveStarsPlayList;

    /// 前二
    Map<String, dynamic> dataLaterFour = data["125"];//前二
    var laterFourBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataLaterFour);
    var dataLaterFourBeen294 = dataLaterFour["play"];//
    List<Play11Choice5DataPlayBeen> dataLaterFourPlayList = new List(); // 前二 列表

    var dataTopThreePlayBeen295 = dataLaterFourBeen294["126"]["play"];//
    Map<String, dynamic> dataLaterFourPlayMapF = dataTopThreePlayBeen295["127"];//前二 复式
    var dataLaterFourMapBeenF = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapF);
    dataLaterFourMapBeenF.playMode = 2;
    dataLaterFourMapBeenF.groupSelectionNum = 2;
    dataLaterFourMapBeenF.playModeSingleOrDouble = 2;
    dataLaterFourPlayList.add(dataLaterFourMapBeenF);

    Map<String, dynamic> dataLaterFourPlayMapD = dataTopThreePlayBeen295["128"];//前二 单式
    var dataLaterFourMapBeenD = Play11Choice5DataPlayBeen.fromJson(dataLaterFourPlayMapD);
    dataLaterFourMapBeenD.playMode = 2;
    dataLaterFourMapBeenD.groupSelectionNum = 0;
    dataLaterFourMapBeenD.playModeSingleOrDouble = 1;
    dataLaterFourPlayList.add(dataLaterFourMapBeenD);

    choiceModeMap[laterFourBeen] = dataLaterFourPlayList;

    /// 定位胆
    Map<String, dynamic> dataPositioning = data["138"];//定位胆
    var dataPositioningBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataPositioning);
    List<Play11Choice5DataPlayBeen> dataPositioningPlayList = new List();

    Map<String, dynamic> dataPositioningPlay = dataPositioning["play"];//
    Map<String, dynamic> dataPositioningPlay60 = dataPositioningPlay["139"]["play"];//

    Map<String, dynamic> dataPositioningPlay61 = dataPositioningPlay60["1531"];
    var dataBeenPositioning  = Play11Choice5DataPlayBeen.fromJson(dataPositioningPlay61);
    dataBeenPositioning.groupSelectionNum = 1;
    dataBeenPositioning.playModeSingleOrDouble = 2;
    dataBeenPositioning.playMode = 3;
    dataPositioningPlayList.add(dataBeenPositioning);

    choiceModeMap[dataPositioningBeen] = dataPositioningPlayList;

    /// 大小
    Map<String, dynamic> dataUncertainGallbladder = data["140"];//
    var dataUncertainGallbladderBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataUncertainGallbladder);
    List<Play11Choice5DataPlayBeen> dataUncertainGallbladderPlayList = new List();

    Map<String, dynamic> dataUncertainGallbladderPlay = dataUncertainGallbladder["play"];//

    Map<String, dynamic> dataUncertainGallbladder63 = dataUncertainGallbladderPlay["141"]["play"];//大小
    /// 大小
    for(int two = 142; two <= 144; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataUncertainGallbladder63["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 4;

      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataUncertainGallbladderPlayList.add(dataUncertainGallbladderBeenUnGa);
    }


    choiceModeMap[dataUncertainGallbladderBeen] = dataUncertainGallbladderPlayList;

    /// 单双
    Map<String, dynamic> dataSingleDouble = data["1533"];//
    var dataSingleDoubleBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataSingleDouble);
    List<Play11Choice5DataPlayBeen> dataSingleDoubleBeenPlayList = new List();

    Map<String, dynamic> dataSingleDoubleBeenPlay = dataSingleDouble["play"];//

    Map<String, dynamic> dataSingleDoubleBeen1534 = dataSingleDoubleBeenPlay["1534"]["play"];//大小
    /// 大小
    for(int two = 1535; two <= 1537; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataSingleDoubleBeen1534["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 5;

      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataSingleDoubleBeenPlayList.add(dataUncertainGallbladderBeenUnGa);
    }


    choiceModeMap[dataSingleDoubleBeen] = dataSingleDoubleBeenPlayList;


    /// 龙虎
    Map<String, dynamic> dataDragonTiger = data["1538"];//
    var dataDragonTigerBeen = Play11Choice5DataThreeYardsBeen.fromJson(dataSingleDouble);
    List<Play11Choice5DataPlayBeen> dataDragonTigerBeenPlayList = new List();

    Map<String, dynamic> dataDragonTigerBeenPlay = dataDragonTiger["play"];//

    Map<String, dynamic> dataDragonTigerBeen1534 = dataDragonTigerBeenPlay["1539"]["play"];//龙虎
    /// 大小
    for(int two = 1540; two <= 1542; two++) {
      Map<String, dynamic> dataTopTwoPlayTwoI = dataDragonTigerBeen1534["$two"];
      var dataUncertainGallbladderBeenUnGa  = Play11Choice5DataPlayBeen.fromJson(dataTopTwoPlayTwoI);
      dataUncertainGallbladderBeenUnGa.playMode = 6;

      dataUncertainGallbladderBeenUnGa.groupSelectionNum = 1;
      dataUncertainGallbladderBeenUnGa.playModeSingleOrDouble = 2;

      dataDragonTigerBeenPlayList.add(dataUncertainGallbladderBeenUnGa);
    }


    choiceModeMap[dataDragonTigerBeen] = dataDragonTigerBeenPlayList;

  }


}