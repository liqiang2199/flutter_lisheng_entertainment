
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';

import 'ChoiceTimeResultInterface.dart';
import 'bridge/EditNameInterface.dart';

///  选择时间 和 输入用户名
///
///

class ScreenEditNameView extends StatefulWidget {

  final EditNameInterface editNameInterface;


  ScreenEditNameView(this.editNameInterface,{
    Key key,
  }) ;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScreenEditNameView(this.editNameInterface);
  }

}

class _ScreenEditNameView extends BaseController<ScreenEditNameView> {


  EditNameInterface editNameInterface;
  String userName = "";

  _ScreenEditNameView(this.editNameInterface);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: new Column(
        children: <Widget>[
          _editAccountName(),
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

        new Expanded(child: _butSearch(), flex: 0,),

      ],
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
          if (editNameInterface != null) {
            editNameInterface?.setEditUserName(userName);
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



}