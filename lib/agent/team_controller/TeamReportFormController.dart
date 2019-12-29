import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeAndEditNameView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 团队报表
class TeamReportFormController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TeamReportFormController();
  }

}

class _TeamReportFormController extends BaseRefreshController<TeamReportFormController> with SelectionTimeCallBack{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.teamReportFrom),
      body: new Column(
        children: <Widget>[

          //SelectionTimeAndEditNameView(this),

          new Expanded(child: smartRefreshBase(
            _listReportFromItem(),
          ),),

        ],
      ),
    );
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

                _recordTopView(),
                _listReportListDetail(),

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

  /// 报表列表详情
  Widget _listReportListDetail() {

    return new Column(
      children: <Widget>[

        CommonView().commonLine_NoMargin(context),
        new Container(
          padding: EdgeInsets.all(15.0,),
          child: new Column(
            children: <Widget>[
              _listDetail("类型：","余额："),
              _listDetail("有效会员数：","充值："),
              _listDetail("提现：","投注额："),
              _listDetail("奖金：","返点："),
              _listDetail("活动：","总盈亏："),
            ],
          ),
        ),

      ],
    );
  }

  Widget _listDetail(String titleLeft, String rightTitle) {

    return new Container(
      child: Row(
        children: <Widget>[

          new Expanded(child: _listDetailItem(titleLeft,"1111"),),
          new Expanded(child: _listDetailItem(rightTitle,"2222"),),


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
  void selectionEndTime(String endTime) {
  }

  @override
  void selectionStartTime(String starTime) {
  }

}