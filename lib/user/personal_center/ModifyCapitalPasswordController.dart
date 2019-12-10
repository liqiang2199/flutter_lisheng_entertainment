import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/user/net/ModifyLoginPasswordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 修改登录密码
class ModifyCapitalPasswordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ModifyCapitalPasswordController();
  }

}

class _ModifyCapitalPasswordController extends BaseController<ModifyCapitalPasswordController> implements ModifyLoginPasswordHandler{

  //再次输入密码的控制器
  TextEditingController rePassController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  TextEditingController oldPassController = TextEditingController();

  String _cashPassWord = "";
  String _cashRePassWord = "";
  String _cashOldPassWord = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.modifyCapitalPasswordTitle),
      body: new Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0,top: 15.0,),
        height: 340.0,
        child: new Card(
          child: new Column(
            children: <Widget>[

              _modifyEdit(StringUtil.currentCapitalPassword, _getOldPass, oldPassController),
              _modifyEdit(StringUtil.capitalNewPassword, _getNewPass, passController),
              _modifyEdit(StringUtil.capitalAgainEditNewPassword, _getReNewPass, rePassController),
              _butModifyView(),

            ],
          ),
        ),
      ),
    );
  }

  /// 修改密码 输入框
  Widget _modifyEdit(String hintText, ValueChanged<String> onChanged, TextEditingController controller) {

    return new Container(
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(

        children: <Widget>[

          new Image.asset(ImageUtil.imgModifyPassWord, width: 16.0, height: 16.0,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new TextField(
              onChanged: onChanged,
              controller: controller,
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
              ),
              obscureText: true,
            ),
          )
        ],

      ),
    );
  }

  _getNewPass(String str) {
    _cashPassWord = str;
  }

  _getReNewPass(String str) {
    _cashRePassWord = str;
  }

  _getOldPass(String str) {
    _cashOldPassWord = str;
  }

  /// 修改密码
  Widget _butModifyView() {
    return new Container(
      margin: EdgeInsets.only(top: 35.0),
      width: 300.0,
      height: 45.0  ,
      child: new RaisedButton(onPressed: (){
        //
        UserService.instance.modifyPaypwd(_cashPassWord, _cashRePassWord, _cashOldPassWord, this);
      },color: Color(ColorUtil.butColor),
        child: new Text(StringUtil.modify
          , style: TextStyle(fontSize: 16.0,color: Color(ColorUtil.whiteColor)),),
        //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        shape: new StadiumBorder(side: new BorderSide(
          //设置 界面效果
          color: Color(ColorUtil.butColor),
          style: BorderStyle.none,
        ),),
      ),
    );
  }

  @override
  void setPayPasswordResult(bool result) {
    showToast("修改资金密码成功");
    Navigator.pop(context);
  }

}