import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/dialog/LineSwitchingDialog.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:package_info/package_info.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:flutter_lisheng_entertainment/Util/Constant.dart';

import '../HomeController.dart';
import 'net/LoginHandler.dart';

/// 登录界面
class LoginActivity extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginActivity();
  }

}

class _LoginActivity extends BaseController<LoginActivity> implements LoginHandler {

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  List<String> _loginIconList = ["resource/imgs/icon_account.png"
    , "resource/imgs/icon_password.png"];
  List<String> _loginEditHintList = ["请输入登录账号"
    , "请输入密码"];

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  String phone = "";
  String password = "";
  String version;//保存当前版本

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化视频
    _videoPlayerController = VideoPlayerController.asset(Constant.loginMp4Url)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController.play();
        });
      });
    _videoPlayerController.setLooping(true);
  }

//  @override
//  void deactivate() {
//    // TODO: implement deactivate
//
//    if (_chewieController != null && _chewieController.isLive) {
//      if (_videoPlayerController != null) {
//        _videoPlayerController.dispose();
//      }
//      if (_chewieController != null) {
//        _chewieController.dispose();
//      }
//    }
//    super.deactivate();
//
//  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_videoPlayerController != null) {
      _videoPlayerController.dispose();
    }
    if (_chewieController != null) {
      _chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.getInstance();
    SpUtil.getInstance();
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Center(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              child: _videoView(),
              height: ScreenUtil.getScreenH(context),
            ),
            //_chenViewVideo(),

            new Column(
              children: <Widget>[
                new Expanded(child: _loginTopLogo(), flex: 3,),
                new Expanded(child: _loginView(), flex: 6,),
                _customView(),


              ],
            ),

            _lineChage(),

          ],
        ),
      ),
    );
  }

  /// 线路切换
  Widget _lineChage() {

    return new GestureDetector(
      onTap: () {
        //线路切换
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => new LineSwitchingDialog()
        );
      },
      child: new Align(
        alignment: Alignment.topRight,
        child: new Container(
          margin: EdgeInsets.only(top: 200.0),
          child: new Image.asset(ImageUtil.imgLoginChangeGroup, width: 61.0, height: 68.0, ),
        ),
      ),
    );
  }


  /// 返回视频控件
  Widget _videoView() {

    return _videoPlayerController.value.initialized
        ? AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: VideoPlayer(_videoPlayerController),
    )
        : Container();
  }

  Widget _chenViewVideo() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      //aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      //fullScreenByDefault: true,
      allowFullScreen: true,
    );
    return new Chewie(
      controller: _chewieController,
    );
  }

  //返回登录控件 material
//  Widget _loginView() {
//
//    return new Center(
//      child: new Container(
//        width: 326.0,
//        height: 265.0,
//        child: new Material(
//          child: new Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              _listLoginView(),
//              new Container(
//                padding: EdgeInsets.only(top: 30.0,),
//                child: _butLoginView(),
//              ),
//
//              _textVersion(),
//
//            ],
//          ),
//          shadowColor: Color(ColorUtil.lineColor),
//          elevation: 5.0,
//          borderRadius: new BorderRadius.circular(5.0),
//        ),
//        margin: EdgeInsets.only(bottom: 30.0),
//      ),
//    );
//  }

  Widget _loginView() {

    return new Container(
      width: 326.0,
      child: new Material(
        color: Colors.transparent,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _listLoginView(),
            new Container(
              padding: EdgeInsets.only(top: 30.0,),
              child: _butLoginView(),
            ),

            _textVersion(),

          ],
        ),
        shadowColor: Colors.transparent,
        elevation: 0.0,
        //borderRadius: new BorderRadius.circular(5.0),
      ),
      //margin: EdgeInsets.only(bottom: 30.0),
    );
  }

  //登录输入框View
  Widget _loginEditView(String iconStr, String hintText, ValueChanged<String> _textFieldChanged
      , TextEditingController controller, bool isPassword) {
    return new Column(
      children: <Widget>[
        _loginEditViewColumn(iconStr, hintText, _textFieldChanged, controller, isPassword),
//        new Expanded(child: _loginEditViewColumn(iconStr, hintText)),
        new Container(color: Color(ColorUtil.lineColor), height: 1.0,),
        
      ],
    );
  }

  Widget _loginEditViewColumn(String iconStr, String hintText, ValueChanged<String> _textFieldChanged
      , TextEditingController controller, bool isPassword) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /// 图片
        new Image.asset(iconStr, width: 20.0, height: 20.0,),
        new Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 10.0),
              child: new TextField(
                style: TextStyle(fontSize: 14, color: Color(ColorUtil.whiteColor)),
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hoverColor: Color(ColorUtil.whiteColor),
                  hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.whiteColor)),
                ),
                onChanged: _textFieldChanged,
                controller: controller,
                obscureText: isPassword,
              ),
            ),
        ),

      ],
    );
  }

  _phoneText(String str) {
    phone = str;
  }

  _passwordText(String str) {
    password = str;
  }

  ///返回 控件列表
  Widget _listLoginView() {
    return new Container(
      padding: EdgeInsets.only(left: 15.0,right: 15.0, top: 15.0),
      width: 326.0,
      height: 135.0,
      child: new Center(
        child:  new Column(
          children: <Widget>[
            _loginEditView(_loginIconList[0], _loginEditHintList[0], _phoneText, phoneController, false),

            new Container(
              padding: EdgeInsets.only(top: 15.0),
            ),
            _loginEditView(_loginIconList[1], _loginEditHintList[1], _passwordText, passController,true),

          ],
        ),
      ),
    );
  }

  /// 按钮控件
  Widget _butLoginView() {
    return new Container(
      width: 300.0,
      height: 45.0  ,
      child: new RaisedButton(onPressed: (){
        //跳转首页
//        Navigator.pushNamedAndRemoveUntil(context, RouteUtil.homeController);

        UserService.instance.login(phone, password, this);

      },color: Color(ColorUtil.butColor),
        child: new Text(StringUtil.login
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

  ///显示当前版本
  Widget _textVersion() {
    _getDevInfoVersion();
    return new Container(
      padding: EdgeInsets.only(top: 15.0),
      child: new Text("当前版本$version",
        style: TextStyle(fontSize: 12.0, color: Color(ColorUtil.whiteColor)),
      ),
    );
  }

  _getDevInfoVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      setState(() {
        this.version = version;
      });
    });
  }

  /// 登录顶部图片
  Widget _loginTopLogo() {
    return new Image.asset(ImageUtil.imgLoginLogo, width: 210.0, height: 60.0,);
  }

  //联系客服
  Widget _customView() {
    
    return new Center(
      child: new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 70.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Image.asset(ImageUtil.imgLoginCustom, width: 20.0, height: 20.0,),

            SpaceViewUtil.pading_Left(5.0),
//
            new Expanded(
              flex: 0,
                child: new Text(
                  StringUtil.customContact,
                  style: new TextStyle(
                      fontSize: 12.0, color: Color(ColorUtil.whiteColor)
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }

  @override
  void loginFail(bool result) {

  }

  @override
  void loginSuccess(bool result, LoginBeen loginBeen) {
    try {
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
          builder: (BuildContext context) => HomeController(),
        settings: RouteSettings(
          arguments: {Constant.INTENT_VALUE_USER_INFO : loginBeen.data.userInfo},
        ),
      ), (//跳转到主页
          // ignore: unrelated_type_equality_checks
          Route route) => route == RouteUtil.homeController);
    } catch (e) {

    }
  }


}