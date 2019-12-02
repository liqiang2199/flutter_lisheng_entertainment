import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeAndEditNameView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'agent_view/LinkManagerController.dart';
import 'agent_view/LinkOpenAccountCenterView.dart';
import 'agent_view/OrdinaryOpenAccountCenterView.dart';

/// 开户中心
class OpenAccountCenterController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OpenAccountCenterController();
  }

}

class _OpenAccountCenterController extends BaseRefreshTabController<OpenAccountCenterController, TabTitle>
    with AutomaticKeepAliveClientMixin{

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
      appBar: CommonView().commonAppBar(context, StringUtil.agentOpenAccount),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          CommonView().commonLine_NoMarginChange(10.0),
          new Expanded(child: _pageView(),),
        ],
      ),
    );
  }

  initTabData() {
    tabList = [
      new TabTitle('普通开户', 11),
      new TabTitle('链接开户', 10),
      new TabTitle('链接管理', 0),
    ];
  }

  @override
  void onRefreshData() {

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
        labelStyle: TextStyle(fontSize: 16.0),
        tabs: tabList.map((item) {
          return Tab(
            text: item.title,
          );
        }).toList(),
      ),
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
    if (index == 0) {
      //普通开户
      return OrdinaryOpenAccountCenterView();
    }
    if (index == 2) {
      //链接管理
      return smartRefreshBase(
        LinkManagerController(),
      );
    }

    if (index == 1) {
      //链接开户
      return LinkOpenAccountCenterView();
    }
    return OrdinaryOpenAccountCenterView();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//被重绘

}