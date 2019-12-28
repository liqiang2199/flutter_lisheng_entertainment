
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/AccountChangeRecordView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/GameBettingRecordView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/TrackingNumberRecordView.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendCoordinateBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 11 选 5 记录界面
 */
class Record11Choice5Controller extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Record11Choice5Controller();
  }

}

class _Record11Choice5Controller extends BaseRefreshTabController<Record11Choice5Controller, TabTitle> with AutomaticKeepAliveClientMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Column(
      children: <Widget>[

        _tabPage(),
        CommonView().commonLine_NoMarginChange(context,1.0),
        new Expanded(child: _tabPageChildView(),),

      ],
    );
  }

  @override
  bool isUserTabPage() {

    return false;
  }

  initTabData() {
    tabList = [
      new TabTitle('投注记录', 0),
      new TabTitle('追号记录', 1),
      new TabTitle('账变记录', 2),
    ];
  }

  Widget _tabPage() {

    return new Container(
      color: Colors.white,
      child: TabBar(
        isScrollable: false,
        //是否可以滚动
        controller: mTabController,
        labelColor: Color(ColorUtil.butColor),
        indicatorColor: Color(ColorUtil.butColor),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Color(ColorUtil.textColor_333333),
        labelStyle: TextStyle(fontSize: 14.0),
        tabs: tabList.map((item) {
          return Tab(
            text: item.title,
          );
        }).toList(),
      ),
    );
  }

  Widget _tabPageChildView() {

    return TabBarView(
        controller: this.mTabController,
        children:  _tabListItem());

//    return TabBarView(
//      controller: this.mTabController,
//      children:  tabList.map((item) {
//        _tabIndexView(item.id);
//      }).toList(),
//    );
  }

  List<Widget> _tabListItem() {
    List<Widget> tabList = new List();

    tabList.add(_tabIndexView(0));
    tabList.add(_tabIndexView(1));
    tabList.add(_tabIndexView(2));
    return tabList;
  }

//  Widget _pageView() {
//
//    return PageView.builder(
//      itemCount: tabList.length,
//      onPageChanged: (index) {
//        if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
//          onPageChange(index);
//        }
//      },
//      controller: mPageController,
//      itemBuilder: (BuildContext context, int index) {
//        return _tabIndexView(index);
//      },
//    );
//  }

  _tabIndexView(int index) {
    if (index == 0) {
      /// 投注记录
      return new GameBettingRecordView();
    }

    if (index == 1) {
      /// 追号记录
      return new TrackingNumberRecordView();
    }

    if (index == 2) {
      /// 账变记录
      return new AccountChangeRecordView();
    }
    return new GameBettingRecordView();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
