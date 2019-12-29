import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';
import 'package:flutter_picker/Picker.dart';

import 'ChoiceTimeResultInterface.dart';
import 'ShowPickerDateInterface.dart';
import 'bridge/TeamAccountChangeInterface.dart';

///  选择时间 和 输入用户名
///
///

class SelectionTimeAndEditNameView extends StatefulWidget {

  final SelectionTimeCallBack timeCallBack;
  final TeamAccountChangeInterface teamAccountChangeInterface;
  final String startTime;
  final String endTime;

  SelectionTimeAndEditNameView(this.timeCallBack, this.teamAccountChangeInterface,{
    Key key,
    this.startTime,
    this.endTime,
  }) : assert(
  timeCallBack != null
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectionTimeAndEditNameView(this.timeCallBack, this.teamAccountChangeInterface);
  }

}

class _SelectionTimeAndEditNameView extends BaseController<SelectionTimeAndEditNameView>
    with ShowPickerDateInterface implements ChoiceTimeResultInterface{


  SelectionTimeCallBack timeCallBack;
  TeamAccountChangeInterface teamAccountChangeInterface;
  String startTime;
  String endTime;
  String userName = "";

  _SelectionTimeAndEditNameView(this.timeCallBack,this.teamAccountChangeInterface,{
    Key key,
    this.startTime,
    this.endTime
  });

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
        children: <Widget>[
          _editAccountName(),
          _screenFindAndAccount(context),
        ],
      ),
      color: Color(ColorUtil.whiteColor),
    );
  }

  Widget _editAccountName() {

    return new Row(
      children: <Widget>[

        new Container(
          padding: EdgeInsets.only(left: 10.0,top: 15.0),
          child: new Text(
            "用户名：",
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),
        ),

        new Expanded(
            child: new Container(
              height: 40.0,
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0,),
              padding: EdgeInsets.only(right: 10.0,left: 10.0),
              decoration: new BoxDecoration(
                border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
                borderRadius: new BorderRadius.circular((5.0)), // 圆角度
              ),
              child: new TextField(
                style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
                decoration: InputDecoration(
                  hintText: "请输入用户名",
                  //contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                  contentPadding: const EdgeInsets.only(top: 0.0, bottom: 11.0),
                  border: InputBorder.none,
                  hoverColor: Color(ColorUtil.whiteColor),
                  hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
                ),
                onChanged: _getUserName,
              ) ,
            ),
        ),

      ],
    );
  }


  /// 筛选 根据种类和账户
  Widget _screenFindAndAccount(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          new Expanded(child: _choiceStarTime(context)),
          new Container(
            margin: EdgeInsets.only(top: 15.0, ),
            child: new Text("至",
              style: TextStyle(
                color: Color(ColorUtil.textColor_888888),
                fontSize: 14.0,
              ),
            ),
          ),
          new Expanded(child: _choiceEndTime(context)),
          new Expanded(child: _butSearch(), flex: 0,),

        ],
      ),
    );
  }

  /// 选择开始时间
  Widget _choiceStarTime(BuildContext context) {

    return new GestureDetector(
      onTap: () {
        showPickerDateTime(context, this,ShowPickerDateInterface.StartTimeType);
      },
      child: new Container(
        height: 30.0,
        margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 10.0,),
        padding: EdgeInsets.only(right: 10.0,left: 10.0),
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
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
  Widget _choiceEndTime(BuildContext context) {

    return new GestureDetector(
      onTap: () {
        showPickerDateTime(context, this,ShowPickerDateInterface.EndTimeType);
      },
      child: new Container(
        height: 30.0,
        margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0,),
        padding: EdgeInsets.only(right: 10.0,left: 10.0),
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
          borderRadius: new BorderRadius.circular((5.0)), // 圆角度
        ),
        child:new Row(

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

  _getUserName(String str) {
    userName = str;
  }

  /// 搜索
  Widget _butSearch() {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 67.0,
        height: 30.0  ,
        margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //
          if (timeCallBack != null && teamAccountChangeInterface != null) {
            timeCallBack?.selectionStartTime(startTime);
            timeCallBack?.selectionEndTime(endTime);
            teamAccountChangeInterface?.setTeamAccountChangeRecordUserName(userName);
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