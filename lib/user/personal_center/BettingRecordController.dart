import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/GetBettingRecordListHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/UserTimeAndEditAndFindChoiceView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/bridge/UserBettingRecordScreenInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

import 'BettingRecordDetailController.dart';

/// 个人投注记录
class BettingRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BettingRecordController();
  }

}

class _BettingRecordController extends BaseRefreshTabController<BettingRecordController, TabTitle>
    implements GetBettingRecordListHandler,SelectionTimeCallBack,UserBettingRecordScreenInterface{

  String status;
  String endTime = "";
  String startTime = "";

  List<GetBettingRecordDataListBeen> recordDataList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();
    startTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    endTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    UserService.instance.bettingList(this, "0", status, startTime, endTime);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.personalBettingRecord),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          UserTimeAndEditAndFindChoiceView(this,this),
          new Expanded(child: _pageView(),),
        ],
      ),
    );
  }

  initTabData() {
    tabList = [
      new TabTitle('全部状态', 0),
      new TabTitle('待开奖', 1),
      new TabTitle('中奖', 2),
      new TabTitle('未中奖', 3),

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
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,),
        child: Card(
          child: new GestureDetector(
            onTap: () {
              //个人投注记录

            },
            child: new Column(
              children: <Widget>[

                _recordTopView(recordDataList[i].status),
                _recordBottom(recordDataList[i]),

              ],
            ),
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: recordDataList.length,
    );
  }

  Widget _recordTopView(String id) {
    ///1=待开奖,2=中奖,3=未中奖
    int colorText = ColorUtil.textColor_333333;
    String textContent = "";
    switch(id) {
      case "1":
        //待开奖
        textContent = "待开奖";
        colorText = ColorUtil.butColor;
        break;
      case "2":
        //待开奖
        textContent = "中奖";
        colorText = ColorUtil.bgColor_E7242C;
        break;
      case "3":
        //待开奖
        textContent = "未中奖";
        colorText = ColorUtil.textColor_888888;
        break;
    }

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        children: <Widget>[

          new Text(
            SpUtil.getString(Constant.USER_NAME),
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

          new Expanded(
            child: new Align(
              alignment: Alignment.centerRight,
              child: new Text(
                textContent,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(colorText),
                ),
              ),
            ),
          ),

          Image.asset(ImageUtil.imgRightArrow, width: 16.0, height: 16.0,),

        ],
      ),
    );
  }

  Widget _recordBottom(GetBettingRecordDataListBeen recordDataListBeen) {

    String qs = recordDataListBeen.pre_draw_issue;
    if (!TextUtil.isEmpty(qs) && qs.length >= 4) {
      var startQs = qs.substring(0, qs.length -4);
      var endQs = qs.substring(qs.length -4, qs.length);
      qs = "$startQs-$endQs";
    }

    return new Offstage(
      /// 控制列表数据是否显示
      offstage: false,
      child: new GestureDetector(
        onTap: () {
          // 数据显示 投注记录详情
          //Navigator.pushNamed(context, RouteUtil.bettingRecordDetailController);
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new BettingRecordDetailController(recordDataListBeen);
          }));
        },
        child: new Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0,),
          child: new Column(
            children: <Widget>[
              CommonView().commonLine_NoMargin(context),
              _recordBottomList("订单编号：", "${recordDataListBeen.ordercode}"),
              _recordBottomList("彩种/玩法：", "${recordDataListBeen.lottery_name}/${!TextUtil.isEmpty(recordDataListBeen.play) ? recordDataListBeen.play : ""}"),
              _recordBottomList("期号：", "$qs"),
              _recordBottomList("下单时间：", "${!TextUtil.isEmpty(recordDataListBeen.createtime) ? recordDataListBeen.createtime : ""}"),
              _recordBottomList("注数/倍数：", "${recordDataListBeen.multiple}/${recordDataListBeen.num}"),
              _recordBottomList("金额：", "${!TextUtil.isEmpty(recordDataListBeen.xz_money) ? recordDataListBeen.xz_money  : ""}元"),
              _recordBottomList("奖金：", "${!TextUtil.isEmpty(recordDataListBeen.jg_money) ? recordDataListBeen.jg_money : ""}元"),
            ],
          ),
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

  @override
  void changeTabIndex(int pos) {
    status = "${tabList[pos].id}";
    Future.delayed(new Duration(milliseconds: 500)).then((value) {
      UserService.instance.bettingList(this, "0", status, startTime, endTime);
    });
  }

  @override
  void setGetBettingRecordData(GetBettingRecordBeen recordDataBeen) {
    recordDataList = recordDataBeen.data.data;
    setState(() {

    });
  }

  @override
  void selectionEndTime(String endTime) {
    this.endTime = endTime;
  }

  @override
  void selectionStartTime(String starTime) {
    this.startTime = starTime;
  }

  @override
  void setScreenData(String cpType, String issueNum) {
    UserService.instance.bettingList(this, issueNum, status, startTime, endTime);
  }

  @override
  void getOrderOnceResult(bool result) {

  }

}