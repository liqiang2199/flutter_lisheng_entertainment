import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:share/share.dart';

/// 设置
class SetController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SetController();
  }

}

class _SetController extends State<SetController> {

  bool _lights = false; //switch 开关亮起来
  bool _lightsSuspension = false; //switch 开关亮起来

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      //context, StringUtil.set
      appBar: CommonView().commonAppBar(context, StringUtil.set),
      body: new Column(
        children: <Widget>[
          _switchView(),
          _rightArrowView(),
          _butLoginView(),

        ],
      ),
    );
  }


  Widget _switchView() {

    return new Container(
      margin: EdgeInsets.all(15.0),
      child: new Card(
        color: Colors.white,
        //z轴的高度，设置card的阴影
        elevation: 5.0,
        child: new Column(
          children: <Widget>[
            _getSwitchView(StringUtil.fingerprintLogin, ImageUtil.imgFingerprint),
            _line(),
            _getSuspensionSwitchView(StringUtil.lineSuspensionSwitch, ImageUtil.imgSwitch),
          ],
        ),
      ),
    );
  }

  _getSwitchView(String title, String icon) {

    return new ListStateItemView(
      title,
      isSwitch: true,
      leftIcon: icon,
      isCupertino: _lights,
      onChanged: (value){
        //value 是否开启
        print(title);
        setState(() {
          _lights = value;
        });
      },
    );
  }

  //线路悬浮开关
  _getSuspensionSwitchView(String title, String icon) {

    return new ListStateItemView(
      title,
      isSwitch: true,
      leftIcon: icon,
      isCupertino: _lightsSuspension,
      onChanged: (value){
        //value 是否开启
        print(title);
        setState(() {
          _lightsSuspension = value;
        });
      },
    );
  }

  /// 分享应用
  Widget _rightArrowView() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0,),
      child: new Card(
        color: Colors.white,
        //z轴的高度，设置card的阴影
        elevation: 5.0,
        child: new Column(
          children: <Widget>[
            _getRightArrowView(StringUtil.setShareAPP, ImageUtil.imgShare, 1),
            _line(),
            _getRightArrowView(StringUtil.setHelpCenter, ImageUtil.imgHelp, 2),
            _line(),
            _getRightArrowView(StringUtil.setAbout, ImageUtil.imgAbout, 3),
            _line(),
            _getRightArrowViewAndRightText(StringUtil.setUpdateVersion, ImageUtil.imgUpdateVersion),
          ],
        ),
      ),
    );
  }

  /// Share.share('check out my website https://example.com');
  _getRightArrowView(String title, String icon, int index) {

    return new GestureDetector(
      onTap: () {
        switch(index) {
          case 1:
            //分享
            Share.share('check out my website https://example.com');
            break;
        }
      },
      child: new ListStateItemView(
        title,
        isSwitch: false,
        isRightArrow: true,
        leftIcon: icon,
      ),
    );
  }

  _getRightArrowViewAndRightText(String title, String icon) {

    return new ListStateItemView(
      title,
      isSwitch: false,
      isRightArrow: true,
      leftIcon: icon,
      isRightText: true,
      rightText: "1.0.1",
    );
  }

  //分割线
  Widget _line() {

    return new Container(
      width: ScreenUtil.getScreenW(context),
      height: 1.0,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      color: Color(ColorUtil.lineColor),
    );
  }

  /// 退出登录
  Widget _butLoginView() {
    return new Container(
      width: 300.0,
      height: 45.0  ,
      margin: EdgeInsets.only(top: 18.0),
      child: new RaisedButton(onPressed: (){
        //退出登录

      },color: Color(ColorUtil.butColor),
        child: new Text(StringUtil.setExitLoginApp
          , style: TextStyle(fontSize: 16.0,color: Color(ColorUtil.whiteColor)),),
        //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        shape: new StadiumBorder(side: new BorderSide(
          //设置 界面效果
          color: Color(ColorUtil.butColor),
          style: BorderStyle.none,
        ),),
      ),
    );
  }


}