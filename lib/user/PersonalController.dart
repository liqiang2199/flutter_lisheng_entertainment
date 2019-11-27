import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 个人中心
class PersonalController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalController();
  }

}

class _PersonalController extends State<PersonalController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.personalCenter),
      body: new ListView(
        children: <Widget>[

          _topHead(),
          _rightModifyArrowView(),
          _rightRecordArrowView(),

        ],
      ),
    );
  }

  /// 个人中心 顶部 头像区域
  Widget _topHead() {

    return new Stack(
      children: <Widget>[

        _topHeadBg(),
        _topPersonalInfo(),
        _headView(),

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
            "余额(元)",
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
            "返点",
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          new Text(
            "1000.0",
            style: TextStyle(
              fontSize: 20.0,
              color: Color(ColorUtil.textColor_1396DA),
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
        padding: EdgeInsets.only(top: 10.0,),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Image.asset(ImageUtil.imgHead, width: 71.0, height: 71.0,),
            new Text(
              "用户昵称",
              style: new TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),


          ],
        ),
      ),
    );
  }

  /// 密码修改
  Widget _rightModifyArrowView() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, ),
      child: new Card(
        color: Colors.white,
        //z轴的高度，设置card的阴影
        elevation: 5.0,
        child: new Column(
          children: <Widget>[
            _getRightArrowView(StringUtil.personalChangeLoginPassword, ImageUtil.imgModifyPassWord),
            CommonView().commonLine(),
            _getRightArrowView(StringUtil.personalChangeCashPassword, ImageUtil.imgCashPassword),

          ],
        ),
      ),
    );
  }

  /// 用户操作记录
  Widget _rightRecordArrowView() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0,),
      child: new Card(
        color: Colors.white,
        //z轴的高度，设置card的阴影
        elevation: 5.0,
        child: new Column(
          children: <Widget>[
            _getRightArrowView(StringUtil.personalBank, ImageUtil.imgBank),
            CommonView().commonLine(),
            _getRightArrowView(StringUtil.personalLotteryReport, ImageUtil.imgLotteryReport),
            CommonView().commonLine(),
            _getRightArrowView(StringUtil.personalBettingRecord, ImageUtil.imgBettingRecord),
            CommonView().commonLine(),
            _getRightArrowView(StringUtil.personalAccountChangeRecord, ImageUtil.imgAccountChangeRecord),

          ],
        ),
      ),
    );
  }

  _getRightArrowView(String title, String icon) {

    return new ListStateItemView(
      title,
      isSwitch: false,
      isRightArrow: true,
      leftIcon: icon,
    );
  }

}