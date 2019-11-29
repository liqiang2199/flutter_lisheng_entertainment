import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 账变记录
class AccountChangeRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountChangeRecordController();
  }

}

class _AccountChangeRecordController extends BaseRefreshTabController<AccountChangeRecordController, TabTitle>
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
      appBar: CommonView().commonAppBar(context, StringUtil.personalAccountChangeRecord),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          SelectionTimeView(this),
          new Expanded(child: _pageView(),),
        ],
      ),
    );
  }

  initTabData() {
    tabList = [
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

    return TabBar(
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
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: new GestureDetector(
          onTap: () {
            //个人投注记录
          },
          child: new Column(
            children: <Widget>[

              buildItemWidget(context, i),

            ],
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: items.length,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      return new Column(
        children: <Widget>[

          _recordBottomList(),
          CommonView().commonLine_NoMargin(),

        ],
      );
    }
  }

  Widget _recordTopView() {

    return new Container(

      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派奖",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF), width: 1.0,), flex: 0,),

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派奖",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),
          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF), width: 1.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF), width: 1.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

        ],
      ),
    );
  }


  Widget _recordBottomList() {

    return new Container(

      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派奖",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.lineColor), width: 1.0,), flex: 0,),

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派奖",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          new Expanded(child: new Container(color: Color(ColorUtil.lineColor), width: 1.0,), flex: 0,),
          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                ),
              ),
            ),
          ),
          new Expanded(child: new Container(color: Color(ColorUtil.lineColor), width: 1.0,), flex: 0,),
          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "已派",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}