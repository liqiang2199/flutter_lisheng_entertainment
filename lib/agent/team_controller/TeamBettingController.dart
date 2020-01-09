import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_betting/TeamBettingBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_betting/TeamBettingDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/TimeAndEditAndFindChoiceView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/bridge/TeamBettingScreenInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 团队投注
class TeamBettingController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TeamBettingController();
  }

}

class _TeamBettingController extends BaseRefreshTabController<TeamBettingController, TabTitle>
    implements SelectionTimeCallBack, TeamBettingHandler, TeamBettingScreenInterface{

  String _userName;
  String _time;
  String _lotteryId;
  String _qs;
  //int _page = 1;
  String _status = "0";

  String startTime;
  String endTime;

  List<TeamBettingDataListBeen> teamBettingList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();

    //AgentService.instance.teamBettingList(this, _userName, startTime, endTime, _lotteryId, _qs, "$page", _status, limit);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.teamBettingRecord),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          CommonView().commonLineChange(context,10.0),
          TimeAndEditAndFindChoiceView(this, this),
          new Expanded(child: _tabView(),),
        ],
      ),
    );
  }

  /// 0 位全部 1=待开奖,2=中奖,3=未中奖,4=结算错误
  initTabData() {
    tabList = [
      new TabTitle('全部状态', 0),
      new TabTitle('待开奖', 1),
      new TabTitle('中奖', 2),
      new TabTitle('未中奖', 3),
      new TabTitle('结算错误', 4),
    ];
  }

  @override
  void onRefreshData() {
    page = 1;
    AgentService.instance.teamBettingList(this, _userName, startTime, endTime, _lotteryId, _qs, "$page", _status, limit);
  }

  @override
  void onLoadingDataRefresh() {
    AgentService.instance.teamBettingList(this, _userName, startTime, endTime, _lotteryId, _qs, "$page", _status, limit);
  }

  @override
  void changeTabIndex(int pos){
    var tabIndexId = tabList[pos];
    _status = "${tabIndexId.id}";
    page = 1;
    AgentService.instance.teamBettingList(this, _userName, startTime, endTime, _lotteryId, _qs, "$page", _status, limit);
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
//        return smartRefreshBase(
//          _listRecordItem(),
//        );
//      },
//    );
//  }

  Widget _tabView() {

    return new TabBarView(
        controller: this.mTabController,
        children: _tabListView()
    );
  }

  List<Widget> _tabListView() {
    List<Widget> tabViewList = new List();

    for (int i = 0; i < tabList.length; i++) {
      tabViewList.add(smartRefreshBase(
        _listRecordItem(),
      ));
    }
    return tabViewList;
  }

  @override
  bool isUserTabPage() {
    return false;
  }

  /// 个人投注信息 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        color: Colors.white,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: new GestureDetector(
          onTap: () {
            //
          },
          child: new Column(
            children: <Widget>[
              buildItemWidget(context,i),

            ],
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: teamBettingList.length,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      return new Column(
        children: <Widget>[

          _recordBottomList(teamBettingList[index]),
          CommonView().commonLine_NoMargin(context)

        ],
      );
    }
  }

  ///  记录列表
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
                  "账户",
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
                  "彩种",
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
                  "投注金额",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF)
            , width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "状态",
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


  Widget _recordBottomList(TeamBettingDataListBeen listBeen) {

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
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  listBeen.username,
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
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  "${listBeen.lottery_id}",
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
            width: 1.0, height: 50,), flex: 0,),
          new Expanded(
            flex: 3,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  listBeen.xz_money,
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
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  listBeen.remark,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

        ],
      ),
    );
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
  void setTeamBettingBeen(TeamBettingBeen dataBeen) {
    if (page == 1) {
      teamBettingList.clear();
      count = dataBeen.data.count;
      TeamBettingDataListBeen teamBettingDataListBeen = new TeamBettingDataListBeen();
      teamBettingList.add(teamBettingDataListBeen);
    }

    teamBettingList.addAll(dataBeen.data.data);
    setState(() {

    });
  }

  @override
  void setTeamBettingScreenData(String userName, String cpType, String qs) {

    _userName = userName;
    _lotteryId = cpType;
    _qs = qs;

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      AgentService.instance.teamBettingList(this, _userName, startTime, endTime, _lotteryId, _qs, "$page", _status, limit);
    });

  }

}