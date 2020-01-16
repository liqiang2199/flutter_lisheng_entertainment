
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/TrendTypeChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/TrendTypeChoiceView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/TrendHanoiOneLotteryHandler.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendCoordinateBeen.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendTypeChoiceStateBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/vietnam_hanoi/trend_json_single/TrendHanoiOneLotterySingleReDataBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'dart:ui' as ui;

/**
 * 越南河内一分彩走势 图
 */
///
class TrendHanoiOneLotteryController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TrendHanoiOneLotteryController();
  }

}

class _TrendHanoiOneLotteryController extends BaseController<TrendHanoiOneLotteryController>
    with AutomaticKeepAliveClientMixin implements TrendHanoiOneLotteryHandler, TrendTypeChoiceInterface{

  List<TrendCoordinateBeen> trendPointList = new List();
  /// 期数 多少选择 30 50 100
  List<bool> numberOfPeriodsNum = [true, false, false];
  List<String> trendTitleList = ["期数", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  List<String> trendTitleSingleDoubleQList = ["期数", "一", "二", "三", "第一位", "第二位", "第三位"];
  List<String> trendTitleFiveList = ["期数", "万", "千", "百", "十", "个", "五星\n和值","和值形态"];
  List<String> trendTitleVariousList = ["期数", "万", "千", "百", "十", "个", "前二\n和值","前三\n和值","中三\n和值","后三\n和值","后二\n和值"];
  List<String> trendTitleVariousSpanList = ["期数", "万", "千", "百", "十", "个", "前二\n跨度","前三\n跨度","中三\n跨度","后三\n跨度","后二\n跨度"];
  /// 默认是单号走势
  String _trendTitleStr = "单号走势_万位";
  String _limitStr = "30";
  String _indexPage = "0";
  bool isLineConnection = true;//是否包含先的连接
  bool isSingleDouble = false;// 是否是单双走势
  bool isMaxMin = false;// 是否是大小走势
  bool isFiveNum = false;// 是否是五星和值
  bool isVariousSum = false;// 是否是各类和值
  bool isVariousSpan = false;// 是否是各类跨度
  bool isDragonTiger = false;// 是否是龙虎和
  int dragonTigerPage = 1;/// 龙虎和下标1（万千 万百）2（万十 万个） 3（千百 千十） 4（千个  百十） 5 （百个 十个）
  int _trendTypeId = 1;

  double numberOfPeriodsLength = 75.0;
  var screenW;

  List<TrendHanoiOneLotterySingleReDataBeen> dataTrendOneLottery = new List();
  int _itemCount = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GameService.instance.hanoiOneOddNumber(this, _limitStr, _indexPage);//单号
//    GameService.instance.hanoiOneMultipleNumbers(this, _limitStr, _indexPage);//多号
//    GameService.instance.hanoiOneSingleDouble(this, _limitStr, _indexPage);//单双
//    GameService.instance.hanoiOneFiveValue(this);//五星和值
//    GameService.instance.hanoiOneVariousSum(this, _limitStr);//各类和值
//    GameService.instance.hanoiOneVariousSpan(this, _limitStr);//各类跨度
//    GameService.instance.hanoiOneDragonTiger(this);//各类跨度
  }

  @override
  Widget build(BuildContext context) {
    trendPointList.clear();
    screenW = (ScreenUtil.getScreenW(context) - numberOfPeriodsLength) / 10 ;

    return new Column(
      children: <Widget>[
        _trendTypeChoice(),
        _trendHeadView(ColorUtil.textColor_FF8814,-1),

        new Expanded(child: isLineConnection ? _list() : _listNoPainter(),),

      ],
    );
  }

  /**
   * 走势类型选择
   */
  ///
  Widget _trendTypeChoice() {

    return new Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0 ,left: 15.0, right: 15.0),
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: new Text(
              _trendTitleStr,
              style: new TextStyle(
                color: Color(ColorUtil.butColor),
                fontSize: 12.0,
              ),
            ),
          ),

          _butNumberOfPeriods("30期", 0),
          _butNumberOfPeriods("50期", 1),
          _butNumberOfPeriods("100期", 2),

          new GestureDetector(
            onTap: () {
              _trendTypeChoiceDialog(context);
            },
            child: new Image.asset(ImageUtil.imgTrendSetChoice, width: 20.0, height: 20.0,),
          ),

        ],
      ),
    );
  }

  /**
   * 期号选择按钮
   */
  ///
  Widget _butNumberOfPeriods(String title, int index) {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 47.0,
        height: 25.0  ,
        margin: EdgeInsets.only(right: 8.0,),
        child: new RaisedButton(onPressed: (){
          //

          for (int i = 0; i < numberOfPeriodsNum.length; i++) {
            numberOfPeriodsNum[i] = false;
          }

          if (index == 0) {
            _limitStr = "30";
          }
          if (index == 1) {
            _limitStr = "50";
          }
          if (index == 2) {
            _limitStr = "100";
          }
          _postHttpTrend();
          numberOfPeriodsNum[index] = true;
          if (mounted)
            setState(() {

            });

        },color: Color(numberOfPeriodsNum[index] ? ColorUtil.butColor: ColorUtil.whiteColor),
          child: new Text(
            title,
            style: TextStyle(
                fontSize: 10.0,
                color: Color(numberOfPeriodsNum[index] ? ColorUtil.whiteColor: ColorUtil.butColor)),
          ),
          //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(ColorUtil.butColor),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.only(left: 5.0,right: 5.0),
        ),
      ),
    );
  }

  Widget _list() {
    return new SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: new Center(
        child: new CustomPaint(
          foregroundPainter: new LinePainter(trendPointList),
          child: new ListView(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            children: _listWidget(),
          ),

        ),
      ),
    );
  }

  Widget _listNoPainter() {
    return new SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: new Center(
        child: new ListView(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          children: _listWidget(),
        ),
      ),
    );
  }


  /// 走势图的头部
  Widget _trendHeadView(int color, int index) {

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: (
                  isSingleDouble | isMaxMin
                      ?  _titleListWidgetSingle(index)
                      : isFiveNum
                      ? _titleListWidgetFive(index)
                      : isVariousSum
                      ? _titleListVariousSum(index)
                      : isVariousSpan
                      ? _titleListVariousSpan(index)
                      : isDragonTiger
                      ? _titleListDragonTiger(index)
                      :_titleListWidget(index)
              ),
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  /// 顶部 （单号， 多号）
  List<Widget> _titleListWidget(int index) {
    List<Widget> list = new List();
    for (int i = 0; i< trendTitleList.length; i++) {
      if (i == 0) {
        list.add(_trendNumberOfPeriodsContent(index, trendTitleList[i]));
        continue;
      }

      list.add(_trendContentExp(1,index, trendTitleList[i]));
    }
    return list;
  }

  /// 顶部 （单双  大小）
  List<Widget> _titleListWidgetSingle(int index) {
    if (_indexPage == "1") {
      trendTitleSingleDoubleQList = ["期数", "一", "二", "三", "第一位", "第二位", "第三位"];
    } else {
      trendTitleSingleDoubleQList = ["期数", "三", "四", "五", "第一位", "第二位", "第三位"];
    }
    List<Widget> list = new List();
    for (int i = 0; i< trendTitleSingleDoubleQList.length; i++) {
      if (i == 0) {
        list.add(_trendNumberOfPeriodsContent(index, trendTitleSingleDoubleQList[i]));
        continue;
      }

      if (i == 1 || i == 2 || i == 3) {
        list.add(_trendContentExp(1,index, trendTitleSingleDoubleQList[i]));
        continue;
      }
      list.add(_trendContentExp(2,index, trendTitleSingleDoubleQList[i]));
    }
    return list;
  }

  /// 顶部 （五星和值）
  List<Widget> _titleListWidgetFive(int index) {
    List<Widget> list = new List();
    for (int i = 0; i< trendTitleFiveList.length; i++) {
      if (i == 0) {
        list.add(_trendNumberOfPeriodsContent(index, trendTitleFiveList[i]));
        continue;
      }

      if (i <=6) {
        list.add(_trendContentExp(1,index, trendTitleFiveList[i]));
        continue;
      }
      list.add(_trendContentExp(4,index, trendTitleFiveList[i]));
    }
    return list;
  }

  /// 顶部 （各类和值）
  List<Widget> _titleListVariousSum(int index) {
    List<Widget> list = new List();
    for (int i = 0; i< trendTitleVariousList.length; i++) {
      if (i == 0) {
        list.add(_trendNumberOfPeriodsContent(index, trendTitleVariousList[i]));
        continue;
      }
      list.add(_trendContentExp(1,index, trendTitleVariousList[i]));
    }
    return list;
  }

  /// 顶部 （各类跨度）
  List<Widget> _titleListVariousSpan(int index) {
    List<Widget> list = new List();
    for (int i = 0; i< trendTitleVariousSpanList.length; i++) {
      if (i == 0) {
        list.add(_trendNumberOfPeriodsContent(index, trendTitleVariousSpanList[i]));
        continue;
      }
      list.add(_trendContentExp(1,index, trendTitleVariousSpanList[i]));
    }
    return list;
  }

  /// 顶部 （龙虎和）
  List<Widget> _titleListDragonTiger(int index) {
    List<String> titleList = new List();
    switch (dragonTigerPage) {
      case 1:
        titleList = ["期数", "万", "千", "龙", "虎", "和", "万", "百", "龙", "虎", "和",];
        break;
      case 2:
        titleList = ["期数", "万", "十", "龙", "虎", "和", "万", "个", "龙", "虎", "和",];
        break;
      case 3:
        titleList = ["期数", "千", "百", "龙", "虎", "和", "千", "十", "龙", "虎", "和",];
        break;
      case 4:
        titleList = ["期数", "千", "个", "龙", "虎", "和", "百", "十", "龙", "虎", "和",];
        break;
      case 5:
        titleList = ["期数", "百", "个", "龙", "虎", "和", "十", "个", "龙", "虎", "和",];
        break;
    }
    List<Widget> list = new List();
    for (int i = 0; i< titleList.length; i++) {
      if (i == 0) {
        list.add(_trendNumberOfPeriodsContent(index, titleList[i]));
        continue;
      }
      list.add(_trendContentExp(1,index, titleList[i]));
    }
    return list;
  }

  /// 动态添加走势列表
  List<Widget> _listWidget() {
    List<Widget> list = new List();
    if (isLineConnection) {
      /// （单号走势）
      for (int i = 0; i< _itemCount; i++) {
        var pre_draw_issue = dataTrendOneLottery[i].pre_draw_issue;
        var substringL1 = pre_draw_issue.substring(4, pre_draw_issue.length);
        var substringL2 = substringL1.substring(substringL1.length - 4, substringL1.length);
        var substringL3 = substringL1.substring(0, substringL1.length-4);
        list.add( _trendContentView(ColorUtil.whiteColor, i, "$i", "$substringL3-$substringL2期"));
      }
    } else {
      if (isSingleDouble || isMaxMin) {
        /// （单双走势）
        for (int i = 0; i< _itemCount; i++) {
          var pre_draw_issue = dataTrendOneLottery[i].pre_draw_issue;
          var substringL1 = pre_draw_issue.substring(4, pre_draw_issue.length);
          var substringL2 = substringL1.substring(substringL1.length - 4, substringL1.length);
          var substringL3 = substringL1.substring(0, substringL1.length-4);
          list.add( _trendContentSingleDoubleView(ColorUtil.whiteColor, i, "$i"
              , "$substringL3-$substringL2期", dataTrendOneLottery[i].singleDoubleNum, dataTrendOneLottery[i].singleDoubleStr));
        }
      } else {
        if (isFiveNum) {
          /// （多号走势）
          for (int i = 0; i< _itemCount; i++) {
            var pre_draw_issue = dataTrendOneLottery[i].pre_draw_issue;
            var substringL1 = pre_draw_issue.substring(4, pre_draw_issue.length);
            var substringL2 = substringL1.substring(substringL1.length - 4, substringL1.length);
            var substringL3 = substringL1.substring(0, substringL1.length-4);
            list.add( _trendContentFiveSumView(ColorUtil.whiteColor, i, "$i"
                , "$substringL3-$substringL2期", dataTrendOneLottery[i].pre_draw_code,
                dataTrendOneLottery[i].sum, dataTrendOneLottery[i].dx, dataTrendOneLottery[i].ds));
          }
        } else {

          if (isVariousSum || isVariousSpan) {
            /// 各类和值 跨度
            for (int i = 0; i< _itemCount; i++) {
              var pre_draw_issue = dataTrendOneLottery[i].pre_draw_issue;
              var substringL1 = pre_draw_issue.substring(4, pre_draw_issue.length);
              var substringL2 = substringL1.substring(substringL1.length - 4, substringL1.length);
              var substringL3 = substringL1.substring(0, substringL1.length-4);
              list.add( _trendContentVariousTypeSumView(ColorUtil.whiteColor, i, "$i"
                  , "$substringL3-$substringL2期", dataTrendOneLottery[i].pre_draw_code,
                  dataTrendOneLottery[i].qe, dataTrendOneLottery[i].qs, dataTrendOneLottery[i].zs, dataTrendOneLottery[i].hs, dataTrendOneLottery[i].he));
            }
          } else {
            if (isDragonTiger) {
              /// 龙虎和
              for (int i = 0; i< _itemCount; i++) {
                var pre_draw_issue = dataTrendOneLottery[i].pre_draw_issue;
                var substringL1 = pre_draw_issue.substring(4, pre_draw_issue.length);
                var substringL2 = substringL1.substring(substringL1.length - 4, substringL1.length);
                var substringL3 = substringL1.substring(0, substringL1.length-4);
                list.add( _trendContentDragonTigerView(ColorUtil.whiteColor, i, "$i", "$substringL3-$substringL2期", dataTrendOneLottery[i]));
              }
            } else {
              /// （多号走势）
              for (int i = 0; i< _itemCount; i++) {
                //dataTrendOneLottery[i].num
                var pre_draw_issue = dataTrendOneLottery[i].pre_draw_issue;
                var substringL1 = pre_draw_issue.substring(4, pre_draw_issue.length);
                var substringL2 = substringL1.substring(substringL1.length - 4, substringL1.length);
                var substringL3 = substringL1.substring(0, substringL1.length-4);
                list.add( _trendMoreContentView(ColorUtil.whiteColor, i, "$i", "$substringL3-$substringL2期", dataTrendOneLottery[i].moreNum));
              }
            }

          }

        }

      }

    }

    return list;
  }

  /// 走势图的头 （单号走势）
  Widget _trendContentView(int color, int index, String title, String qs) {
    if (index != -1) {
      var randomNext = int.parse(dataTrendOneLottery[index].num);
      var trendCoordinateBeen = new TrendCoordinateBeen(
          screenW / 2 + (screenW * (randomNext) + numberOfPeriodsLength ) ,
          10.0 + ((index) * 20.0));
      trendCoordinateBeen.indexNum = "$randomNext";
      trendPointList.add(trendCoordinateBeen);
    }

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: <Widget>[
                _trendNumberOfPeriodsContent(index, qs),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),
                _trendContentExp(1,index, title),

              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  /// 走势图的头 （单双走势）
  Widget _trendContentSingleDoubleView(int color, int index, String title, String qs,List<String> singleNum, List<String> singleNumStr) {

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: <Widget>[
                _trendNumberOfPeriodsContent(index, qs),
                new Expanded(
                    child: new Row(
                      children: _singleDoubleRowView(index, singleNum, singleNumStr),
                    ),
                ),

              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  /// 单双
  List<Widget> _singleDoubleRowView(int index, List<String> singleNum, List<String> singleNumStr) {
    List<Widget> _singleListView = new List();
    for (int i = 0; i < singleNum.length;i ++) {
      _singleListView.add( _trendSingleDoubleContent(1,index, singleNum[i], false, false));
    }

    for (int i = 0; i < singleNumStr.length;i ++) {
      var singleNumEx = singleNumStr[i];
      bool single = false;
      bool isBg = true;
      String title = "0";
      if (singleNumEx == "单" || singleNumEx == "小") {
        single = true;
      } else {
        single = false;
      }
      if (i == 0) {

        _singleListView.add(_trendSingleDoubleContent(1,index,  single ? "0" : singleNumEx, single, single ? false : true));//单
        _singleListView.add( _trendSingleDoubleContent(1,index, single ? singleNumEx : "0", single, single ? true : false));//双
      }

      if (i == 1) {

        _singleListView.add(_trendSingleDoubleContent(1,index,  single ? "0" : singleNumEx, single, single ? false : true));//单
        _singleListView.add(_trendSingleDoubleContent(1,index, single ? singleNumEx : "0", single, single ? true : false));//双
      }

      if (i == 2) {

        _singleListView.add(_trendSingleDoubleContent(1,index,  single ? "0" : singleNumEx, single, single ? false : true));//单
        _singleListView.add(_trendSingleDoubleContent(1,index, single ? singleNumEx : "0", single, single ? true : false));//双
      }

    }

    return _singleListView;
  }

  /// 走势图的 (多号走势)
  Widget _trendMoreContentView(int color, int index, String title, String qs, List<String> numStr) {


    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: <Widget>[
                _trendNumberOfPeriodsContent(index, qs),

                new Expanded(
                    child: new Row(
                      children: _trendMoreContentNumListView(color, index, title, numStr),
                    ),
                ),


              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  List<Widget> _trendMoreContentNumListView(int color, int index, String title,List<String> numStr) {
    List<Widget> _trendMoreContentList = new List();
    var length = numStr.length;
    for (int i = 0; i < 10; i++) {
      bool vi = false;
      String num = "0";
      for (int n = 0; n < length; n++) {
        var numS = numStr[n];
        if ("$i" == numS) {
          vi = true;
          num = numS;
          break;
        }
      }

      _trendMoreContentList.add(_trendContentExpStack(1,index, num,vi));
    }

    return _trendMoreContentList;
  }


  /// 走势图的头 （五星和值走势）
  Widget _trendContentFiveSumView(int color, int index, String title, String qs, String draw_code, String sum, String dx, String ds) {

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: <Widget>[
                _trendNumberOfPeriodsContent(index, qs),
                new Expanded(
                  child: new Row(
                    children: _fiveSumRowView(index, draw_code, sum, dx, ds),
                  ),
                ),

              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  /// 五星和值 sum: 14,
  //				ds: 双,
  //				dx: 小,
  List<Widget> _fiveSumRowView(int index, String draw_code, String sum, String dx, String ds) {
    List<Widget> _fiveSumListView = new List();

    List<String> codeNumList = draw_code.split(",");
    for (int i = 0; i < codeNumList.length;i ++) {
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, codeNumList[i], false, false));
    }

    _fiveSumListView.add( _trendSingleDoubleContent(1,index, sum, false, false));

    if (dx == "大") {
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  dx, true, true));//大
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//小
    } else {

      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//大
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  dx, true, true));//小
    }

    if (ds == "单") {
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  ds, true, true));//单
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//双
    } else {

      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//单
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  ds, true, true));//双
    }


    return _fiveSumListView;
  }


  /// 走势图的头 （各类 和值）
  Widget _trendContentVariousTypeSumView(int color, int index, String title, String qs, String draw_code, String qe, String qss, String zs, String hs, String he) {

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: <Widget>[
                _trendNumberOfPeriodsContent(index, qs),
                new Expanded(
                  child: new Row(
                    children: _variousTypeRowView(index, draw_code, qe, qss, zs, hs, he),
                  ),
                ),

              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  /// 各类和值
  List<Widget> _variousTypeRowView(int index, String draw_code, String qe, String qss, String zs, String hs, String he) {
    List<Widget> _fiveSumListView = new List();

    List<String> codeNumList = draw_code.split(",");
    for (int i = 0; i < codeNumList.length;i ++) {
      _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[i], 0, false));
    }

    _fiveSumListView.add( _trendVariousTypeContent(1,index, qe, ColorUtil.bgColor_E7242C, true));
    _fiveSumListView.add( _trendVariousTypeContent(1,index, qss, ColorUtil.bgColor_FAA139, true));
    _fiveSumListView.add( _trendVariousTypeContent(1,index, zs, ColorUtil.bgColor_B0B0B0, true));
    _fiveSumListView.add( _trendVariousTypeContent(1,index, hs, ColorUtil.textColor_48D1CC, true));
    _fiveSumListView.add( _trendVariousTypeContent(1,index, he, ColorUtil.textColor_1396DA, true));

    return _fiveSumListView;
  }


  /// 走势图的头 （龙虎和）
  Widget _trendContentDragonTigerView(int color, int index, String title, String qs, TrendHanoiOneLotterySingleReDataBeen singleReDataBeen) {

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: <Widget>[
                _trendNumberOfPeriodsContent(index, qs),
                new Expanded(
                  child: new Row(
                    children: _dragonTigerRowView(index, singleReDataBeen),
                  ),
                ),

              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  /// 龙虎和 8, 0
  //				7, 1
  //				7, 2
  //				7, 3
  //				5 4
  List<Widget> _dragonTigerRowView(int index, TrendHanoiOneLotterySingleReDataBeen singleReDataBeen) {
    List<Widget> _fiveSumListView = new List();

    List<String> codeNumList = singleReDataBeen.pre_draw_code.split(",");
    bool isDragon = false;
    bool isTiger = false;
    bool isAnd = false;

    switch(dragonTigerPage) {
      case 1:
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.wq);

        isDragon = false;
        isTiger = false;
        isAnd = false;
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));
        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.wb);
        break;

      case 2:
        // 万十 万个
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.ws);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.wg);
        break;
      case 3:
        // 千百 千十
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.qb);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.qs);
        break;
      case 4:
        // 千个 百十
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.qg);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.bs);
        break;
      case 5:
        // 百个  十个
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.bg);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.sg);
        break;
    }


    return _fiveSumListView;
  }

  _addDragonTigerList(int index, List<Widget> _fiveSumListView, bool isDragon, bool isTiger, bool isAnd, String dragonTigerEx) {
    isDragon = false;
    isTiger = false;
    isAnd = false;
    isDragon = dragonTigerEx == "龙";
    isTiger = dragonTigerEx == "虎";
    isAnd = dragonTigerEx == "和";

    _fiveSumListView.add( _trendVariousTypeContent(1,index, isDragon ? dragonTigerEx : "0" , ColorUtil.bgColor_E7242C, isDragon));// 龙
    _fiveSumListView.add( _trendVariousTypeContent(1,index, isTiger ? dragonTigerEx : "0", ColorUtil.bgColor_FAA139, isTiger));// 虎
    _fiveSumListView.add( _trendVariousTypeContent(1,index, isAnd ? dragonTigerEx : "0", ColorUtil.textColor_48D1CC, isAnd));// 和
  }

  /// 单号走势
  Widget _trendContentExp(int flex, int index, String title) {

    return new Expanded(
        child: _trendContent(index, title, false),
      flex: flex,
    );
  }

  /// 多号走势
  Widget _trendContentExpStack(int flex, int index, String title, bool visible) {

    return new Expanded(
      child: _trendContentMore(index, title, visible),
      flex: flex,
    );
  }

  /// 显示期数
  Widget _trendNumberOfPeriodsContent(int index, String title) {

    return new Container(
      width: numberOfPeriodsLength,
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: new Align(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: new TextStyle(
                  color: Color(ColorUtil.textColor_888888),
                  fontSize: 12.0,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  /// 单双走势 内容
  Widget _trendSingleDoubleContent(int flex, int index, String title, bool isSingle, bool isBg) {

    return new Expanded(
      child: _trendContentSingleView(index, title, isSingle, isBg),
      flex: flex,
    );
  }

  /// 各类 走势 内容
  Widget _trendVariousTypeContent(int flex, int index, String title, int colorBg, bool isBg) {

    return new Expanded(
      child: _trendContentVariousTypeView(index, title, colorBg, isBg),
      flex: flex,
    );
  }


  /// 每格内容
  Widget _trendContent(int index, String title, bool visible) {

    return new Row(
      children: <Widget>[
        CommonView().commonLineW(context),

        new Expanded(
            child: new Align(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: new TextStyle(
                  color: Color(ColorUtil.textColor_888888),
                  fontSize: 12.0,
                ),
              ),
            ),
        ),

      ],
    );
  }

  /// 单双每格内容
  Widget _trendContentSingleView(int index, String title, bool isSingle, bool isBg) {

    return new Row(
      children: <Widget>[
        CommonView().commonLineW(context),

        new Expanded(
          child: new Align(
            alignment: Alignment.center,
            child: new Container(
              alignment: Alignment.center,
              width: ScreenUtil.getScreenW(context),
              color: Color(isBg ? isSingle ? ColorUtil.textColor_FF5B62 : ColorUtil.textColor_48D1CC : ColorUtil.whiteColor),
              child:  new Text(
                TextUtil.isEmpty(title) ? "0" : title,
                style: new TextStyle(
                  color: Color(isBg ? ColorUtil.whiteColor : ColorUtil.textColor_888888),
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  /// 各类 (和值  跨度) 每格内容
  Widget _trendContentVariousTypeView(int index, String title, int colorBg, bool isBg) {

    return new Row(
      children: <Widget>[
        CommonView().commonLineW(context),

        new Expanded(
          child: new Align(
            alignment: Alignment.center,
            child: new Container(
              alignment: Alignment.center,
              width: ScreenUtil.getScreenW(context),
              color: Color(isBg ? colorBg : ColorUtil.whiteColor),
              child:  new Text(
                title,
                style: new TextStyle(
                  color: Color(isBg ? ColorUtil.whiteColor : ColorUtil.textColor_888888),
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  /// 多号 每格内容
  Widget _trendContentMore(int index, String title, bool visible) {

    return new Row(
      children: <Widget>[
        CommonView().commonLineW(context),

        new Expanded(
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[

              new Container(
                child: new Align(
                  alignment: Alignment.center,
                  child: new Text(
                    title,
                    style: new TextStyle(
                      color: Color(ColorUtil.textColor_888888),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),

              _trendMarkContent(title, visible),

            ],
          ),
        ),

      ],
    );
  }

  /// 多选是显示期数
  Widget _trendMarkContent(String num, bool visible) {
    return new Align(
      alignment: Alignment.center,
      child: new Visibility(
        visible: visible,
        child: new Container(
          height: 30.0,
          width: 30.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Color(ColorUtil.bgColor_E7242C),
            border: new Border.all(
              color: Color(ColorUtil.bgColor_E7242C ),
              width: 1,
            ), // 边色与边宽度
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
        ),
      ),
    );
  }

  /**
   * 走势类型选择弹窗
   */
  ///
  _trendTypeChoiceDialog(BuildContext context) {

    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new TrendTypeChoiceView(
          lotteryID: "9",
          choiceInterface: this,
          trendTypeId: _trendTypeId,
          indexPage: _indexPage,
        );
      },
    ).then((val) {
      print(val);
    });

  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  /// 单号走势
  @override
  void setTrendSingleOneLotteryBeen(List<TrendHanoiOneLotterySingleReDataBeen> re_data) {
    _itemCount = re_data.length;
    dataTrendOneLottery = re_data;
    setState(() {

    });
  }

  @override
  void setTrendTypeChoiceStateBeen(TrendTypeChoiceStateBeen stateBeen) {
    dataTrendOneLottery.clear();
    trendPointList.clear();
    _indexPage = stateBeen.indexPage;
    isLineConnection = stateBeen.isLineConnection;//是否包含先的连接
    isSingleDouble = stateBeen.isSingleDouble;// 是否是单双走势
    isFiveNum = stateBeen.isFiveNum;// 是否是五星和值
    isVariousSum = stateBeen.isVariousSum;// 是否是各类和值
    isVariousSpan = stateBeen.isVariousSpan;// 是否是各类跨度
    isDragonTiger = stateBeen.isDragonTiger;// 是否是龙虎和
    dragonTigerPage = stateBeen.dragonTigerPage;
    isMaxMin = stateBeen.isMaxMin;
    _trendTitleStr = stateBeen.trendTitleStr;//标题
    _trendTypeId = stateBeen.trendTypeId;

    _postHttpTrend();

  }

  /// 请求
  _postHttpTrend() {
    if (isLineConnection) {
      GameService.instance.hanoiOneOddNumber(this, _limitStr, _indexPage);///单号
    } else {
      if (isSingleDouble || isMaxMin) {

        if (isMaxMin) {
          GameService.instance.hanoiOneMaxMin(this, _limitStr, _indexPage);//大小
        } else {
          GameService.instance.hanoiOneSingleDouble(this, _limitStr, _indexPage);//单双
        }

      } else {
        if (isFiveNum) {
          GameService.instance.hanoiOneFiveValue(this);//五星和值
        } else {

          if (isVariousSum || isVariousSpan) {
            if (isVariousSum) {
              GameService.instance.hanoiOneVariousSum(this, _limitStr);//各类和值
            } else {
              GameService.instance.hanoiOneVariousSpan(this, _limitStr);//各类跨度
            }
          } else {
            if (isDragonTiger) {
              GameService.instance.hanoiOneDragonTiger(this);//龙虎和
            } else {
              GameService.instance.hanoiOneMultipleNumbers(this, _limitStr, _indexPage);//多号
            }

          }

        }
      }
    }
  }

}

class LinePainter extends CustomPainter {

  List<TrendCoordinateBeen> trendPointList = new List();
  ui.Paragraph paragraph;
  ui.ParagraphBuilder paragraphBuilder;
  double textWidth = 20;
  double textFontSize = 10.0;

  LinePainter(this.trendPointList) {
   paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: textFontSize,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
            color: Colors.white, textBaseline: ui.TextBaseline.alphabetic),
      );

    paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: textWidth));
  }


  Paint _paint = new Paint()
  ..color = Color(ColorUtil.butColor_EB303B)
  ..strokeCap = StrokeCap.round
  ..isAntiAlias = true
  ..strokeWidth = 2.0
  ..style = PaintingStyle.fill
    ///Flutter BlendMode混合模式详解
  ..blendMode = BlendMode.dstATop;

  @override
  void paint(Canvas canvas, Size size) {
    if (trendPointList.length >= 2) {
      _paint.color = Color(ColorUtil.butColor_EB303B);
      canvas.drawCircle(Offset(trendPointList[0].dx, trendPointList[0].dy), 10, _paint);
      paragraphBuilder.addText(trendPointList[0].indexNum);
      paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: textWidth));
      canvas.drawParagraph(paragraph, Offset(trendPointList[0].dx - textWidth /2,trendPointList[0].dy - 5));

      for (int i = 0; i < trendPointList.length - 1; i++) {

        canvas.drawCircle(Offset(trendPointList[i + 1].dx, trendPointList[i + 1].dy), 10, _paint);
        print("坐标 数值 ： ${trendPointList[i].indexNum}");
        _paint.color = Color(ColorUtil.whiteColor);
        paragraphBuilder.addText(trendPointList[i + 1].indexNum);
        paragraph = paragraphBuilder.build()
          ..layout(ui.ParagraphConstraints(width: textWidth));
        canvas.drawParagraph(paragraph, Offset(trendPointList[i + 1].dx - textWidth /2,trendPointList[i + 1].dy - 5));

        _paint.color = Color(ColorUtil.butColor_EB303B);
        canvas.drawLine( Offset(trendPointList[i].dx , trendPointList[i].dy ),
            Offset(trendPointList[i + 1].dx, trendPointList[i + 1].dy ), _paint);

      }
    }


  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return false;
  }
}