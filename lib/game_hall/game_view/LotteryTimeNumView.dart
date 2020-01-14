
import 'dart:async';
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 开奖 View
 * 237
 * 14 + 8 + 8 + 2 + (25 + 8 + 8) * 5
 */

class LotteryTimeNumView extends StatefulWidget {

  final bool is11Choice5;//是否是 11 选 5  的开奖View
  final bool isOpenLotteryList;// 是否是下拉查看开奖号码
  final String playRemark;//玩法说明
  final String openLotteryTime;
  final String openLotteryDrawIssue;
  final List<OpenLotteryListTwoDataListBeen> openLotteryListBeen;

  const LotteryTimeNumView({
    Key key,
    this.is11Choice5 = true,
    this.isOpenLotteryList = true,
    this.playRemark,
    this.openLotteryListBeen,
    this.openLotteryTime,
    this.openLotteryDrawIssue,
  }) : super(key: key);// 是否是 11 选 5


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LotteryTimeNumChildView(
      is11Choice5: is11Choice5,
      isOpenLotteryList: isOpenLotteryList,
      playRemark: playRemark,
      openLotteryListBeen: openLotteryListBeen,
      openLotteryDrawIssue: openLotteryDrawIssue,
      openLotteryTime: openLotteryTime,
    );
  }

}

class LotteryTimeNumChildView extends BaseController<LotteryTimeNumView> {

  bool is11Choice5;//是否是 11 选 5  的开奖View
  bool isOpenLotteryList;// 是否是下拉查看开奖号码
  String playRemark;//玩法说明
  String openLotteryTime;
  String openLotteryDrawIssue;
  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen;
  bool isOpeningLottery = false;//是否正在开奖

  String _timeOpenLotteryTitle = "开奖还剩:";//开奖时间标题
  int openLotteryTitleColor = ColorUtil.textColor_333333;//开奖时间标题颜色
  Timer _countdownTimer;

  LotteryTimeNumChildView({
    this.is11Choice5,
    this.isOpenLotteryList = true,
    this.playRemark,
    this.openLotteryListBeen,
    this.openLotteryTime,
    this.openLotteryDrawIssue,
  });// 是否是 11 选 5

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          _openLotteryTime(context),
          CommonView().commonLine_NoMargin(context),
          _gameItem(),
          CommonView().commonLine_NoMargin(context),

          _dragDownLookLotteryNum(context),

        ],
      ),
    );
  }

  void onSetRefreshLotteryState( bool isOpenLotteryList, String playRemark, List<OpenLotteryListTwoDataListBeen> openLotteryListBeen) {
    this.isOpenLotteryList = isOpenLotteryList;
    this.playRemark = playRemark;
    this.openLotteryListBeen = openLotteryListBeen;

    if (mounted)
      setState(() {

      });
  }

  void onSetRefreshState(String time, String qs) {
    this.openLotteryTime = time;
    this.openLotteryDrawIssue = qs;
    isOpeningLottery = false;
    if (mounted)
      setState(() {

      });
  }

  /**
   * 如果到了开奖时间 显示正在开奖
   */
  void onBeginTimeOpenLottery(bool isBegin) {
    if (isBegin) {
      _timeOpenLotteryTitle = "正在开奖";
      this.openLotteryTime = "";
      openLotteryTitleColor = ColorUtil.textColor_FF8814;
    } else {
      _timeOpenLotteryTitle = "开奖还剩:";
      openLotteryTitleColor = ColorUtil.textColor_333333;
    }

  }

  /// 状态切换改变
  void onBeginTimeOpenLotteryStatusChange(bool isBegin, String qs) {
    if (isBegin) {
      isOpeningLottery = true;
      this.openLotteryDrawIssue = qs;
      _timeOpenLotteryTitle = "正在开奖";
      this.openLotteryTime = "";
      openLotteryTitleColor = ColorUtil.textColor_FF8814;
    }
    if (mounted)
      setState(() {

      });
  }

  int _timerIndex = 1;

  void reGetCountdown() {
    if (_countdownTimer != null) {
      return;
    }
    _countdownTimer =
    new Timer.periodic(new Duration(seconds: 1), (timer) {

      if (_timerIndex == 5) {
        _countdownTimer?.cancel();
        _countdownTimer = null;
        //回调请求接口 下期开奖期数和开奖时间
      }
      _timerIndex++;
    });
  }

  Widget _openLotteryTime(BuildContext context) {
    String titleIssue = "0";
    if (openLotteryDrawIssue != null || openLotteryDrawIssue.length > 0) {
      var length = openLotteryDrawIssue.length;
      titleIssue = "${openLotteryDrawIssue.substring(length - 3, length)}期";
    }
    return new Container(
      padding: EdgeInsets.only(top: 8.0,bottom: 8.0,),
      child: new Stack(
        children: <Widget>[

          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Text(
                "第$titleIssue",
                style: new TextStyle(
                    color: Color(ColorUtil.textColor_333333),
                  fontSize: 14.0,
                ),
              ),

              new Text(
                "$_timeOpenLotteryTitle",
                style: new TextStyle(
                  color: Color(openLotteryTitleColor),
                  fontSize: 14.0,
                ),
              ),

              new Text(
                "$openLotteryTime",
                style: new TextStyle(
                    color: Color(ColorUtil.butColor),
                  fontSize: 14.0,
                ),
              )

            ],
          ),

          new Container(
            padding: EdgeInsets.only(right: 15.0,),
            alignment: Alignment.centerRight,
            child: new GestureDetector(
              onTap: () {
                _reMarkDialog(context);
              },
              child: new Image.asset(ImageUtil.imgBettingCpQuestion, width: 22.0, height: 22.0,),
            ),
          ),

        ],
      ),
    );
  }

  Widget _gameItem() {

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
    if (isOpeningLottery) {
      String titleIssue = "0";
      if (openLotteryDrawIssue != null || openLotteryDrawIssue.length > 0) {
        var length = openLotteryDrawIssue.length;
        titleIssue = "${openLotteryDrawIssue.substring(length - 3, length)}";
        if (titleIssue != null) {
          titleIssue = "${(int.parse(titleIssue) + 1)}";
        }
        if(titleIssue.length == 1) {
          titleIssue = "00$titleIssue";
        }
        if(titleIssue.length == 2) {
          titleIssue = "0$titleIssue";
        }
      }
      return new Container(
        padding: EdgeInsets.only(bottom: 8.0,),
        color: Colors.white,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _num("$titleIssue期"),
            _num("正在开奖"),
          ],
        ),
      );
    }
    return new Container(
      padding: EdgeInsets.only(bottom: 8.0,),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _num(!TextUtil.isEmpty(openLotteryListBeen[0].pre_draw_issue)? openLotteryListBeen[0].pre_draw_issue : ""),
          _numStrList(openLotteryListBeen[0]),

        ],
      ),
    );
  }

  Widget _numStrList(OpenLotteryListTwoDataListBeen dataListBeen) {
    List<Widget> numViewList = new List();
    var pre_draw_code = dataListBeen.pre_draw_code;
    /// 当没有号码是 为正在开奖
    if (TextUtil.isEmpty(pre_draw_code)) {
      return new Text(
        "正在开奖",
        style: new TextStyle(
          color: Color(ColorUtil.butColor),
          fontSize: 14.0,
        ),
      );
    }
    var preListStr = pre_draw_code.split(",");
    preListStr.forEach((valueNum) {
      numViewList.add(_cqNumView(valueNum));

    });
    return new Row(
      children: numViewList,
    );
  }

  /**
   * 11 选 5 的下拉开奖号码列表
   */
  Widget _num(String title) {
    if (openLotteryListBeen != null || openLotteryListBeen.length > 0) {
      var length = title.length;
      title = "${title.substring(length - 2, length)}期";
    }
    return new Container(
      margin: EdgeInsets.only(right: 10.0, top: 8.0),
      alignment: Alignment.center,
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_48D1CC),
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _cqNumView(String num) {

    return new Container(
      height: 25.0,
      width: 25.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.0, top: 8.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Color(ColorUtil.textColor_48D1CC),
        border: new Border.all(color: Color(ColorUtil.textColor_48D1CC), width: 1), // 边色与边宽度
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

  /**
   * 向下拖动查看开奖号码
   */
  Widget _dragDownLookLotteryNum(BuildContext context) {
    return new Visibility(
      visible: isOpenLotteryList,
        child: new Column(
          children: <Widget>[

            new Container(
              alignment: Alignment.center,
              child: new Text(
                "下拉查看开奖号码",
                style: new TextStyle(
                  color: Color(ColorUtil.textColor_FF8814),
                  fontSize: 14.0,
                ),
              ),
            ),

            CommonView().commonLine_NoMargin(context),

          ],
        ),
    );
  }

  /**
   * 玩法说明弹窗
   */
  _reMarkDialog(BuildContext context) {
    if(TextUtil.isEmpty(playRemark)) {
      return;
    }
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Align(
            alignment: Alignment.center,
            child: new Text(
              '玩法说明',
              style: new TextStyle(
                color: Color(ColorUtil.textColor_333333),
                fontSize: 16.0
              ),
            ),
          ),
          children: <Widget>[
            new SimpleDialogOption(
              child:new Align(
                alignment: Alignment.center,
                child: new Text(
                  '$playRemark',
                  style: new TextStyle(
                    color: Color(ColorUtil.textColor_333333),
                    fontSize: 14.0,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });

  }

}