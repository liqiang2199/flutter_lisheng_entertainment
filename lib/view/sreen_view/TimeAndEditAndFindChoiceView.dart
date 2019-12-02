import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  选择时间 和 输入用户名 彩种 选择
class TimeAndEditAndFindChoiceView extends StatelessWidget {


  final SelectionTimeCallBack timeCallBack;
  final String startTime;
  final String endTime;

  const TimeAndEditAndFindChoiceView(this.timeCallBack,{
    Key key,
    this.startTime,
    this.endTime
  }) : assert(
   timeCallBack != null
  ),super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: new Column(
        children: <Widget>[
          _editAccountName(),
          _choiceTime(),
          _screenFindAndAccount(),
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
                  border: InputBorder.none,
                  hoverColor: Color(ColorUtil.whiteColor),
                  hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
                ),
              ) ,
            ),
        ),

      ],
    );
  }


  /// 筛选 根据种类和账户
  Widget _choiceTime() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          new Expanded(child: _choiceStarTime()),
          new Container(
            margin: EdgeInsets.only(top: 15.0, ),
            child: new Text("至",
              style: TextStyle(
                color: Color(ColorUtil.textColor_888888),
                fontSize: 14.0,
              ),
            ),
          ),
          new Expanded(child: _choiceEndTime()),
          new Expanded(child: _butSearch(false), flex: 0,),

        ],
      ),
    );
  }

  /// 选择开始时间
  Widget _choiceStarTime() {

    return new Container(
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
              "选择时间",
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_888888),
              ),
              maxLines: 1,
            ),
          ),

          new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
          SpaceViewUtil.pading_Left(5.0),

        ],

      ),
    );
  }


  /// 选择选择结束时间
  Widget _choiceEndTime() {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(

        children: <Widget>[

          new Expanded(
            child: new Text(
              "选择时间",
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_888888),
              ),
              maxLines: 1,
            ),
          ),

          new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
          SpaceViewUtil.pading_Left(5.0),

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

          new Expanded(child: _findChoice()),
          new Expanded(child: _editAccount("请输入期号")),
          new Expanded(child: _butSearch(true), flex: 0,),

        ],
      ),
    );
  }

  /// 账户 输入框
  Widget _editAccount(String hintText) {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0,),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 12, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 12.0, color: Color(ColorUtil.textColor_888888)),
              ),
              maxLines: 1,
            ),
          ),

        ],

      ),
    );
  }

  /// 选择彩种
  Widget _findChoice() {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(

        children: <Widget>[

          new Expanded(
            child: new Text(
              "选择彩种",
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_888888),
              ),
              maxLines: 1,
            ),
          ),

          new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
          //SpaceViewUtil.pading_Left(5.0),

        ],

      ),
    );
  }

  /// 搜索
  Widget _butSearch(var isVisibility) {
    return new Visibility(
      visible: isVisibility,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: new Align(
        alignment: Alignment.center,
        child: new Container(
          width: 67.0,
          height: 30.0  ,
          margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 15.0,),
          child: new RaisedButton(onPressed: (){
            //

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
      ),
    );
  }

}