
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/EventBusUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_11_choice_5/LotteryNum11Choice5Controller.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_11_choice_5/Record11Choice5Controller.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/TrendHanoiOneLotteryController.dart';
import 'package:flutter_lisheng_entertainment/model/bus/BettingResultTabBettingRecordBus.dart';



/**
 * 腾讯分分彩
 */
///
class ChongQingTimeLotteryController extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChongQingTimeLotteryController();
  }

}

class _ChongQingTimeLotteryController extends BaseController<ChongQingTimeLotteryController> with SingleTickerProviderStateMixin{
  int _segmentedIndex = 2;//顶部菜单 切换
  // 显示那个 对应的界面 initialPage
  PageController mPageController = PageController(initialPage: 2);
  var isPageCanChanged = true;
  String _colorVarietyID = "15";

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

    eventBus.on<BettingResultTabBettingRecordBus>().listen((event) {
      if (mTabController != null) {
        mTabController.animateTo(3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Map args = ModalRoute.of(context).settings.arguments;
    print("arg= $args");
    if (args.containsKey(Constant.COLOR_VARIETY_ID)) {

      args.forEach((k,v){
        if (k.toString() == Constant.COLOR_VARIETY_ID) {
          //ColorVarietyID 彩种ID
          _colorVarietyID = "$v";
        }
      });
    }

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
      return LotteryNum11Choice5Controller("$_colorVarietyID");
    }
    if (index == 1) {
      /// 走势图
      return TrendHanoiOneLotteryController();
    }
    if (index == 2) {
//      return TencentLotteryBettingView("$_colorVarietyID");
    }
    if (index == 3) {
      return Record11Choice5Controller("$_colorVarietyID");
    }
    return LotteryNum11Choice5Controller("$_colorVarietyID");
  }



}