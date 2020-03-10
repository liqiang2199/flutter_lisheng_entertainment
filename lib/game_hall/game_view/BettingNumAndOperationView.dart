
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BettingNumAndOperationHandler.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';

/**
 * 下面投注 按钮
 */
///
class BettingNumAndOperationView extends StatefulWidget {

  final CalculationBettingNumDataBeen calculationBettingNumBeen;
  final BettingNumAndOperationHandler operationHandler;
  final String playMoneyAward;//玩法奖金
  final int bettingNum;// 投注倍数
  final int moneyCompany;// 钱的单位 0 元 1 角 2 分 3 厘


  const BettingNumAndOperationView(
      {
        Key key,
        this.calculationBettingNumBeen,
        this.operationHandler,
        this.playMoneyAward = "0.00",
        this.bettingNum = 1,
        this.moneyCompany = 0,
      }
      ) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BettingNumAndOperationStateView(
      calculationBettingNumBeen: this.calculationBettingNumBeen,
      operationHandler: this.operationHandler,
      playMoneyAward: this.playMoneyAward,
      bettingNum: this.bettingNum,
      moneyCompany: this.moneyCompany,
    );
  }
}

class BettingNumAndOperationStateView extends BaseController<BettingNumAndOperationView> {

  CalculationBettingNumDataBeen calculationBettingNumBeen;
  BettingNumAndOperationHandler operationHandler;
  String playMoneyAward;//玩法奖金
  int bettingNum;// 投注倍数
  int _bettingNumCount = 0;// 投注 注数
  String _bettingNumCountMoney = "0.00";// 投注 注数 金额
  int moneyCompany;// 钱的单位 0 元 1 角 2 分 3 厘
  bool _isDragonTiger = false;// 是否是新龙虎
  List<String> _dragonTigerMoney = ["","",""];//保存玩法金额


  BettingNumAndOperationStateView(
      {
        this.calculationBettingNumBeen,
        this.operationHandler,
        this.playMoneyAward = "0.00",
        this.bettingNum = 1,
        this.moneyCompany = 0,
      }
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    int _moneyCompanyMultiple = 1;
    switch(moneyCompany) {
      case 0:
        _moneyCompanyMultiple = 1;
        break;
      case 1:
        _moneyCompanyMultiple = 10;
        break;
      case 2:
        _moneyCompanyMultiple = 100;
        break;
      case 3:
        _moneyCompanyMultiple = 1000;
        break;
    }
// 14 + 20 = 34
    return  new Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 5.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// 共计 和 可用余额
          new Row(
            children: <Widget>[

              //账号奖金：1994
              new Expanded(child: _accountBonusMoney(), flex: 1,),
              new Expanded(child: _bettingNumTotalText(_moneyCompanyMultiple), flex: 0,),
              //new Expanded(child: _bettingCanMoneyText()),

            ],
          ),

          //_bettingBonusText(_moneyCompanyMultiple),

          _operationBut(),

        ],
      ),
    );
  }

  Widget _bettingNumTotalText(int company) {

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

          _numText("${_bettingNumCount}","注"),
          SpaceViewUtil.pading_Left(12.0),
          //_numText("${(double.parse(calculationBettingNumBeen.money) * calculationBettingNumBeen.count * bettingNum)/company}","元"),
          _numText("${(double.parse(_bettingNumCountMoney) * _bettingNumCount * bettingNum)/company}","元"),

        ],
      ),
    );
  }

  /// 可用余额
  Widget _bettingCanMoneyText() {

    return new Container(
      alignment: Alignment.center,
      padding: new EdgeInsets.only(top: 14.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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

  /// 账号奖金
  Widget _accountBonusMoney() {

    return new Container(
      child: new Row(
        children: <Widget>[

          new Text(
            "账号奖金：",
            style: TextStyle(
              color: Color(ColorUtil.textColor_333333),
              fontSize: 14.0,
            ),
          ),

          _numText(SpUtil.getString(Constant.USER_RATIO),""),

        ],
      ),
    );
  }

  /// 奖金 19
  Widget _bettingBonusText(int multiple) {

    var playMoneyAwarText = "0.00";
    var multipleAwardStr = "0.00";

    if (_isDragonTiger) {
      StringBuffer  stringBuffer = new StringBuffer();
      _dragonTigerMoney.forEach((value){
        if (!TextUtil.isEmpty(value)) {
          var multipleAward = (double.parse(value) * bettingNum) / multiple ;
          stringBuffer.write(formatNum(multipleAward, 2));
          stringBuffer.write("/");
        }

      });
      if (stringBuffer.toString().length > 0) {
        multipleAwardStr = stringBuffer.toString().substring(0, stringBuffer.toString().length - 1);
      }

    } else {

      if(!TextUtil.isEmpty(calculationBettingNumBeen.money_award)) {
        playMoneyAwarText = calculationBettingNumBeen.money_award;
      }
//    var parse = num.parse("").toDouble();
      //var multipleAward = double.parse(this.playMoneyAward) / multiple;
      var multipleAward = (double.parse(playMoneyAwarText) * bettingNum) / multiple ;
      multipleAwardStr = formatNum(multipleAward, 4);
    }

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

          //_numText(calculationBettingNumBeen.money_award,"元"),
//          _numText("${(double.parse(this.playMoneyAward) / multiple)}","元"),
          _numText("$multipleAwardStr","元"),

        ],
      ),
    );
  }

  String formatNum(double num,int postion){
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      //小数点后有几位小数
      print( num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
      return num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }else{
      print( num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }
  }
//45
  Widget _operationBut() {

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        //new Expanded(child: _redBotOperationBut("0"), flex: 1,),
        new Expanded(child: _bettingCanMoneyText(), flex: 1,),//可用余额
        new Expanded(child: _operationButItem("机选", 57.0, 1), flex: 0,),
        //new Expanded(child: _operationButItem("添加号码", 95.0, 2), flex: 0,),
        new Expanded(child: _operationButItem("立即投注", 80.0, 3), flex: 0,),

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

  Widget _redBotOperationBut(String num) {

    return new Container(
      alignment: Alignment.topRight,
      child: new Stack(

        children: <Widget>[
          _operationButItem("购物车", 67.0, 0),
          _redBot(num),
        ],
    ),

    );
  }

  /// 按钮
  Widget _operationButItem(String butTitle, double w, int index) {
    return new Container(
      width: w,
      height: 30.0  ,
      margin: EdgeInsets.only(top: 15.0, left: 5.0,),
//      padding: EdgeInsets.all(5.0),
      child: new RaisedButton(onPressed: (){
        //
        switch(index) {
          case 0:
            /// 购物车
            if (operationHandler != null) {
              operationHandler.butShopCart();
            }
            break;
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
          , style: TextStyle(fontSize: 11.0,color: Color(ColorUtil.whiteColor)),),
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

  Widget _redBot(String num) {

    return new Container(
      height: 18.0,
      width: 18.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Color(ColorUtil.bgColor_E7242C),
        border: new Border.all(
          color: Color(ColorUtil.bgColor_E7242C),
          width: 1,
        ), // 边色与边宽度
        //borderRadius: new BorderRadius.circular((24.0)), // 圆角度
      ),
      child: new Text(
        num,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  setCalculationBettingNumData(CalculationBettingNumDataBeen calculationBettingNumBeen) {
    this.calculationBettingNumBeen = calculationBettingNumBeen;
    _bettingNumCount = calculationBettingNumBeen.count;
    _bettingNumCountMoney = calculationBettingNumBeen.money;
    _isDragonTiger = false;
    if (mounted)
      setState(() {

      });
  }

  /// 新龙虎 isDragonTiger
  setCalculationBettingNumDataToDragonTiger(CalculationBettingNumDataBeen calculationBettingNumBeen, bool isDragonTiger) {
    this.calculationBettingNumBeen = calculationBettingNumBeen;
    this._isDragonTiger = isDragonTiger;
    _bettingNumCount++;
    _bettingNumCountMoney = calculationBettingNumBeen.money;

    if (!TextUtil.isEmpty(calculationBettingNumBeen.play_name)) {
      var length = calculationBettingNumBeen.play_name.length;
      var substring = calculationBettingNumBeen.play_name.substring(length-1, length);
      switch(substring) {
        case "龙":
          _dragonTigerMoney[0] = "${calculationBettingNumBeen.money_award}";
          break;
        case "虎":
          _dragonTigerMoney[1] = "${calculationBettingNumBeen.money_award}";
          break;
        case "和":
          _dragonTigerMoney[2] = "${calculationBettingNumBeen.money_award}";
          break;
      }
    }

    if (mounted)
      setState(() {

      });
  }

  /// 清空状态值
  cleanDragonTigerStatusText() {

    _dragonTigerMoney[0] = "";
    _dragonTigerMoney[1] = "";
    _dragonTigerMoney[2] = "";

    _bettingNumCount = 0;
    _bettingNumCountMoney = "0.00";

    if (mounted)
      setState(() {

      });
  }

  /// 投注倍数
  setBettingNum(int num) {
    this.bettingNum = num;
    if (mounted)
      setState(() {

      });
  }

  setBettingNumAndSlideValue(int num, int slideValueCompany) {
    this.bettingNum = num;
    this.moneyCompany = slideValueCompany;
    if (mounted)
      setState(() {

      });
  }

}