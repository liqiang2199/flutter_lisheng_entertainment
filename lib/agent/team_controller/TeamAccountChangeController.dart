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

/// 账变记录
class TeamAccountChangeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TeamAccountChangeController();
  }

}

class _TeamAccountChangeController extends BaseRefreshTabController<TeamAccountChangeController, TabTitle>
    implements SelectionTimeCallBack{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();
  }

  @override
  void selectionEndStartTime() {
    // TODO: implement selectionEndStartTime
  }

  @override
  void selectionTimeStartTime() {
    // TODO: implement selectionTimeStartTime
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.teamAccountChangeRecord),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          CommonView().commonLineChange(10.0),
          SelectionTimeAndEditNameView(this),
          new Expanded(child: _pageView(),),
        ],
      ),
    );
  }

  initTabData() {
    tabList = [
      new TabTitle('全部', 11),
      new TabTitle('彩票游戏', 10),
      new TabTitle('活动', 0),
      new TabTitle('转账', 1),
      new TabTitle('修正资金', 2),
      new TabTitle('充值', 3),
      new TabTitle('提现', 4)
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
        return smartRefreshBase(
          _listRecordItem(),
        );
      },
    );
  }

  /// 个人投注信息 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
        child: new Card(
          child: new GestureDetector(
            onTap: () {
              //
            },
            child: new Column(
              children: <Widget>[

                _recordTopView(),
                _recordBottom(),

              ],
            ),
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: items.length,
    );
  }

  Widget _recordTopView() {

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        children: <Widget>[

          new Text(
            "jx5188",
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

        ],
      ),
    );
  }

  Widget _recordBottom() {

    return new Offstage(
      /// 控制列表数据是否显示
      offstage: false,
      child: new Container(
        padding: EdgeInsets.only(bottom: 15.0,),
        child: new Column(
          children: <Widget>[
            CommonView().commonLine_NoMargin(),

            new Container(
              padding: EdgeInsets.only(left: 15.0,right: 15.0,),
              child: new Column(
                children: <Widget>[
                  _recordBottomList("订单编号：", "11111"),
                  _recordBottomList("操作类型：", "11111"),
                  _recordBottomList("业务类型：", "11111"),
                  _recordBottomList("下单时间：", "11111"),
                  _recordBottomList("变动金额：", "11111"),
                  _recordBottomList("金额：", "11111"),
                  _recordBottomList("备注：", "11111"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordBottomList(String name, String content) {

    return new Container(
      padding: EdgeInsets.only(top: 5.0),
      child: new Row(
        children: <Widget>[
          new Text(
            name,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          SpaceViewUtil.pading_Left(5.0),

          new Text(
            content,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

        ],
      ),
    );
  }

}