import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/SemicircleButView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SemicircleButCallBack.dart';

/// 开户中心 -》 普通开户
class OrdinaryOpenAccountCenterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrdinaryOpenAccountCenterView();
  }

}

class _OrdinaryOpenAccountCenterView extends BaseController<OrdinaryOpenAccountCenterView> with SemicircleButCallBack{

  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[

        _openAccountType(),
        _editOpenAccount("请输入用户名", ImageUtil.imgOpenAccountEdit),
        _editTip(StringUtil.openAccountCenterEditTip),
        _editOpenAccount("请输入密码", ImageUtil.imgModify),
        _editTip(StringUtil.openAccountCenterEditTip),
        _editOpenAccount("请再次输入密码", ImageUtil.imgModify),
        _editOpenAccount("请输入返点", ImageUtil.imgReturnPoint),
        _editTip(StringUtil.openAccountCenterEditReturnTip),

        new Container(
          margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
          child: SemicircleButView(this,title: "立即开户",),
        ),

      ],
    );
//  return _openAccountType();
  }

  /// 开户类型选择
  Widget _openAccountType() {

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          new Text(
            "开户类型：",
            style: new TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

          _radioChoice(true, "代理", 1),
          _radioChoice(false, "玩家", 2),

        ],
      ),
    );
  }

  void setUpdateTypeChoice(int v) {
    setState(() {
      groupValue = v;
    });
  }

  Widget _radioChoice(bool isSelection, String title, int index) {
    return new GestureDetector(
      onTap: () {
        setUpdateTypeChoice(index);
      },
      child: new Container(
        padding: EdgeInsets.only(left: 15.0,),
        child: new Row(
          children: <Widget>[
            Image.asset(groupValue == index? ImageUtil.imgRadioBgSelection : ImageUtil.imgRadioBg
              , width: 22.0, height: 22.0,),
            SpaceViewUtil.pading_Left(5.0),
            new Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// 编辑输入 内容
  Widget _editOpenAccount(String hintText, String imgIcon) {

    return new Container(
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(

        children: <Widget>[

          new Image.asset(imgIcon, width: 16.0, height: 16.0,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
              ),
            ),
          )
        ],

      ),
    );
  }

  /// 输入框下提示
  Widget _editTip(String content) {

    return new Container(
      padding: EdgeInsets.only(left: 15.0, top: 10.0,right: 15.0,bottom: 10.0),
      child: new Text(
        content,
        style: TextStyle(
          fontSize: 12.0,
          color: Color(ColorUtil.textColor_888888)
        ),
      ),
    );
  }

  @override
  void onPressedBut() {
    // TODO: implement onPressedBut
  }

}