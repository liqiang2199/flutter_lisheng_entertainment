import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
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

class _PersonalController extends BaseController<PersonalController> {
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
            SpUtil.getString(Constant.ALL_MONEY),
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
            SpUtil.getString(Constant.USER_RATIO),
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

            CommonView().clipHeadImg(),
            new Text(
              SpUtil.getString(Constant.USER_NAME),
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
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.personalSetCashPassword, ImageUtil.imgCashPassword),
            CommonView().commonLine(context),
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
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.personalLotteryReport, ImageUtil.imgLotteryReport),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.personalBettingRecord, ImageUtil.imgBettingRecord),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.personalAccountChangeRecord, ImageUtil.imgAccountChangeRecord),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.agentWithdrawalRecord, ImageUtil.imgAgentWithdrawalRecord),

          ],
        ),
      ),
    );
  }

  _getRightArrowView(String title, String icon) {

    return new GestureDetector(
      onTap: () {
        //点击
        switch(title) {
          case StringUtil.personalChangeLoginPassword:
            //修改登录密码
            Navigator.pushNamed(context, RouteUtil.modifyLoginPasswordController);
            break;
          case StringUtil.personalChangeCashPassword:
            if(!_readIsPayPassword()) {
              showToast("请先设置资金密码");
              Navigator.pushNamed(context, RouteUtil.setCapitalPasswordController);
              return;
            }
            //修改资金密码
            Navigator.pushNamed(context, RouteUtil.modifyCapitalPasswordController);
            break;
          case StringUtil.personalSetCashPassword:
            if(_readIsPayPassword()) {
              showToast("无需重复设置资金密码");
              return;
            }
            //设置资金密码
            Navigator.pushNamed(context, RouteUtil.setCapitalPasswordController);
            break;
          case StringUtil.personalBettingRecord:
            //修改资金密码
            Navigator.pushNamed(context, RouteUtil.bettingRecordController);
            break;
          case StringUtil.personalLotteryReport:
            //修改资金密码
            Navigator.pushNamed(context, RouteUtil.lotteryReportController);
            break;
          case StringUtil.personalAccountChangeRecord:
            //账变记录
            Navigator.pushNamed(context, RouteUtil.accountChangeRecordController);
            break;
          case StringUtil.personalBank:
            //我的银行卡
            Navigator.pushNamed(context, RouteUtil.bankListController);
            break;
          case StringUtil.agentWithdrawalRecord:
            // 提现记录
            Navigator.pushNamed(context, RouteUtil.userWithdrawalRecordController);
            break;
        }
      },
      child: new ListStateItemView(
        title,
        isSwitch: false,
        isRightArrow: true,
        leftIcon: icon,
      ),
    );
  }

  /// 是否设置支付密码
  bool _readIsPayPassword() {

    return SpUtil.getBool(Constant.PAY_SET);
  }

}