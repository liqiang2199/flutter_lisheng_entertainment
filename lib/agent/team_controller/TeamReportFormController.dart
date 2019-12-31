import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamReportFormHandler.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_report_form/TeamReportFormBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_report_form/TeamReportFormDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/ScreenEditNameView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeAndEditNameView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/bridge/EditNameInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 团队报表
class TeamReportFormController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TeamReportFormController();
  }

}

class _TeamReportFormController extends BaseRefreshController<TeamReportFormController>
    with EditNameInterface implements TeamReportFormHandler{

  List<TeamReportFormDataListBeen> dataReport = new List();

  int page = 1;
  String _userName;
  String _userId = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    Map args = ModalRoute.of(context).settings.arguments;
//    if (args != null) {
//      print("arg= $args");
//      if (args.containsKey("userIdDL")) {
//
//        args.forEach((k,v){
//          if (k.toString() == "userIdDL") {
//            _userId = v as String;
//          }
//
//        });
//      }
//      print("当前userID $_userId");
//    }

    AgentService.instance.teamList(this,"$page", _userName, _userId);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.teamReportFrom),
      body: new Column(
        children: <Widget>[

          ScreenEditNameView(this),

          new Expanded(child: smartRefreshBase(
            _listReportFromItem(),
          ),),

        ],
      ),
    );
  }

  @override
  void onRefreshData() {
    page = 1;
    AgentService.instance.teamList(this,"$page", _userName, _userId);
  }

  /// 团队报表 信息 列表
  Widget _listReportFromItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,),
        child: Card(
          child: new GestureDetector(
            onTap: () {
              // 根据 会员人数来判断 是否还有下级
              var dataReportData = dataReport[i];
              var dataReportDataNum = dataReportData.userNum;

              if (dataReportDataNum != null) {
                if (dataReportDataNum > 0) {
                  // 有下级
                  try {
                    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
                      builder: (BuildContext context) => TeamReportFormController(),
                      settings: RouteSettings(
                        arguments: {"userIdDL" : "${dataReportData.id}"},
                      ),
                    ), (//跳转到主页
                        // ignore: unrelated_type_equality_checks
                        Route route) => route == RouteUtil.teamReportFormController);
                  } catch (e) {

                  }

                } else {
                  _showTip();
                }
              } else {
                _showTip();
              }
            },
            child: new Column(
              children: <Widget>[

                _recordTopView(dataReport[i].username),
                _listReportListDetail(dataReport[i]),

              ],
            ),
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: dataReport.length,
    );
  }

  Future<bool> _showTip() {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('确定当前代理无下级?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消'),
                  onPressed: () => Navigator.pop(context, false),
                ),
//                FlatButton(
//                  child: Text('确定'),
//                  onPressed: () => {
//                    Navigator.pop(context, true)
//                  },
//                ),
              ],
            ));
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

  /// 报表列表详情
  Widget _listReportListDetail(TeamReportFormDataListBeen dataListBeen) {

    return new Column(
      children: <Widget>[

        CommonView().commonLine_NoMargin(context),
        new Container(
          padding: EdgeInsets.all(15.0,),
          child: new Column(
            children: <Widget>[
              _listDetail("类型：", "代理","余额：", "${!TextUtil.isEmpty(dataListBeen.all_money) ? dataListBeen.all_money : "0.00"}"),

              _listDetail("有效会员数：",  "${!TextUtil.isEmpty("${dataListBeen.userNum}") ? dataListBeen.userNum : "0"}"
                  ,"充值：",  "${!TextUtil.isEmpty(dataListBeen.czMoney) ? dataListBeen.czMoney : "0.00"}"),

              _listDetail("提现：",  "${!TextUtil.isEmpty(dataListBeen.tcMoney) ? dataListBeen.tcMoney : "0.00"}"
                  ,"投注额：",  "${!TextUtil.isEmpty(dataListBeen.tzMoney) ? dataListBeen.tzMoney : "0"}"),

              _listDetail("奖金：",  "${!TextUtil.isEmpty(dataListBeen.jgMoney) ? dataListBeen.jgMoney : "0.00"}"
                  ,"返点：",  "${!TextUtil.isEmpty(dataListBeen.fdMoney) ? dataListBeen.fdMoney : "0.00"}"),

              _listDetail("活动：",  "${!TextUtil.isEmpty(dataListBeen.hdMoney) ? dataListBeen.hdMoney : "0.00"}"
                  ,"总盈亏：",  "${!TextUtil.isEmpty(dataListBeen.ykMoney) ? dataListBeen.ykMoney : "0.00"}"),
            ],
          ),
        ),

      ],
    );
  }

  Widget _listDetail(String titleLeft, String leftContent, String rightTitle, String rightContent) {

    return new Container(
      child: Row(
        children: <Widget>[

          new Expanded(child: _listDetailItem(titleLeft,leftContent),),
          new Expanded(child: _listDetailItem(rightTitle,rightContent),),


        ],
      ),
    );
  }

  Widget _listDetailItem(String titleItem, var contentItem) {

    return new Row(
      children: <Widget>[

        new Text(
          titleItem,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(ColorUtil.textColor_888888),
          ),
        ),

        new Text(
          contentItem,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(ColorUtil.textColor_333333),
          ),
        ),

      ],
    );
  }

  @override
  void setEditUserName(String name) {
    _userName = name;
    page = 1;
    AgentService.instance.teamList(this,"$page", _userName, _userId);
  }


  @override
  void setTeamReportFormBeen(TeamReportFormBeen dataBeen) {

    if (page == 1) {
      dataReport?.clear();
    }

    dataReport.addAll(dataBeen.data.data);
    setState(() {

    });

  }


}