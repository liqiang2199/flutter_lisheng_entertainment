import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

//团队总预览
class TeamOverviewController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TeamOverviewController();
  }

}

class _TeamOverviewController extends BaseController<TeamOverviewController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, "团队总览"),
      body: new ListView(
        children: <Widget>[

          _topHead(),
          _teamDetail(),

        ],
      ),
    );
  }

  /// 个人中心 顶部 头像区域
  Widget _topHead() {

    return new Stack(
      children: <Widget>[

        _topHeadBg(),
        _topPersonalInfo()
      ],
    );
  }

  /// 顶部背景
  Widget _topHeadBg() {

    return Container(
      color: Color(ColorUtil.butColor),
      height: 100.0,
    );
  }

  /// 顶部信息
  Widget _topPersonalInfo() {

    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0,),
      height: 137.0,
      child: new Card(
        child: new Column(
          children: <Widget>[
            _headView(),
            CommonView().commonLine_NoMargin(),
            new Expanded(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    new Expanded(child: _personalBalance(),),
                    new Container(
                      color: Color(ColorUtil.lineColor),
                      margin: EdgeInsets.only(top: 70.0, bottom: 15.0),
                      width: 1.0,
                    ),
                    new Expanded(child: _personalReturnPoint(),),
                    new Container(
                      color: Color(ColorUtil.lineColor),
                      margin: EdgeInsets.only(top: 70.0, bottom: 15.0),
                      width: 1.0,
                    ),
                    new Expanded(child: _onLineNum(),),

                  ],
                ),
            ),

          ],
        ),
      ),
    );
  }

  /// 用户余额
  Widget _personalBalance() {

    return new Container(
      padding: EdgeInsets.only(bottom: 15.0,),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(
            "团队余额(元)",
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          new Text(
            "1000.00",
            style: TextStyle(
              fontSize: 20.0,
              color: Color(ColorUtil.butColor_FF9728),
            ),
          ),

        ],
      ),
    );
  }

  /// 返点
  Widget _personalReturnPoint() {

    return new Container(
      padding: EdgeInsets.only(bottom: 15.0,),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(
            "团队总人数",
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          new Text(
            "1000",
            style: TextStyle(
              fontSize: 20.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

        ],
      ),
    );
  }

  /// 在线数量
  Widget _onLineNum() {

    return new Container(
      padding: EdgeInsets.only(bottom: 15.0,),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(
            "在线人数",
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          new Text(
            "1000",
            style: TextStyle(
              fontSize: 20.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

        ],
      ),
    );
  }

  /// 顶部头像
  Widget _headView() {

    return new Center(
      child: new Container(
        padding: EdgeInsets.only(top: 10.0, left: 10.0,right: 5.0,bottom: 5.0,),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            new Image.asset(ImageUtil.imgHead, width: 48.0, height: 48.0,),
            SpaceViewUtil.pading_Left(10.0),
            new Expanded(
                child: new Text(
                  "用户昵称",
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                ),
            ),

            new Text(
              "个人余额：",
              style: new TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),

            new Text(
              "1000.00",
              style: new TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.butColor_FF9728),
              ),
            ),

          ],
        ),
      ),
    );
  }

  /// 团队详情
  Widget _teamDetail() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0,),
      child: new Card(
        child: new Column(
          children: <Widget>[

            new Container(
              child: new Align(
                child: new Text(
                  "团队详情",
                  style: TextStyle(
                    color: Color(ColorUtil.textColor_333333),
                    fontSize: 14.0,
                  ),
                ),
              ),
              height: 48.0,
            ),
            CommonView().commonLine_NoMargin(),
            _teamDetailListItem("充值金额"),
            CommonView().commonLine_NoMargin(),
            _teamDetailListItem("取款金额"),
            CommonView().commonLine_NoMargin(),
            _teamDetailListItem("消费金额"),
            CommonView().commonLine_NoMargin(),
            _teamDetailListItem("派奖金额"),

          ],

        ),
      ),
    );

  }

  Widget _teamDetailListItem(String itemTitle) {

    return new Container(
      height: 48.0,
      padding: EdgeInsets.only(left: 13.0, right: 13.0,),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Align(
              child: new Text(
                itemTitle,
                style: TextStyle(
                  color: Color(ColorUtil.textColor_333333),
                  fontSize: 14.0,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),

          new Text(
            "0.0000",
            style: TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

        ],
      ),
    );
  }

}