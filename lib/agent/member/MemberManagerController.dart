import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/agent/net/MemberManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_member/MemberManagerBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_member/MemberManagerDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/ScreenTwoEditView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/ScreenCallBack.dart';

/// 团队报表
class MemberManagerController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MemberManagerController();
  }

}

class _MemberManagerController extends BaseRefreshController<MemberManagerController> with ScreenCallBack implements MemberManagerHandler{

  String userName;
  int page = 1;

  List<MemberManagerDataListBeen> managerList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AgentService.instance.userlist(this, userName, "$page");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.agentMemberManager),
      body: new Column(
        children: <Widget>[

          ScreenTwoEditView(this),

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
    AgentService.instance.userlist(this, userName, "$page");
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
              //
            },
            child: new Column(
              children: <Widget>[

                _recordTopView(managerList[i].username),
                _listReportListDetail(managerList[i]),
                CommonView().commonLine_NoMargin(context),
                _listDetailBottom("最后登陆时间：","${!TextUtil.isEmpty(managerList[i].login_time)? managerList[i].login_time : "未登录"}"),

              ],
            ),
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: managerList.length,
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
              color: Color(ColorUtil.textColor_FF8814),
            ),
          ),

        ],
      ),
    );
  }

  /// 报表列表详情
  Widget _listReportListDetail(MemberManagerDataListBeen managerDataListBeen) {

    return new Column(
      children: <Widget>[

        CommonView().commonLine_NoMargin(context),
        new Container(
          padding: EdgeInsets.all(15.0,),
          child: new Column(
            children: <Widget>[
              _listDetail("类型：","代理","用户余额：","${managerDataListBeen.all_money}", true),
              _listDetail("团队余额：","${managerDataListBeen.all_subsidy_money}","返点：","${managerDataListBeen.ratio}", true),
              _listDetail("操作：","","", "",false),
            ],
          ),
        ),

      ],
    );
  }

  Widget _listDetail(String titleLeft, String leftContent, String rightTitle, String rightContent, var isVisibility) {

    return new Container(
      child: Row(
        children: <Widget>[

          new Expanded(child: _listDetailItem(titleLeft,leftContent),),
          new Expanded(
            child: new Visibility(
              visible: isVisibility,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: _listDetailItem(rightTitle,rightContent),
            ),
          ),


        ],
      ),
    );
  }

  Widget _listDetailBottom(String titleLeft, String content) {

    return new Container(
      height: 40.0,
      padding: EdgeInsets.only(left: 10.0,),
      child: Row(
        children: <Widget>[

          _listDetailItem(titleLeft, content)

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
  void screenEdit() {

  }

  @override
  void screenEditLast() {

  }

  @override
  void setEditUserName(String name) {
    userName = name;
    onRefreshData();
  }

  @override
  void setMemberManagerBeen(MemberManagerBeen dataBeen) {

    if (page == 1) {
      managerList.clear();
    }

    managerList?.addAll(dataBeen.data.userlist);
    setState(() {

    });
  }

}