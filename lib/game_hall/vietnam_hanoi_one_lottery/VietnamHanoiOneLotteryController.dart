
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_11_choice_5/LotteryNum11Choice5Controller.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_11_choice_5/Record11Choice5Controller.dart';

import 'TrendHanoiOneLotteryController.dart';
import 'hanoi_view/VietnamHanoiOneLotteryBettingView.dart';

/**
 * 越南 河内一分彩
 */
class VietnamHanoiOneLotteryController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VietnamHanoiOneLotteryController();
  }

}

class _VietnamHanoiOneLotteryController extends BaseController<VietnamHanoiOneLotteryController> with SingleTickerProviderStateMixin{
  int _segmentedIndex = 2;//顶部菜单 切换
  // 显示那个 对应的界面 initialPage
  PageController mPageController = PageController(initialPage: 2);
  var isPageCanChanged = true;

  TabController mTabController;

  /// 初始化 TabPageController
  initTabPageController() {
    mTabController = TabController(
      length: 4,
      vsync: this,
    );
    mTabController.addListener(() {//TabBar的监听
      print(mTabController.index);
      if (mounted)
        setState(() {
          _segmentedIndex = mTabController.index;
        });
    });

    mTabController.animateTo(_segmentedIndex);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabPageController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: new AppBar(
        centerTitle: true,
        title: _appBarTitle(),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: _tabView(),
          ),
        ],
      ),
    );
  }

  Widget _appBarTitle() {

    return new Container(
      child: CupertinoSegmentedControl<int>(children: {
        0:Padding(padding: EdgeInsets.only(top:5.0,bottom: 5.0,left: 8.0, right: 8.0),child: _segmentedTitle("开奖"),),
        1:Padding(padding: EdgeInsets.all(5.0),child: _segmentedTitle("走势"),),
        2:Padding(padding: EdgeInsets.all(5.0),child: _segmentedTitle("投注"),),
        3:Padding(padding: EdgeInsets.all(5.0),child: _segmentedTitle("记录"),),
      },
        onValueChanged: (value){
          print("the value changed ! $value");
          mTabController.animateTo(value);//切换Tabbar
          if (mounted)
            setState(() {
              _segmentedIndex = value;
            });

          //onPageChange(value, p: mPageController);
        },
        groupValue: _segmentedIndex,
      ),
    );
  }

  Widget _segmentedTitle(String title) {

    return new Text(
      title,
      style: new TextStyle(
        fontSize: 14.0,
      ),
    );
  }

  Widget _tabView() {

    return new TabBarView(
        controller: this.mTabController,
        children: _tabListView()
    );
  }

  List<Widget> _tabListView() {
    List<Widget> tabViewList = new List();

    for (int i = 0; i < 4; i++) {
      tabViewList.add(_pageViewIndex(i));
    }
    return tabViewList;
  }

  Widget _pageViewIndex(var index) {
    if (index == 0) {
      return LotteryNum11Choice5Controller();
    }
    if (index == 1) {
      /// 走势图
      return TrendHanoiOneLotteryController();
    }
    if (index == 2) {
      return VietnamHanoiOneLotteryBettingView();
    }
    if (index == 3) {
      return Record11Choice5Controller();
    }
    return LotteryNum11Choice5Controller();
  }



}