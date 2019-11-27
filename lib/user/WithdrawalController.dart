import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 提现
class WithdrawalController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WithdrawalController();
  }

}

class _WithdrawalController extends State<WithdrawalController> {
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
          _withdrawalEditMoney("请输入提现金额"),
          SpaceViewUtil.pading_Top_10(),
          _butSubmitWithdrawal(),

        ],
      ),
    );
  }

  Widget _topWithdrawal() {

    return new Container(
      width: ScreenUtil.screenWidth,
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
                "2812.00",
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
  Widget _withdrawalEditMoney(String hintText) {

    return new Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Color(ColorUtil.whiteColor),
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      height: 53.0,
      child: new Row(
        children: <Widget>[

          new Text(
            StringUtil.withdrawalMoney,
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

}