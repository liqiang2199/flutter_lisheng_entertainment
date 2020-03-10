import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseChoicePhotoController.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/base/handler/ModifyAvatarHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import 'team_controller/TeamReportFormController.dart';

/// 代理中心
class AgentCenterController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AgentCenterController();
  }

}

class _AgentCenterController extends BaseChoicePhotoController<AgentCenterController> implements ModifyAvatarHandler{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.agentCenter),
      body: new ListView(
        children: <Widget>[

          _topHead(),
          _listAgentOperation(),
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

    return new GestureDetector(
      onTap: () {
        openModalBottomSheet();
      },
      child: new Center(
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
            _getRightArrowView(StringUtil.agentOpenAccount, ImageUtil.imgAgentOpenAccount, 0),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.agentVipManage, ImageUtil.imgAgentVip, 1),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.agentAgencyBonus, ImageUtil.imgAgentAgencyBonus, 2),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.agentRechargeRecord, ImageUtil.imgAgentRechargeRecord, 3),
            CommonView().commonLine(context),
            _getRightArrowView(StringUtil.agentWithdrawalRecord, ImageUtil.imgAgentWithdrawalRecord, 4),

          ],
        ),
      ),
    );
  }

  _getRightArrowView(String title, String icon, int index) {

    return new GestureDetector(
      onTap: () {
        switch(index) {
          case 0:
            //开户中心
            var agentCenter = SpUtil.getString(Constant.IS_AGENT);
            if (TextUtil.isEmpty(agentCenter)) {
              showToast("非代理不能开户");
              return;
            }
            if (agentCenter == "1") {
              showToast("非代理不能开户");
              return;
            }
            Navigator.pushNamed(context, RouteUtil.openAccountCenterController);
            break;
          case 1:
            //会员管理
            Navigator.pushNamed(context, RouteUtil.memberManagerController);
            break;
          case 2:
            //代理分红
            Navigator.pushNamed(context, RouteUtil.agencyBonusController);
            break;
          case 3:
            //充值记录
            Navigator.pushNamed(context, RouteUtil.rechargeRecordController);
            break;
          case 4:
            //提款记录
            Navigator.pushNamed(context, RouteUtil.withdrawalRecordController);
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

  /// 代理中心 团队操作
  Widget _listAgentOperation() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0,right: 15.0),
      child: new Card(
        child: new Row(
          children: <Widget>[
            new Expanded(child: _gridAgentItem(agentOperationIcon[0], agentOperationStr[0], 0)),
            new Expanded(child: _gridAgentItem(agentOperationIcon[1], agentOperationStr[1], 1)),
            new Expanded(child: _gridAgentItem(agentOperationIcon[2], agentOperationStr[2], 2)),
            new Expanded(child: _gridAgentItem(agentOperationIcon[3], agentOperationStr[3], 3)),
          ],
        ),
      ),
    );
  }

  List<String> agentOperationStr = ["团队总览", "团队报表", "团队账变", "团队投注"];
  List<String> agentOperationIcon = [ImageUtil.imgAgentTeamOverview, ImageUtil.imgAgentTeamReport
    , ImageUtil.imgAgentTeamAccountChange, ImageUtil.imgAgentTeamBet];
  //操作 的 item
  Widget _gridAgentItem(String icon, String title, int index) {

    return new Container(
      padding: EdgeInsets.only(top: 15.0,),
      height: 99.0,
      child: new GestureDetector(
        onTap: () {
          switch(index) {
            case 0:
              //团队总览
              Navigator.pushNamed(context, RouteUtil.teamOverviewController);
              break;
            case 1:
              //团队报表
              //Navigator.pushNamed(context, RouteUtil.teamReportFormController);
//              try {
//                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
//                  builder: (BuildContext context) => TeamReportFormController(),
//                  settings: RouteSettings(
//                    arguments: {"userIdDL" : "0"},
//                  ),
//                ), (//跳转到主页
//                    // ignore: unrelated_type_equality_checks
//                    Route route) => route == RouteUtil.teamReportFormController);
//              } catch (e) {
//
//              }
              Navigator.pushNamed(context, RouteUtil.teamReportFormController, arguments: {"userIdDL" : "0"});
              break;
            case 2:
              //团队账变
              Navigator.pushNamed(context, RouteUtil.teamAccountChangeController);
              break;
            case 3:
              //团队投注
              Navigator.pushNamed(context, RouteUtil.teamBettingController);
              break;
          }
        },
        child: new Column(
          children: <Widget>[

            new Image.asset(icon, width: 40.0, height: 40.0,),
            SpaceViewUtil.pading_Top_10(),

            new Text(title,
              style: new TextStyle(
                  fontSize: 12.0,
                  color: Color(ColorUtil.textColor_888888)
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void upLoadFileSuccessful(String urlImg) {
    UserService.instance.editAvatar(context, this, urlImg);
  }

  @override
  void setModifyHeadImgUrl(String urlHeadImg) {
    setState(() {

    });
  }

}