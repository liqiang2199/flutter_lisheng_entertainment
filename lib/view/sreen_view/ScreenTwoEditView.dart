import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/ScreenCallBack.dart';

class ScreenTwoEditView extends StatelessWidget {

  final ScreenCallBack screenCallBack;

  const ScreenTwoEditView(
      this.screenCallBack,
      {Key key}
      ) : assert(
  screenCallBack != null,
  ), super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      color: Color(ColorUtil.whiteColor),
      padding: EdgeInsets.only(bottom: 15.0),
      child: _screenFindAndAccount(),
    );
  }


  /// 筛选 根据种类和账户
  Widget _screenFindAndAccount() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          new Expanded(child: _editUseName("请输入用户名")),
          new Expanded(child: _editAgentName("请输入代理下级")),
          new Expanded(child: _butSearch(true), flex: 0,),

        ],
      ),
    );
  }

  /// 账户 输入框
  Widget _editUseName(String hintText) {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0,),
      padding: EdgeInsets.only(right: 10.0,left: 5.0,),
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
                contentPadding: const EdgeInsets.only(top: 0.0, bottom: 13.5),
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

  /// 账户 输入框
  Widget _editAgentName(String hintText) {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0,),
      padding: EdgeInsets.only(right: 10.0,),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Align(
        alignment: Alignment.centerLeft,
        child: new TextField(
          style: TextStyle(fontSize: 12, color: Color(ColorUtil.textColor_333333)),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.only(top: 0.0, bottom: 13.5),
            border: InputBorder.none,
            hoverColor: Color(ColorUtil.whiteColor),
            hintStyle: TextStyle(fontSize: 12.0, color: Color(ColorUtil.textColor_888888)),
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
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
