import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_account_change/TeamAccountChangeBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_account_change/TeamAccountChangeDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

import 'net/TeamAccountChangeHandler.dart';

/// 提款记录
class WithdrawalRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WithdrawalRecordController();
  }

}

class _WithdrawalRecordController extends BaseRefreshController<WithdrawalRecordController> with SelectionTimeCallBack implements TeamAccountChangeHandler{

  String _startTime;
  String _endTime;
  //int _page= 1;

  List<TeamAccountChangeDataListBeen> dataWithdrawList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // "2" 固定为2 提现记录
    //AgentService.instance.teamMoneyLog(this, "", _startTime, _endTime, "$_page", "2");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new  Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.agentWithdrawalRecord),
      body: new Column(
        children: <Widget>[

          SelectionTimeView(this),
          new Expanded(child: smartRefreshBase(
            _listRecordItem(),
          ),),

        ],
      ),
    );
  }

  @override
  void onRefreshData() {

    page = 1;
    AgentService.instance.teamMoneyLog(this, "", _startTime, _endTime, "$page", "2", limit);
  }
  @override
  void onLoadingDataRefresh() {
    AgentService.instance.teamMoneyLog(this, "", _startTime, _endTime, "$page", "2", limit);
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
      itemCount: dataWithdrawList.length,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      return new Column(
        children: <Widget>[

          _recordBottomList(dataWithdrawList[index]),
          CommonView().commonLine_NoMargin(context),

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
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(

                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "提款时间",
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
            flex: 4,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "金额（元）",
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
            flex: 4,
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
                  textAlign: TextAlign.center,
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

        ],
      ),
    );
  }


  Widget _recordBottomList(TeamAccountChangeDataListBeen dataListBeen) {

    String stateStr = "";
    //1=待审核,2=通过,3=未通过 0为全部
    var status = dataListBeen.status;
    switch(status) {
      case "1":
        stateStr = "待审核";
        break;
      case "2":
        stateStr = "通过";
        break;
      case "3":
        stateStr = "未通过";
        break;
    }

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  dataListBeen.createtime,
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
            flex: 4,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  dataListBeen.money,
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
            flex: 4,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  stateStr,
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
    _endTime = endTime;
    onRefreshData();
  }

  @override
  void selectionStartTime(String starTime) {
    _startTime = starTime;
  }

  @override
  void setTeamAccountChangeBeen(TeamAccountChangeBeen dataBeen) {

    if (page == 1) {
      dataWithdrawList?.clear();
      TeamAccountChangeDataListBeen dataListBeen = new TeamAccountChangeDataListBeen(0,0,"","","","","","","","");
      dataWithdrawList?.add(dataListBeen);
    }
    dataWithdrawList.addAll(dataBeen.data.data);

    setState(() {

    });

  }

}