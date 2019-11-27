import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/user/LoginActivity.dart';

/// 启动页
class SplashController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashController();
  }

}

class _SplashController extends State<SplashController> {

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(const Duration(milliseconds: 3000), () {
      try {
        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginActivity()), (//跳转到主页
            Route route) => route == null);
      } catch (e) {

      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Image.asset(
        ImageUtil.imgBgSplash,
        repeat: ImageRepeat.repeat,
      ),
    );
  }

}