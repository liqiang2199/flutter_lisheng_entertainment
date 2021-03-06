
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';

/**
 * 开奖 列表 View
 */
class LotteryNumListView extends StatefulWidget {

  final bool is11Choice5;
  final bool isLookLotteryList;//是否是下拉查看开奖号码
  final List<OpenLotteryListTwoDataListBeen> openLotteryListBeen;
  final String lotteryID;

  const LotteryNumListView({
    Key key,
    this.is11Choice5,
    this.isLookLotteryList = false,
    this.openLotteryListBeen,
    this.lotteryID = "9",

  }) : super(key: key);// 是否是 11 选 5

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LotteryNumListStateView(is11Choice5: this.is11Choice5,
        isLookLotteryList: this.isLookLotteryList,
        openLotteryListBeen: this.openLotteryListBeen,
        lotteryID: this.lotteryID
    );
  }

}
class LotteryNumListStateView extends BaseController<LotteryNumListView> {

  bool is11Choice5 = true;
  bool isLookLotteryList;//是否是下拉查看开奖号码
  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen;
  String lotteryID;

  LotteryNumListStateView({
    this.is11Choice5,
    this.isLookLotteryList = false,
    this.openLotteryListBeen,
    this.lotteryID

  });// 是否是 11 选 5

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Visibility(
        visible: isLookLotteryList,
        child: new Container(
          height: 200.0,
          child: ListView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) => Container(
              color: Colors.white,
              child:  new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _gameItem(i),

                ],
              ),
            ),
            //itemExtent: 200.0,
            itemCount: openLotteryListBeen.length,
          ),
        ),
    );
  }

  Widget _gameItem(int index) {
    if (openLotteryListBeen == null || openLotteryListBeen.length <= 0) {
      return new Container(
        padding: EdgeInsets.only(bottom: 8.0,),
        color: Colors.white,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _num("当期暂无开奖"),

          ],
        ),
      );
    }

    if (lotteryID == "15") {
      return new Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _num(TextUtil.isEmpty(openLotteryListBeen[index].pre_draw_issue)? "" : openLotteryListBeen[index].pre_draw_issue),
            _numStrList(openLotteryListBeen[index]),
            new Expanded(child: _numLotteryPlay(TextUtil.isEmpty(openLotteryListBeen[index].play)? "" : openLotteryListBeen[index].play),),
          ],
        ),
      );
    }

    return new Container(
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _num(TextUtil.isEmpty(openLotteryListBeen[index].pre_draw_issue)? "" : openLotteryListBeen[index].pre_draw_issue),
          _numStrList(openLotteryListBeen[index]),
        ],
      ),
    );
  }

  /**
   * 11 选 5 的下拉开奖号码列表
   */
  ///
  Widget _num(String title) {
    var length = title.length;
    if (lotteryID == "15") {
      title = "${title.substring(length - 3, length)}期";
    } else {
      title = "${title.substring(length - 2, length)}期";
    }
    return new Container(
      margin: EdgeInsets.only(right: 10.0, top: 3.0),
      alignment: Alignment.center,
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _numLotteryPlay(String title) {
    return new Container(
      margin: EdgeInsets.only(right: 10.0, top: 3.0),
      alignment: Alignment.center,
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _numStrList(OpenLotteryListTwoDataListBeen dataListBeen) {
    List<Widget> numViewList = new List();
    var pre_draw_code = dataListBeen.pre_draw_code;
    var preListStr = pre_draw_code.split(",");
    preListStr.forEach((valueNum) {
      numViewList.add(_cqNumView(valueNum));

    });
    return new Row(
      children: numViewList,
    );
  }

  Widget _cqNumView(String num) {

    return new Container(
      height: 22.0,
      width: 22.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.0, top: 3.0),
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

  void onSetRefreshLotteryNumList( bool isOpenLotteryList, List<OpenLotteryListTwoDataListBeen> openLotteryListBeen) {
    this.isLookLotteryList = isOpenLotteryList;
    this.openLotteryListBeen = openLotteryListBeen;

    if (mounted)
      setState(() {

      });
  }

}