import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/BankDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/WithdrawListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_picker/Picker.dart';

import 'net/BankListHandler.dart';
import 'net/WithdrawHandler.dart';

/// 提现
class WithdrawalController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WithdrawalController();
  }

}

class _WithdrawalController extends BaseController<WithdrawalController> implements WithdrawHandler, BankListHandler{

  String withdrawAmount = "0.00";
  String choiceBank = "选择提现银行";
  String bankId;
  String money;
  String pay_pwd;

  TextEditingController branchNameController = TextEditingController();
  TextEditingController capitalPwdController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserService.instance.withdrawList(this);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.withdrawalTitle),
      body: new Column(
        children: <Widget>[

          _topWithdrawal(),
          _changeRechargeType("提现银行",choiceBank, true),
          _withdrawalEditMoney(StringUtil.withdrawalMoney,"请输入提现金额", _getWithdrawMoney,branchNameController, false, true),
          _withdrawalEditMoney("资金密码","请输入资金密码", _getPayPassword, capitalPwdController, true, false),
          SpaceViewUtil.pading_Top_10(),
          _butSubmitWithdrawal(),

        ],
      ),
    );
  }

  Widget _topWithdrawal() {

    return new Container(
      width: ScreenUtil.getScreenW(context),
      height: 166.0,
      color: Color(ColorUtil.bgColor_FAA139),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          new Image.asset(ImageUtil.imgWithdrawalMoney, width: 66.0, height: 36.0,),
          SpaceViewUtil.pading_Top_10(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Text(
                "¥",
                style: new TextStyle(
                  fontSize: 12.0,
                  color: Colors.white
                ),
                textAlign: TextAlign.end,
              ),

              SpaceViewUtil.pading_Left(3.0),
              new Text(
                withdrawAmount,
                style: new TextStyle(
                    fontSize: 24.0,
                    color: Colors.white
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }


  /// 提现金额
  Widget _withdrawalEditMoney(String title,String hintText, ValueChanged<String> _textFieldChanged
      , TextEditingController controller, bool isPassword, bool isNumber) {

    return new Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Color(ColorUtil.whiteColor),
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      height: 53.0,
      child: new Row(
        children: <Widget>[

          new Text(
            title,
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new TextField(
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

  _getPayPassword(String payPassword) {
    this.pay_pwd = payPassword;
  }

  _getWithdrawMoney(String money) {
    this.money = money;
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
            UserService.instance.getBankList(this);
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

  /// 确认提现
  Widget _butSubmitWithdrawal() {
    return new Container(
      width: 300.0,
      height: 45.0  ,
      margin: EdgeInsets.only(top: 35.0),
      child: new RaisedButton(onPressed: (){
        //确认提现
        UserService.instance.userWithdraw(this, money, bankId, pay_pwd);
      },color: Color(ColorUtil.butColor),
        child: new Text(StringUtil.sureWithdrawal
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

        var bankType = bankListData[value[0]];
        setState(() {
          choiceBank = bankType.card_number;
          bankId = "${bankType.id}";
        });
      },
    ).showModal(context);
  }

  List<PickerItem> listPickerItem = new List();
  List<BankDataBeen> bankListData = new List();

  @override
  void setWithdrawListData(WithdrawListDataBeen listDataBeen) {
    withdrawAmount = listDataBeen.data.withdrawAllmoney;
    setState(() {

    });
  }

  @override
  void userWithdrawResult(bool result) {
    /// 申请成功

  }

  @override
  void setBankListDataBeen(List<BankDataBeen> data) {
    this.bankListData = data;
    data.forEach((value) {
      listPickerItem.add(PickerItem(text: new Text("${value.card_number}", style: new TextStyle(fontSize: 16.0),), value: value.id));
    });
    showPickerIcons(context);
  }

}