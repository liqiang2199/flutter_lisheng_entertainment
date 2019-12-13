
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import 'page_view/BettingView.dart';
import 'page_view/GameHallView.dart';

/**
 * 投注
 */
class BettingController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BettingController();
  }

}

class _BettingController extends BaseController<BettingController>{

  int _segmentedIndex = 2;//顶部菜单 切换
  // 显示那个 对应的界面 initialPage
  PageController mPageController = PageController(initialPage: 2);
  var isPageCanChanged = true;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        centerTitle: true,
        title: _appBarTitle(),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: _pageView(),
          ),
        ],
      ),
    );
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      //等待pageview切换完毕,再释放pageivew监听
      await mPageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
      isPageCanChanged = true;
    } else {
//      mTabController.animateTo(index);//切换Tabbar
      setState(() {
        _segmentedIndex = index;
      });
    }
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
          setState(() {
            _segmentedIndex = value;
          });
          onPageChange(value, p: mPageController);
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

  Widget _pageView() {

    return PageView.builder(
      itemCount: 4,
      onPageChanged: (index) {
        if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
          onPageChange(index);
        }
      },
      controller: mPageController,
      itemBuilder: (BuildContext context, int index) {
        return _pageViewIndex(index);
      },
    );
  }

  Widget _pageViewIndex(var index) {
    if (index == 2) {
      return BettingView();
    }
    return GameHallView();
  }

}