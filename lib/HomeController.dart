import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginUserInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/view/HomeControllerView.dart';

class HomeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeController();
  }

}

class _HomeController extends State<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  HomeControllerView();
  }
}