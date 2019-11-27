import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_lisheng_entertainment/Util/Constant.dart';

import '../HomeController.dart';

/// 登录界面
class LoginActivity extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginActivity();
  }

}

class _LoginActivity extends State<LoginActivity> {

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  List<String> _loginIconList = ["resource/imgs/icon_account.png"
    , "resource/imgs/icon_password.png"];
  List<String> _loginEditHintList = ["请输入登录账号"
    , "请输入密码"];

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
    ScreenUtil.getInstance().init(context);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Center(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              child: _videoView(),
              height: ScreenUtil.screenHeight,
            ),
            //_chenViewVideo(),

            new Column(
              children: <Widget>[
                new Expanded(child: _loginTopLogo(), flex: 3,),
                new Expanded(child: _loginView(), flex: 6,),
                _customView(),


              ],
            ),

          ],
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
  Widget _loginEditView(String iconStr, String hintText) {
    return new Column(
      children: <Widget>[
        _loginEditViewColumn(iconStr, hintText),
//        new Expanded(child: _loginEditViewColumn(iconStr, hintText)),
        new Container(color: Color(ColorUtil.lineColor), height: 1.0,),
        
      ],
    );
  }

  Widget _loginEditViewColumn(String iconStr, String hintText) {
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
              ),
            ),
        ),

      ],
    );
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
            _loginEditView(_loginIconList[0], _loginEditHintList[0]),

            new Container(
              padding: EdgeInsets.only(top: 15.0),
            ),
            _loginEditView(_loginIconList[1], _loginEditHintList[1]),

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
        //Navigator.pushNamedAndRemoveUntil(context, RouteUtil.homeController);
        try {
          Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
              builder: (BuildContext context) => HomeController()), (//跳转到主页
              // ignore: unrelated_type_equality_checks
              Route route) => route == RouteUtil.homeController);
        } catch (e) {

        }
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
    return new Container(
      padding: EdgeInsets.only(top: 15.0),
      child: new Text("当前版本1.0.0",
        style: TextStyle(fontSize: 12.0, color: Color(ColorUtil.whiteColor)),
      ),
    );
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


}