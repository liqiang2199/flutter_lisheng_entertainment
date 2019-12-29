import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamAccountChangeHandler.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_account_change/TeamAccountChangeBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_account_change/TeamAccountChangeDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeAndEditNameView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/bridge/TeamAccountChangeInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 团队账变记录
class TeamAccountChangeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TeamAccountChangeController();
  }

}

class _TeamAccountChangeController extends BaseRefreshTabController<TeamAccountChangeController, TabTitle>
    implements SelectionTimeCallBack, TeamAccountChangeHandler,TeamAccountChangeInterface{

  String userName;
  int _page = 1;
  String _type = "0";
  String startTime;
  String endTime;

  List<TeamAccountChangeDataListBeen> dataAccountChangeList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();
    startTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    endTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    AgentService.instance.teamMoneyLog(this, userName, startTime, endTime, "$_page", _type);
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
          CommonView().commonLineChange(context,10.0),
          SelectionTimeAndEditNameView(this,this),
          new Expanded(child: _pageView(),),
        ],
      ),
    );
  }

  /// 类型:1=充值,2=提现,3=彩票游戏,4=活动,5=转账,6=资金修正,7=返点,8=团队分红,9=浮动工资 0=全部
  initTabData() {
    tabList = [
      new TabTitle('全部', 0),
      new TabTitle('充值', 1),
      new TabTitle('提现', 2),
      new TabTitle('彩票游戏', 3),
      new TabTitle('活动', 4),
      new TabTitle('转账', 5),
      new TabTitle('资金修正', 6),
      new TabTitle('返点', 7),
      new TabTitle('团队分红', 8),
      new TabTitle('浮动工资', 9),
    ];
  }

  @override
  void onRefreshData() {
    _page = 1;
    AgentService.instance.teamMoneyLog(this, userName, startTime, endTime, "$_page", _type);
  }

  @override
  void changeTabIndex(int pos){
    var title = tabList[pos];
    _type = "${title.id}";

    _page = 1;
    AgentService.instance.teamMoneyLog(this, userName, startTime, endTime, "$_page", _type);
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

                _recordTopView(dataAccountChangeList[i].username),
                _recordBottom(dataAccountChangeList[i]),

              ],
            ),
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: dataAccountChangeList.length,
    );
  }

  Widget _recordTopView(String name) {

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        children: <Widget>[

          new Text(
            name,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

        ],
      ),
    );
  }

  /// 1=充值,2=提现,3=彩票游戏,4=活动,5=转账,6=资金修正,7=返点,8=团队分红,9=浮动工资 0=全部
  String _getType(String type) {
    String typeTitle = "";
    switch(type) {
      case "1":
        typeTitle = "充值";
        break;
      case "2":
        typeTitle = "提现";
        break;
      case "3":
        typeTitle = "彩票游戏";
        break;
      case "4":
        typeTitle = "活动";
        break;
      case "5":
        typeTitle = "转账";
        break;
      case "6":
        typeTitle = "资金修正";
        break;
      case "7":
        typeTitle = "返点";
        break;
      case "8":
        typeTitle = "团队分红";
        break;
      case "9":
        typeTitle = "浮动工资";
        break;
    }

    return typeTitle;
  }

  Widget _recordBottom(TeamAccountChangeDataListBeen changeDataListBeen) {

    String type = _getType(changeDataListBeen.type);

    return new Offstage(
      /// 控制列表数据是否显示
      offstage: false,
      child: new Container(
        padding: EdgeInsets.only(bottom: 15.0,),
        child: new Column(
          children: <Widget>[
            CommonView().commonLine_NoMargin(context),

            new Container(
              padding: EdgeInsets.only(left: 15.0,right: 15.0,),
              child: new Column(
                children: <Widget>[
                  _recordBottomList("订单编号：", "${!TextUtil.isEmpty(changeDataListBeen.relation)? changeDataListBeen.relation : ""}"),
                  _recordBottomList("操作类型：", "$type"),
                  //_recordBottomList("业务类型：", "${!TextUtil.isEmpty(changeDataListBeen.relation)? changeDataListBeen.relation : ""}"),
                  _recordBottomList("下单时间：", "${!TextUtil.isEmpty(changeDataListBeen.createtime)? changeDataListBeen.createtime : ""}"),
                  _recordBottomList("变动金额：", "${!TextUtil.isEmpty(changeDataListBeen.money)? changeDataListBeen.money : ""}"),
                  _recordBottomList("金额：", "${!TextUtil.isEmpty(changeDataListBeen.all_money)? changeDataListBeen.all_money : ""}"),
                  _recordBottomList("备注：", "${!TextUtil.isEmpty(changeDataListBeen.remark)? changeDataListBeen.remark : ""}"),
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

  @override
  void selectionEndTime(String endTime) {
    this.endTime = endTime;
  }

  @override
  void selectionStartTime(String starTime) {
    this.startTime = starTime;
  }

  @override
  void setTeamAccountChangeBeen(TeamAccountChangeBeen dataBeen) {
    if (_page == 1) {
      dataAccountChangeList.clear();
    }
    dataAccountChangeList.addAll(dataBeen.data?.data);
    setState(() {

    });
  }

  @override
  void setTeamAccountChangeRecordUserName(String userName) {
    this.userName = userName;
    _page = 1;
    AgentService.instance.teamMoneyLog(this, userName, startTime, endTime, "$_page", _type);

  }

}