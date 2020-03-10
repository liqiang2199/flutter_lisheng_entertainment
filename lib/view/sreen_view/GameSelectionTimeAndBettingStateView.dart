import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/ShowPickerDateInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';
import 'package:popup_windows/popup_windows.dart';

import '../PopupWindowButton.dart';
import 'ChoiceTimeResultInterface.dart';
import 'bridge/ChoiceBettingStatusInterface.dart';
import 'pop_postion/ChoiceStatusPop.dart';

/// 选择时间
class GameSelectionTimeAndBettingStateView extends StatefulWidget {


  final SelectionTimeCallBack timeCallBack;
  final ChoiceBettingStatusInterface choiceBettingStatusInterface;
  final String startTime;
  final String endTime;

  const GameSelectionTimeAndBettingStateView(this.timeCallBack,{
    Key key,
    this.startTime = "选择时间",
    this.endTime = "选择时间",
    this.choiceBettingStatusInterface,
  }) : assert(
  timeCallBack != null
  ),super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameSelectionTimeAndBettingStateView(this.timeCallBack,key: key,
        startTime: startTime, endTime: endTime, choiceBettingStatusInterface: choiceBettingStatusInterface);
  }

}
class _GameSelectionTimeAndBettingStateView extends BaseController<GameSelectionTimeAndBettingStateView> with ShowPickerDateInterface,ChoiceTimeResultInterface{


  SelectionTimeCallBack timeCallBack;
  ChoiceBettingStatusInterface choiceBettingStatusInterface;
  String startTime = "选择时间";
  String endTime = "选择时间";
  String _statusContent = "全部";

  _GameSelectionTimeAndBettingStateView(this.timeCallBack,{
    Key key,
    this.choiceBettingStatusInterface,
    this.startTime,
    this.endTime
  }) ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    endTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _choiceBettingState(),
          _screenFindAndAccount(),

        ],
      ),
    );
  }


  /// 筛选 根据种类和账户
  Widget _screenFindAndAccount() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          new Expanded(child: _choiceStarTime()),
          new Container(
            margin: EdgeInsets.only(top: 8.0, ),
            child: new Text("至",
              style: TextStyle(
                color: Color(ColorUtil.textColor_333333),
                fontSize: 14.0,
              ),
            ),
          ),
          new Expanded(child: _choiceEndTime()),
          new Expanded(child: _butSearch(), flex: 0,),

        ],
      ),
    );
  }

  /// 选择投注状态
  Widget _choiceBettingState() {

    return new PopupWindowWidget(
      intelligentConversion: true,
      direction: Direction.Top,
      showChild: Container(
        height: 160.0,
        alignment: Alignment.centerLeft,
        color: Color(ColorUtil.bgColor_F1F1F1),
        child: Column(
          children: _popContent(),
        ),
      ),
      child: new Container(
        height: 30.0,
        width: 100.0,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 1.0, left: 15.0, right: 10.0,),
        padding: EdgeInsets.only(right: 10.0,left: 10.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                _statusContent,
                style: new TextStyle(
                  fontSize: 12.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
                maxLines: 1,
              ),
            ),

            new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
            SpaceViewUtil.pading_Left(5.0),

          ],

        ),
      ),
    );
  }

  List<Widget> _popContent() {
    List<Widget> listW = new List();
    var bettingStatuePopData = ChoiceBettingStatusPopData.getBettingStatuePopData();
    bettingStatuePopData.forEach((popData){
      listW.add(
          new GestureDetector(
            onTap: (){
              /// 选中
              if (choiceBettingStatusInterface != null) {
                choiceBettingStatusInterface?.bettingStatusChoice(popData.id);
              }
              Navigator.pop(context);
              _statusContent = popData.content;
              setState(() {

              });

            },
            child: new Container(
              padding: EdgeInsets.only(top:15.0,left: 15.0),
              width: ScreenUtil.getScreenW(context),
              child: new Text(
                popData.content,
                style: TextStyle(
                  color: Color(ColorUtil.textColor_333333),
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
      );
    });
    return listW;
  }

  /// 选择开始时间
  Widget _choiceStarTime() {

    return new GestureDetector(
      onTap: () {
        showPickerDateTime(context, this,ShowPickerDateInterface.StartTimeType);
      },
      child: new Container(
        height: 30.0,
        margin: EdgeInsets.only(top: 8.0, left: 15.0, right: 10.0,),
        padding: EdgeInsets.only(right: 10.0,left: 10.0),
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
          borderRadius: new BorderRadius.circular((5.0)), // 圆角度
        ),
        child: new Row(

          children: <Widget>[

            new Expanded(
              child: new Text(
                startTime,
                style: new TextStyle(
                  fontSize: 12.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
                maxLines: 1,
              ),
            ),

            new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
            SpaceViewUtil.pading_Left(5.0),

          ],

        ),
      ),
    );
  }


  /// 选择选择结束时间
  Widget _choiceEndTime() {

    return new GestureDetector(
      onTap: () {
        //选择结束时间
        showPickerDateTime(context, this,ShowPickerDateInterface.EndTimeType);
      },
      child: new Container(
        height: 30.0,
        margin: EdgeInsets.only(top: 8.0, left: 10.0, right: 5.0,),
        padding: EdgeInsets.only(right: 10.0,left: 10.0),
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
          borderRadius: new BorderRadius.circular((5.0)), // 圆角度
        ),
        child: new Row(

          children: <Widget>[

            new Expanded(
              child: new Text(
                endTime,
                style: new TextStyle(
                  fontSize: 12.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
                maxLines: 1,
              ),
            ),

            new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
            SpaceViewUtil.pading_Left(5.0),

          ],

        ),
      ),
    );
  }

  /// 搜索
  Widget _butSearch() {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 67.0,
        height: 30.0  ,
        margin: EdgeInsets.only(top: 8.0, left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //
          if (timeCallBack != null) {
            timeCallBack.selectionEndTime(endTime == "选择时间" ? "" : endTime);
            timeCallBack.selectionStartTime(startTime == "选择时间" ? "" : startTime);
          }

        },color: Color(ColorUtil.butColor),
          child: new Text(StringUtil.searchButText
            , style: TextStyle(fontSize: 13.0,color: Color(ColorUtil.whiteColor)),),
          //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(ColorUtil.butColor),
            style: BorderStyle.none,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  @override
  void choiceTime(String time, int timeStatus) {
    if (timeStatus == ShowPickerDateInterface.StartTimeType) {
      // 开始时间
      this.startTime = time;
    } else {
      this.endTime = time;
    }

    setState(() {

    });
  }


}

/**
 * 选择状态数据
 */
class ChoiceBettingStatusPopData {

  String id;
  String content;

  ChoiceBettingStatusPopData(this.id, this.content);

  static List<ChoiceBettingStatusPopData> getBettingStatuePopData() {
    List<ChoiceBettingStatusPopData> popDataList = new List();

    ChoiceBettingStatusPopData bettingStatusPopDataAll = new ChoiceBettingStatusPopData("0", "全部");
    ChoiceBettingStatusPopData bettingStatusPopDataDKJ = new ChoiceBettingStatusPopData("1", "待开奖");
    ChoiceBettingStatusPopData bettingStatusPopDataZJ = new ChoiceBettingStatusPopData("2", "中奖");
    ChoiceBettingStatusPopData bettingStatusPopDataWKJ = new ChoiceBettingStatusPopData("3", "未开奖");

    popDataList.add(bettingStatusPopDataAll);
    popDataList.add(bettingStatusPopDataDKJ);
    popDataList.add(bettingStatusPopDataZJ);
    popDataList.add(bettingStatusPopDataWKJ);

    return popDataList;
  }


}