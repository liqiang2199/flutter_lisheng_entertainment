import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/type/GetBankTypeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/BindBankHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_picker/flutter_picker.dart';

/// 绑定银行卡
class BindBankController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BindBankController();
  }

}

class _BindBankController extends BaseController<BindBankController> implements BindBankHandler{

  int bankTypeId;
  String cardNum;
  String branchName;
  String capitalPwd;
  String choiceBank = "请选择银行";

  TextEditingController cardNumController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController capitalPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.addBank),
      body: new ListView(
        children: <Widget>[

          _changeRechargeType("真实姓名", SpUtil.getString(Constant.USER_NAME), false),
          CommonView().commonLine_NoMargin(context),
          _withdrawalEditMoney("银行卡号", "请输入银行卡号",_getCardNumName, cardNumController, false, true),
          CommonView().commonLine_NoMargin(context),
          _changeRechargeType("开户银行",choiceBank, true),
          CommonView().commonLine_NoMargin(context),
          _withdrawalEditMoney("支行名称", "请输入支行名称", _getBranchName, branchNameController, false, false),
          CommonView().commonLine_NoMargin(context),
          _withdrawalEditMoney("资金密码", "大小写字母开头的8-24个字符", _getCapitalName, capitalPwdController, true, false),
          CommonView().commonLine_NoMargin(context),
          _addBankTip(),
          _butAddBankView(),

        ],
      ),
    );
  }

  /// 选择开户银行
  Widget _changeRechargeType(String title, String hintText, bool isVisible) {

    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 53.0,
      child: new GestureDetector(
        onTap: () {
          //类型选择
          if (isVisible) {
            UserService.instance.getBanktypeList(this);
          }

        },
        child: new Row(
          children: <Widget>[

            new Text(
              title,
              style: new TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_888888),
              ),
            ),

            SpaceViewUtil.pading_Left(10.0),
            new Expanded(
                child: new Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_888888),
                  ),
                )
            ),
            SpaceViewUtil.pading_Right_10(),
            new Visibility(
              visible: isVisible,
                child: new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),
            ),

          ],
        ),
      ),
    );
  }

  _getBranchName(String str) {
    branchName = str;
  }

  _getCardNumName(String str) {
    cardNum = str;
  }

  _getCapitalName(String str) {
    capitalPwd = str;
  }


  /// 转账金额
  Widget _withdrawalEditMoney(String title, String hintText,ValueChanged<String> _textFieldChanged
  , TextEditingController controller, bool isPassword, bool isNumber) {

    return new Container(
      color: Color(ColorUtil.whiteColor),
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      height: 53.0,
      child: new Row(
        children: <Widget>[

          new Text(
            title,
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new TextField(
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,//键盘类型，数字键盘
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
              ),
              onChanged: _textFieldChanged,
              controller: controller,
              obscureText: isPassword,
            ),
          ),

        ],
      ),
    );
  }

  Widget _addBankTip() {

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Text(
        "操作提示：为了保障您的账户安全，请认真填写您的银行信息，资料一经绑定无法修改。",
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _butAddBankView() {
    return new Container(
      width: 300.0,
      height: 45.0  ,
      margin: EdgeInsets.all(30.0),
      child: new RaisedButton(onPressed: (){
        //提交绑定
        UserService.instance.bindBank(bankTypeId, SpUtil.getString(Constant.USER_NAME)
            , cardNum, branchName, capitalPwd, this);

      },color: Color(ColorUtil.butColor),
        child: new Text(StringUtil.submitBindBank
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

  /// 选择支付方式
  showPickerIcons(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(data: listPickerItem),
      selectedTextStyle: TextStyle(color: Color(ColorUtil.textColor_333333)),
      textStyle: new TextStyle(
        fontSize: 14.0,
        color: Color(ColorUtil.textColor_333333),
      ),
      cancelText: "取消",
      cancelTextStyle: new TextStyle(
        fontSize: 16.0,
        color: Color(ColorUtil.textColor_333333),
      ),
      confirmText: "确定",
      confirmTextStyle: new TextStyle(
        fontSize: 16.0,
        color: Color(ColorUtil.textColor_333333),
      ),
      backgroundColor: Color(ColorUtil.lineColor),
      onConfirm: (Picker picker, List value) {
        print("value = ${value[0]}");
        print("getSelectedValues = ${picker.getSelectedValues()[0]}");
        bankTypeId = picker.getSelectedValues()[0];
        var bankType = getBankTypeList[value[0]];
        setState(() {
          choiceBank = bankType.name;
        });
      },
    ).showModal(context);
  }

  List<PickerItem> listPickerItem = new List();
  List<GetBankTypeDataBeen> getBankTypeList = new List();

  @override
  void setBankTypeList(List<GetBankTypeDataBeen> data) {
    listPickerItem.clear();
    getBankTypeList.clear();
    getBankTypeList = data;
    data.forEach((value) {
      listPickerItem.add(PickerItem(text: new Text("${value.name}", style: new TextStyle(fontSize: 16.0),), value: value.id));
    });

    showPickerIcons(context);

  }

  @override
  void setBindBankResult(bool result,String msg) {
    if (result) {
      showToast(msg);
      Navigator.pop(context, "");
    }
  }

}