
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/agent_view/LinkManagerController.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/page_view/GameHallView.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 游戏大厅
 */
class GameHallController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameHallController();
  }

}

class _GameHallController extends BaseRefreshTabController<GameHallController, TabTitle> with AutomaticKeepAliveClientMixin {

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
    return new Scaffold(
      backgroundColor: Color(ColorUtil.whiteColor),
      appBar: CommonView().commonAppBar(context, "游戏大厅"),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          CommonView().commonLine_NoMarginChange(context,10.0),
//          new Expanded(child: _pageView(),),
          new Expanded(child: _tabPageChildView(),),
        ],
      ),
    );
  }

  @override
  bool isUserTabPage() {

    return false;
  }

  initTabData() {
    tabList = [
      new TabTitle('游戏大厅', 11),
    ];
  }

  @override
  void onRefreshData() {

  }

  Widget _tabPage() {

    return new Container(
      color: Colors.white,
      child: TabBar(
        isScrollable: true,
        //是否可以滚动
        controller: mTabController,
        labelColor: Color(ColorUtil.butColor),
        indicatorColor: Color(ColorUtil.butColor),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Color(ColorUtil.textColor_333333),
        labelStyle: TextStyle(fontSize: 16.0),
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
      children: <Widget>[
        _pageViewIndex(0),
      ],
    );
  }

  Widget _pageView() {

    return PageView.builder(
      itemCount: tabList.length,
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
    return GameHallView();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//被重绘


}