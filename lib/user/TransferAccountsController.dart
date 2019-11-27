import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 转账
class TransferAccountsController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TransferAccountsController();
  }

}

class _TransferAccountsController extends State<TransferAccountsController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(ColorUtil.whiteColor),
      appBar: CommonView().commonAppBar(context, StringUtil.withdrawalTitle),
      body: new Column(
        children: <Widget>[

          _changeRechargeType("转入账户","请选择转入账户"),
          CommonView().commonLine(),
          _changeRechargeType("转出账户","请选择转出账户"),
          CommonView().commonLine(),
          _withdrawalEditMoney("转账金额","请输入转账金额"),
          CommonView().commonLine(),
          _withdrawalEditMoney("资金密码","请输入资金密码"),
          CommonView().commonLine(),
          SpaceViewUtil.pading_Top_10(),
          _butSubmitWithdrawal(),

        ],
      ),
    );
  }


  /// 选择转入 和 转出账户
  Widget _changeRechargeType(String title, String hintText) {

    return new Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 53.0,
      child: new GestureDetector(
        onTap: () {
          showPickerIcons(context);
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
            new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),

          ],
        ),
      ),
    );
  }


  /// 转账金额
  Widget _withdrawalEditMoney(String title, String hintText) {

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
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
              ),
            ),
          ),

        ],
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
        //退出登录

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
      adapter: PickerDataAdapter(data: [

        PickerItem(text: new Text("支付宝", style: new TextStyle(fontSize: 16.0),), value: "支付宝"),
        PickerItem(text: new Text("微信", style: new TextStyle(fontSize: 16.0)), value: "微信"),
        PickerItem(text: new Text("银行", style: new TextStyle(fontSize: 16.0)), value: "银行"),
        PickerItem(text: new Text("银联", style: new TextStyle(fontSize: 16.0)), value: "银联"),

      ]),
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
        print(value.toString());
        print(picker.getSelectedValues());
      },
//    ).show(_scaffoldKey.currentState);
    ).showModal(context);
//    ).showDialog(context);
  }

}