
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
  String colorVariety;
  Record11Choice5Controller(this.colorVariety);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Record11Choice5Controller(this.colorVariety);
  }

}

class _Record11Choice5Controller extends BaseRefreshTabController<Record11Choice5Controller, TabTitle> with AutomaticKeepAliveClientMixin {
  String colorVariety;
  _Record11Choice5Controller(this.colorVariety);

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

  }

  List<Widget> _tabListItem() {
    List<Widget> tabList = new List();

    tabList.add(_tabIndexView(0));
    tabList.add(_tabIndexView(1));
    tabList.add(_tabIndexView(2));
    return tabList;
  }

  _tabIndexView(int index) {
    if (index == 0) {
      /// 投注记录
      return new GameBettingRecordView("$colorVariety");
    }

    if (index == 1) {
      /// 追号记录
      return new TrackingNumberRecordView();
    }

    if (index == 2) {
      /// 账变记录
      return new AccountChangeRecordView();
    }
    return new GameBettingRecordView("$colorVariety");
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
