import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 绑定银行卡
class BindBankController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BindBankController();
  }

}

class _BindBankController extends State<BindBankController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.addBank),
      body: new ListView(
        children: <Widget>[

          _changeRechargeType("真实姓名", "真实姓名"),
          CommonView().commonLine_NoMargin(),
          _withdrawalEditMoney("银行卡号", "请输入银行卡号"),
          CommonView().commonLine_NoMargin(),
          _changeRechargeType("开户银行", "请选择银行"),
          CommonView().commonLine_NoMargin(),
          _withdrawalEditMoney("支行名称", "请输入支行名称"),
          CommonView().commonLine_NoMargin(),
          _withdrawalEditMoney("资金密码", "大小写字母开头的8-24个字符"),
          CommonView().commonLine_NoMargin(),


        ],
      ),
    );
  }

  /// 选择转入 和 转出账户
  Widget _changeRechargeType(String title, String hintText) {

    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 53.0,
      child: new GestureDetector(
        onTap: () {

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

}