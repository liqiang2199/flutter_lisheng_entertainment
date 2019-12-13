
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BettingNumAndOperationHandler.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';

/**
 * 下面投注 按钮
 */
class BettingNumAndOperationView extends StatelessWidget {

  final CalculationBettingNumDataBeen calculationBettingNumBeen;
  final BettingNumAndOperationHandler operationHandler;

  const BettingNumAndOperationView(
      {
        Key key,
        this.calculationBettingNumBeen,
        this.operationHandler
      }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 5.0),
      child: new Column(
        children: <Widget>[
          /// 共计 和 可用余额
          new Row(
            children: <Widget>[

              new Expanded(child: _bettingNumTotalText()),
              new Expanded(child: _bettingCanMoneyText()),

            ],
          ),

          _bettingBonusText(),

          _operationBut(),

        ],
      ),
    );
  }

  Widget _bettingNumTotalText() {

    return new Container(
      child: new Row(
        children: <Widget>[

          new Text(
            "共计：",
            style: TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

          _numText("${calculationBettingNumBeen.count}","注"),
          SpaceViewUtil.pading_Left(12.0),
          _numText("${double.parse(calculationBettingNumBeen.money) * calculationBettingNumBeen.count}","元"),

        ],
      ),
    );
  }

  /// 可用余额
  Widget _bettingCanMoneyText() {

    return new Container(
      child: new Row(
        children: <Widget>[

          new Text(
            "可用余额：",
            style: TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

          _numText(SpUtil.getString(Constant.ALL_MONEY),"元"),

        ],
      ),
    );
  }

  /// 奖金
  Widget _bettingBonusText() {

    return new Container(
      margin: EdgeInsets.only(top: 5.0),
      child: new Row(
        children: <Widget>[

          new Text(
            "奖金：",
            style: TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

          _numText(calculationBettingNumBeen.money_award,"元"),

        ],
      ),
    );
  }

  Widget _operationBut() {

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        _operationButItem("机选", 67.0, 1),
        _operationButItem("添加号码", 95.0, 2),
        _operationButItem("立即投注", 95.0, 3),

      ],
    );
  }

  Widget _numText(String money,String company) {

    return new Container(
      child: new Row(
        children: <Widget>[
          new Text(
            money,
            style: TextStyle(
              color: Color(ColorUtil.bgColor_E7242C),
              fontSize: 14.0,
            ),
          ),

          new Container(
            padding: EdgeInsets.only(left: 3.0),
            child: new Text(
              company,
              style: TextStyle(
                color: Color(ColorUtil.textColor_333333),
                fontSize: 14.0,
              ),
            ),
          ),

        ],
      ),
    );
  }

  /// 按钮
  Widget _operationButItem(String butTitle, double w, int index) {
    return new Container(
      width: w,
      height: 30.0  ,
      margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 15.0,),
      child: new RaisedButton(onPressed: (){
        //
        switch(index) {
          case 1:
            if (operationHandler != null) {
              operationHandler.butMachineSelection();
            }
            break;
          case 2:
            if (operationHandler != null) {
              operationHandler.butAddNumber();
            }
            break;
          case 3:
            if (operationHandler != null) {
              operationHandler.butImmediateBet();
            }
            break;
        }

      },color: Color(ColorUtil.butColor),
        child: new Text(butTitle
          , style: TextStyle(fontSize: 13.0,color: Color(ColorUtil.whiteColor)),),
        //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        shape: new RoundedRectangleBorder(side: new BorderSide(
          //设置 界面效果
          color: Color(ColorUtil.butColor),
          style: BorderStyle.none,

        ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

}