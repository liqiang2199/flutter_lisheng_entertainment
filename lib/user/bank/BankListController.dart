import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/BankDataBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/BankListHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

class BankListController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BankListController();
  }

}

class _BankListController extends BaseRefreshController<BankListController> implements BankListHandler{

  List<BankDataBeen> dataBank = new List();

  @override
  void initState() {
    super.initState();
    UserService.instance.getBankList(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.myBankList),
      body: new Container(
        child: smartRefreshBase(_listBankItem()),

      ),
    );
  }

  Widget _listBankItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child:  new Column(
          children: <Widget>[
            _listBankAllView(i),
          ],
        ),
      ),
      //itemExtent: 200.0,
      itemCount: items.length,
    );
  }

  Widget _listBankAllView(int index) {
    if (index == (items.length - 1)) {
      return _butAddBank();
    } else {
      return _listBankList(index);
    }
  }

  //银行卡列表
  Widget _listBankList(int index) {

    return new Container(
      height: 130.0,
      child: new Card(
        child: new Column(
          children: <Widget>[
            _listTopView(dataBank[index].bank_name, dataBank[index].branch_name),
            _bankTextNum(dataBank[index].card_number),

          ],
        ),
      ),
    );
  }

  Widget _listTopView(String bankName, String bankType) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 95.0,
      child: new Row(
        children: <Widget>[

          Image.asset(ImageUtil.imgLotteryCenterCqSSC, width: 48.0, height: 48.0,),

          new Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0,),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                new Align(
                  child: new Text(
                    bankName,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(ColorUtil.textColor_333333),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  alignment: Alignment.centerLeft,
                ),

                new Align(
                  child: new Text(
                    bankType,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(ColorUtil.textColor_333333),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  alignment: Alignment.centerLeft,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _bankTextNum(String bankNum) {

    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Text(
          bankNum,
          style: TextStyle(
            fontSize: 20.0,
            color: Color(ColorUtil.textColor_888888),
          ),
        ),
      ),
    );
  }

  /// 添加银行卡
  Widget _butAddBank() {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: ScreenUtil.getScreenW(context),
        height: 46.0  ,
        margin: EdgeInsets.only(top: 15.0,),
        child: new RaisedButton(onPressed: (){
          //添加银行卡
          Navigator.pushNamed(context, RouteUtil.bindBankController).then((data){
            UserService.instance.getBankList(this);
          });
        },color: Color(ColorUtil.butColor),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(StringUtil.addBank
                  , style: TextStyle(fontSize: 13.0,color: Color(ColorUtil.whiteColor)),),
              ),

              Image.asset(ImageUtil.imgRightAllowWhite, height: 17.0, width: 17.0,)
            ],
          ),
          //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(ColorUtil.butColor),
            style: BorderStyle.none,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  @override
  bool isCanLoadMore() {
    return false;
  }

  @override
  bool isCanRefresh() {
    return false;
  }

  @override
  void setBankListDataBeen(List<BankDataBeen> data) {
    this.dataBank = data;
    BankDataBeen bankDataBeen = new BankDataBeen(0, 0, 0, "", "", "", "");
    dataBank.add(bankDataBeen);
    setState(() {
      this.items = dataBank;
    });
  }

}