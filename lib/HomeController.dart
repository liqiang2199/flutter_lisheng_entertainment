import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginUserInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/view/HomeControllerView.dart';

class HomeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeController();
  }

}

class _HomeController extends BaseController<HomeController> {

  DateTime lastPopTime;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new WillPopScope(
        child: HomeControllerView(),
        onWillPop: () async{
          // 点击返回键的操作
          if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
            lastPopTime = DateTime.now();
            showToast("再按一次退出");
          }else{
            lastPopTime = DateTime.now();
            // 退出app
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
          return;
        }
    );
  }
}