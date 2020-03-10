import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeService.dart';
import 'package:flutter_lisheng_entertainment/home/net/LotteryCenterHandler.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_center/LotteryCenterBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_center/LotteryCenterDataBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 开奖中心
class LotteryCenterController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LotteryCenterController();
  }

}

class _LotteryCenterController extends BaseRefreshController<LotteryCenterController> implements LotteryCenterHandler{

  List<LotteryCenterDataBeen> dataLotteryCenterList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 300)).then((value){
      HomeService.instance.getApiHome(this);
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(ColorUtil.lineColor),
      appBar: CommonView().commonAppBar(context, StringUtil.homeLotteryCenter),
      body: new Column(
        children: <Widget>[

          _topBanner(),

          new Expanded(child: smartRefreshBase(_listLotteryItem()),),

        ],
      ),
    );
  }

  Widget _topBanner() {

    return new Image.asset(ImageUtil.imgLotteryCenterBanner);
  }

  /// 开奖中心 列表
  Widget _listLotteryItem () {

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: new GestureDetector(
          onTap: () {
            //
          },
          child: _listItem(i),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: dataLotteryCenterList.length,
    );
  }

  Widget _listItem(int index) {

    return new Card(
      child: new Column(
        children: <Widget>[

//          _numStrList(dataLotteryCenterList[index]),
          _listTopView(index),
          CommonView().commonLine_NoMargin(context),
          _listBottom(index),

        ],
      ),
    );
  }

  Widget _listTopView(int index) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
//      height: 95.0,
      child: new Row(
        children: <Widget>[

          Image.asset(ImageUtil.imgLotteryCenterCqSSC, width: 67.0, height: 67.0,),

          new Expanded(
              child: new Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0,),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    new Align(
                      child: new Text(
                        dataLotteryCenterList[index].name,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(ColorUtil.textColor_333333),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      alignment: Alignment.centerLeft,
                    ),

                    _numStrList(dataLotteryCenterList[index]),

                  ],
                ),
              ),
          ),

        ],
      ),
    );
  }

  Widget _numStrList(LotteryCenterDataBeen dataListBeen) {
    List<Widget> numViewList = new List();
    var pre_draw_code = dataListBeen.preDrawCode;
    var preListStr = pre_draw_code.split(",");
    preListStr.forEach((valueNum) {
      numViewList.add(_cqNumView(valueNum));

    });
//    return new Row(
//      children: numViewList,
//    );

//    return new Wrap(
//      children: numViewList,
//    );

    return new Container(
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 6,
        padding: const EdgeInsets.only(top:0.0,),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 0.9,
        children: numViewList,
        shrinkWrap: true,

      ),
    );
  }

  Widget _cqNumView(String num) {

    return new Container(
      height: 25.0,
      width: 25.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.0),
//      padding: EdgeInsets.only(top: 3.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Color(ColorUtil.bgColor_E7242C),
        border: new Border.all(color: Color(ColorUtil.bgColor_E7242C), width: 1), // 边色与边宽度
        //borderRadius: new BorderRadius.circular((24.0)), // 圆角度
      ),
      child: new Text(
        num,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 列表 期数  走势 玩法
  Widget _listBottom(int index) {

    String qs = "";
    String preDrawIssue = "${dataLotteryCenterList[index].preDrawIssue}";
    if ( !TextUtil.isEmpty(preDrawIssue)) {
      String preQsNumQ = preDrawIssue.substring(0, preDrawIssue.length - 3);
      String preQsNumH = preDrawIssue.substring(preDrawIssue.length - 3, preDrawIssue.length);
      qs = "$preQsNumQ-$preQsNumH";
    }

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
              child: new Container(
                child: new Text(
                  "第$qs期",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_888888),
                  ),
                ),
                padding: EdgeInsets.only(left: 10.0),
              ),
          ),

          _butGameFun("走势", ColorUtil.textColor_FF8814),
          _butGameFun("玩法", ColorUtil.bgColor_E7242C),

        ],
      ),
    );
  }

  // 走势 玩法 按钮
  Widget _butGameFun(String name, int colorId) {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 67.0,
        height: 30.0  ,
        margin: EdgeInsets.only( left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //

        },color: Color(ColorUtil.whiteColor),
          child: new Text(name
            , style: TextStyle(fontSize: 13.0,color: Color(colorId)),),
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(colorId),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }


  @override
  void setLotteryCenterBeen(LotteryCenterBeen data) {
    this.dataLotteryCenterList = data.data;
    setState(() {

    });

  }

}