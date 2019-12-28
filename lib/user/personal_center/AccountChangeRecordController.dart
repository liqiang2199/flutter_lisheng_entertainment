import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/AccountChangeRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 账变记录
class AccountChangeRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountChangeRecordController();
  }

}

class _AccountChangeRecordController extends BaseRefreshTabController<AccountChangeRecordController, TabTitle>
    implements SelectionTimeCallBack, AccountChangeRecordHandler{

  String type = "0";
  String startTime = "0";
  String endTime = "0";
  int page = 1;

  List<AccountChangeRecordDataListBeen> accountRecordList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();

    UserService.instance.moneyLog(this, "0", page, startTime, endTime);
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

  /// 1=充值,2=提现,3=彩票游戏,4=活动,5=转账,6=资金修正,7=返点,8=团队分红,9=浮动工资 0为全部）
  initTabData() {
    tabList = [
      new TabTitle('彩票游戏', 3),
      new TabTitle('活动', 4),
      new TabTitle('转账', 5),
      new TabTitle('修正资金', 6),
      new TabTitle('充值', 1),
      new TabTitle('提现', 2),
      new TabTitle('返点', 7),
      new TabTitle('团队分红', 8),
      new TabTitle('浮动工资', 9)
    ];
  }

  @override
  void onRefreshData() {
    page = 1;
    UserService.instance.moneyLog(this, type, page, startTime, endTime);
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
          type = "${tabList[index].id}";
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

  /// 个人账变信息 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0,),
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
      itemCount: accountRecordList.length + 1,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      if (index > accountRecordList.length ) {
        return new Container();
      }
      var item = accountRecordList[index - 1];
      return new Column(
        children: <Widget>[

          _recordBottomList(item.createtime, item.money, item.all_money, item.remark),
          CommonView().commonLine_NoMargin(context),

        ],
      );
    }
  }

  Widget _recordTopView() {

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "时间",
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

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "变动金额",
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
          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "余额",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "备注",
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


  Widget _recordBottomList(String time, String bMoney, String money, String remark) {

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
//                padding: EdgeInsets.all(15.0),
                child: new Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.lineColor),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
//                padding: EdgeInsets.all(15.0),
                child: new Text(
                  bMoney,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          new Expanded(child: new Container(color: Color(ColorUtil.lineColor),
            width: 1.0, height: 50.0,), flex: 0,),
          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
//                padding: EdgeInsets.all(15.0),
                child: new Text(
                  money,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                ),
              ),
            ),
          ),
          new Expanded(child: new Container(color: Color(ColorUtil.lineColor),
            width: 1.0, height: 50.0,), flex: 0,),
          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
//                padding: EdgeInsets.all(15.0),
                child: new Text(
                  remark,
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

  @override
  void selectionEndTime(String starTime) {
    this.startTime = starTime;
  }

  @override
  void selectionStartTime(String endTime) {
    this.endTime = endTime;
    UserService.instance.moneyLog(this, type, page, startTime, endTime);
  }

  @override
  void changeTabIndex(int pos) {
    var tabListD = tabList[pos];
    type = "${tabListD.id}";
    Future.delayed(Duration(milliseconds: 1000)).then((value){
      UserService.instance.moneyLog(this, type, page, startTime, endTime);
    });

  }

  @override
  void setAccountChangeRecord(AccountChangeRecordBeen changeRecordBeen) {
    if (page == 1) {
      accountRecordList.clear();
    }
    items = changeRecordBeen.data.data;
    accountRecordList.addAll(changeRecordBeen.data.data);
    setState(() {

    });
  }

}