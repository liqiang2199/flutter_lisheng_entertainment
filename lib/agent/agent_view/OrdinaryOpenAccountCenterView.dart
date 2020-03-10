import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/agent/net/OpenAccountIntervalHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/OrdinaryOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/open_account_interval/OpenAccountIntervalBeen.dart';
import 'package:flutter_lisheng_entertainment/view/SemicircleButView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SemicircleButCallBack.dart';

/// 开户中心 -》 普通开户
class OrdinaryOpenAccountCenterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrdinaryOpenAccountCenterView();
  }

}

class _OrdinaryOpenAccountCenterView extends BaseController<OrdinaryOpenAccountCenterView>
    with SemicircleButCallBack implements OrdinaryOpenAccountHandler, OpenAccountIntervalHandler{

  int groupValue = 1;

  //请输入用户名
  TextEditingController accountController = TextEditingController();
  TextEditingController loginAccountController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  TextEditingController rePassController = TextEditingController();
  //请输入返点
  TextEditingController ratioController = TextEditingController();

  String _loginAccount;//登录账号
  String _accountName;
  String _pass;
  String _rePass;
  String _ratio;
  String accountType = "1";//账户类型
  // 开户区间
  String openAccountCenter = StringUtil.openAccountCenterEditReturnTip;
  String _maxRatio = "";// 最大开户区间

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AgentService.instance.openAccount(this);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[

        _openAccountType(),

//        _editOpenAccount("请输入用户名", ImageUtil.imgOpenAccountEdit, _getAgentAccount, accountController, false),
//        _editTip(StringUtil.openAccountCenterEditTip),
        _editOpenAccount("请输入登录账号", ImageUtil.imgOpenAccountEdit, _getAgentLoginAccount, loginAccountController, false),
        _editTip(StringUtil.openAccountCenterEditTip),
        _editOpenAccount("请输入密码", ImageUtil.imgModify, _getAgentPass, passController, true),
        _editTip(StringUtil.openAccountCenterEditTip),
        _editOpenAccount("请再次输入密码", ImageUtil.imgModify, _getAgentRePass, rePassController, true),
        _editOpenAccount("请输入返点", ImageUtil.imgReturnPoint, _getAgentRatio, ratioController, false),
        _editTip(openAccountCenter),

        new Container(
          margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
          child: SemicircleButView(this,title: "立即开户",),
        ),

      ],
    );
//  return _openAccountType();
  }

  /// 开户类型选择
  Widget _openAccountType() {

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          new Text(
            "开户类型：",
            style: new TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

          _radioChoice(true, "代理", 1),
          _radioChoice(false, "玩家", 2),

        ],
      ),
    );
  }

  void setUpdateTypeChoice(int v) {
    setState(() {
      groupValue = v;
    });
  }

  Widget _radioChoice(bool isSelection, String title, int index) {
    return new GestureDetector(
      onTap: () {
        //1=用户，2=代理
        setUpdateTypeChoice(index);
        accountType = "$index";
      },
      child: new Container(
        padding: EdgeInsets.only(left: 15.0,),
        child: new Row(
          children: <Widget>[
            Image.asset(groupValue == index? ImageUtil.imgRadioBgSelection : ImageUtil.imgRadioBg
              , width: 22.0, height: 22.0,),
            SpaceViewUtil.pading_Left(5.0),
            new Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// 编辑输入 内容
  Widget _editOpenAccount(String hintText, String imgIcon,  ValueChanged<String> onChanged, TextEditingController controller, bool isEditPass) {

    return new Container(
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(

        children: <Widget>[

          new Image.asset(imgIcon, width: 16.0, height: 16.0,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new TextField(
              onChanged: onChanged,
              controller: controller,
              obscureText: isEditPass,
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
              ),
            ),
          )
        ],

      ),
    );
  }

  /// 输入框下提示
  Widget _editTip(String content) {

    return new Container(
      padding: EdgeInsets.only(left: 15.0, top: 10.0,right: 15.0,bottom: 10.0),
      child: new Text(
        content,
        style: TextStyle(
          fontSize: 12.0,
          color: Color(ColorUtil.textColor_888888)
        ),
      ),
    );
  }

  _getAgentLoginAccount(String str) {
    _loginAccount = str;
  }


  _getAgentAccount(String str) {
    _accountName = str;
  }

  _getAgentPass(String str) {
    _pass = str;
  }

  _getAgentRePass(String str) {
    _rePass = str;
  }

  _getAgentRatio(String str) {
    _ratio = str;
  }

  @override
  void onPressedBut() {
    AgentService.instance.postOrdinaryOpenAccount(this, accountType
        , _loginAccount, "", _pass, _rePass, _ratio, _maxRatio);
  }

  @override
  void setOrdinaryOpenAccountResult(bool result) {
    if (result) {
      accountController.clear();
      loginAccountController.clear();
      passController.clear();
      rePassController.clear();
      ratioController.clear();
      _accountName = "";
      _loginAccount = "";
      _pass = "";
      _rePass = "";
      _ratio = "";
      accountType = "1";
      setUpdateTypeChoice(1);
    }
  }

  @override
  void setOpenAccountIntervalBeen(OpenAccountIntervalBeen been) {
    _maxRatio = been.data.max_ratio;
    openAccountCenter = "开户区间：0.0-${been.data.max_ratio}";
    setState(() {

    });
  }

}