import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_recharge/TeamRechargeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_recharge/TeamRechargeRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

import 'net/TeamRechargeRecordHandler.dart';

/// 充值记录
class RechargeRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RechargeRecordController();
  }

}

class _RechargeRecordController extends BaseRefreshController<RechargeRecordController>
    with SelectionTimeCallBack implements TeamRechargeRecordHandler{

  String startTime = "";
  String endTime = "";
  String userName = "";
  int page = 1;

  List<TeamRechargeRecordDataListBeen> rechargeRecordList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AgentService.instance.rechargeList(this, userName, "$page", startTime, endTime);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new  Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.agentRechargeRecord),
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
    AgentService.instance.rechargeList(this, userName, "$page", startTime, endTime);
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
      itemCount: rechargeRecordList.length,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      return new Column(
        children: <Widget>[

          _recordBottomList(rechargeRecordList[index]),
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
                  "充值时间",
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


        ],
      ),
    );
  }


  Widget _recordBottomList(TeamRechargeRecordDataListBeen recordDataListBeen) {

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
                  recordDataListBeen.createtime,
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
                  recordDataListBeen.money,
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
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      AgentService.instance.rechargeList(this, userName, "$page", startTime, endTime);
    });
  }

  @override
  void selectionStartTime(String starTime) {
    this.startTime = starTime;
  }

  @override
  void setTeamRechargeRecordBeen(TeamRechargeRecordBeen dataBeen) {

    if (page == 1) {
      rechargeRecordList?.clear();
    }
    rechargeRecordList.addAll(dataBeen.data.userlist);
    setState(() {

    });
  }

}