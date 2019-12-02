import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/ScreenTwoEditView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/ScreenCallBack.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 团队报表
class MemberManagerController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MemberManagerController();
  }

}

class _MemberManagerController extends BaseRefreshController<MemberManagerController> with ScreenCallBack{
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
                CommonView().commonLine_NoMargin(),
                _listDetailBottom("最后登陆时间：","2019-11-29 12:00:00"),

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
              color: Color(ColorUtil.textColor_FF8814),
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

        CommonView().commonLine_NoMargin(),
        new Container(
          padding: EdgeInsets.all(15.0,),
          child: new Column(
            children: <Widget>[
              _listDetail("类型：","余额：", true),
              _listDetail("团队余额：","返点：", true),
              _listDetail("操作：","投注额：", false),
            ],
          ),
        ),

      ],
    );
  }

  Widget _listDetail(String titleLeft, String rightTitle, var isVisibility) {

    return new Container(
      child: Row(
        children: <Widget>[

          new Expanded(child: _listDetailItem(titleLeft,"1111"),),
          new Expanded(
            child: new Visibility(
              visible: isVisibility,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: _listDetailItem(rightTitle,"2222"),
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
    // TODO: implement screenEdit
  }

  @override
  void screenEditLast() {
    // TODO: implement screenEditLast
  }

}