import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

class SelectionTimeView extends StatelessWidget {


  final SelectionTimeCallBack timeCallBack;
  final String startTime;
  final String endTime;

  const SelectionTimeView(this.timeCallBack,{
    Key key,
    this.startTime,
    this.endTime
  }) : assert(
   timeCallBack != null
  ),super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _screenFindAndAccount();
  }


  /// 筛选 根据种类和账户
  Widget _screenFindAndAccount() {
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
          new Expanded(child: _butSearch(), flex: 0,),

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
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
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
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
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


}