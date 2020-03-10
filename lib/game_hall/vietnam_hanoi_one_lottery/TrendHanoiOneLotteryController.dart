
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

  List<int> occurrencesNum = [0,0,0,0,0,0,0,0,0,0];//出现次数
  List<int> maximumOutput = [0,0,0,0,0,0,0,0,0,0];//最大连出数
  /// 多号
  List<int> maximumOutputOld = [0,0,0,0,0,0,0,0,0,0];//最大连出数
  List<int> maximumOmission = [0,0,0,0,0,0,0,0,0,0];//最大遗漏
  List<int> maximumOmissionC = [0,0,0,0,0,0,0,0,0,0];//当前最大遗漏
  List<int> maximumOmissionAverage = [0,0,0,0,0,0,0,0,0,0];//平均遗漏（当前期数/ 出现次数）
  /// 多号
  List<int> maximumOutputCurrentList = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];//当前最大连出数
//  List<int> maximumOutputOldList = [0,0,0,0,0,0,0,0,0,0];//当前最大连出数

  List<int> averageOmission = [];//平均遗漏
  int maximumOutputCurrent = 0;// 当前连出数

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

  GlobalKey linePainterKey = GlobalKey();//测试画线


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GameService.instance.hanoiOneOddNumber(this, _limitStr, _indexPage);//单号
//    GameService.instance.hanoiOneMultipleNumbers(this, _limitStr, _indexPage);//多号
//    GameService.instance.hanoiOneSingleDouble(this, _limitStr, _indexPage);//单双
//    GameService.instance.hanoiOneFiveValue(this, _limitStr);//五星和值
//    GameService.instance.hanoiOneVariousSum(this, _limitStr);//各类和值
//    GameService.instance.hanoiOneVariousSpan(this, _limitStr);//各类跨度
//    GameService.instance.hanoiOneDragonTiger(this);//龙虎和

  }

  @override
  Widget build(BuildContext context) {
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
          trendPointList.clear();
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
          key: linePainterKey,
          foregroundPainter: new LinePainter(trendPointList),
          isComplex: true,
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
      height: 25.0,
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

  /// 出现次数
  List<Widget> _occurrencesNumListWidget(int index, String title, List<int> numInt, int colorID) {
    List<Widget> list = new List();
    list.add(_trendNumberOfPeriodsContentColor(0, title,colorID));
    for(int ocNum = 0; ocNum < numInt.length; ocNum++) {
      var numIntStr = numInt[ocNum];
      list.add(_trendContentColor(1,ocNum, "${numIntStr == 0 ?"" : numIntStr == -1 ? "" : numIntStr}", colorID));
    }
    return list;
  }

  _starLastData() {
    occurrencesNum = [0,0,0,0,0,0,0,0,0,0];//出现次数
    maximumOutput = [0,0,0,0,0,0,0,0,0,0];//最大连出数
    maximumOutputCurrentList = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];//当前最大连出数
    maximumOmission = [0,0,0,0,0,0,0,0,0,0];//最大遗漏
    maximumOmissionC = [0,0,0,0,0,0,0,0,0,0];//当前最大遗漏
    maximumOmissionAverage = [0,0,0,0,0,0,0,0,0,0];
  }

  /// 单双， 大小
  _singleLastData() {
    occurrencesNum = [-1,-1,-1,0,0,0,0,0,0];//出现次数
    maximumOutput = [-1,-1,-1,0,0,0,0,0,0];//最大连出数
    maximumOutputCurrentList = [-1,-1,-1,-1,-1,-1,-1,-1,-1];//当前最大连出数
    maximumOmission = [-1,-1,-1,0,0,0,0,0,0];//最大遗漏
    maximumOmissionC = [-1,-1,-1,0,0,0,0,0,0];//当前最大遗漏
    maximumOmissionAverage = [0,0,0,0,0,0,0,0,0];
  }

  /// 和值 出现次数
  _andSumLastData() {
    occurrencesNum = [-1,-1,-1,-1,-1,-1,0,0,0,0];//出现次数
    maximumOutput = [-1,-1,-1,-1,-1,-1,0,0,0,0];//最大连出数
    maximumOutputCurrentList = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];//当前最大连出数
    maximumOmission = [-1,-1,-1,-1,-1,-1,0,0,0,0];//最大遗漏
    maximumOmissionC = [-1,-1,-1,-1,-1,-1,0,0,0,0];//当前最大遗漏
    maximumOmissionAverage = [0,0,0,0,0,0,0,0,0,0];
  }

  /// 龙虎和
  _dragonTigerLastData() {
    occurrencesNum = [-1,-1,0,0,0,-1,-1,0,0,0];//出现次数
    maximumOutput = [-1,-1,0,0,0,-1,-1,0,0,0];//最大连出数
    maximumOutputCurrentList = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];//当前最大连出数
    maximumOmission = [-1,-1,0,0,0,-1,-1,0,0,0];//最大遗漏
    maximumOmissionC = [-1,-1,0,0,0,-1,-1,0,0,0];//当前最大遗漏
    maximumOmissionAverage = [-1,-1,0,0,0,-1,-1,0,0,0];
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
        var parse = int.parse(dataTrendOneLottery[i].num);
        occurrencesNum[parse]++;//出现次数
        // 最大连出

        if(maximumOutputCurrent == parse) {
          maximumOutput[parse]++;
        } else {
          if (maximumOutput[parse] <= 1) {
            maximumOutput[parse] = 1;
          }
        }
        maximumOutputCurrent = parse;

        for(int maxNum = 0; maxNum < maximumOmission.length; maxNum++) {
          if(maximumOmission[maxNum] != 0 && maximumOmissionC[maxNum] < maximumOmission[maxNum]) {
            maximumOmissionC[maxNum] = maximumOmission[maxNum];
          }
          if (parse == maxNum) {
            maximumOmission[maxNum] = 0;
          } else {
            maximumOmission[maxNum]++;
          }
        }

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

    if (!isVariousSum || !isVariousSpan) {
      /// 各类和值 各类跨度 不显示
      list.add(new Container(
        height: 25.0,
        child: new Row(
          children: _occurrencesNumListWidget(-1, "出现次数", occurrencesNum, ColorUtil.textColor_48D1CC),
        ),
      ));

      list.add(CommonView().commonLine_NoMargin(context));

      list.add(new Container(
        height: 25.0,
        child: new Row(
          children: _occurrencesNumListWidget(-1, "最大连出", maximumOutput, ColorUtil.textColor_FF8814),
        ),
      ));
      list.add(CommonView().commonLine_NoMargin(context));
      //maximumOmission
      list.add(new Container(
        height: 25.0,
        child: new Row(
          children: _occurrencesNumListWidget(-1, "最大遗漏", maximumOmissionC, ColorUtil.textColor_1396DA),
        ),
      ));
      list.add(CommonView().commonLine_NoMargin(context));

      for (int i = 0; i < occurrencesNum.length; i++) {
        // 平均值
        if (TextUtil.isEmpty(_limitStr)) {
          break;
        }
        var occurrencesNumIndex = occurrencesNum[i];
        if (occurrencesNumIndex == -1 || occurrencesNumIndex == 0) {
          continue;
        }
        var average = (int.parse(_limitStr)/ occurrencesNum[i]).floor();

        maximumOmissionAverage[i] = average;
      }
      list.add(new Container(
        height: 25.0,
        child: new Row(
          children: _occurrencesNumListWidget(-1, "平均遗漏", maximumOmissionAverage, ColorUtil.textColor_FF5B62),
        ),
      ));
      list.add(CommonView().commonLine_NoMargin(context));
    }


    return list;
  }

  /// 走势图的头 （单号走势）
  Widget _trendContentView(int color, int index, String title, String qs) {
    if (index != -1) {
//      var randomNext = int.parse(dataTrendOneLottery[index].num);
//      var trendCoordinateBeen = new TrendCoordinateBeen(
//          screenW / 2 + (screenW * (randomNext) + numberOfPeriodsLength ) ,
//          12.0 + ((index) * 25.0));
//      trendCoordinateBeen.indexNum = "$randomNext";
//      trendPointList.add(trendCoordinateBeen);
    }


    return new Container(
      height: 25.0,
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
      height: 25.0,
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
      if (singleNumEx == "单" || singleNumEx == "小") {
        single = true;
      } else {
        single = false;
      }

      if (i == 0) {
        /// 第一位
        if(maximumOutputCurrentList[3] > maximumOutput[3]) {
          maximumOutput[3] = maximumOutputCurrentList[3];
        }
        if(maximumOutputCurrentList[4] > maximumOutput[4]) {
          maximumOutput[4] = maximumOutputCurrentList[4];
        }
        if (maximumOmission[3] > maximumOmissionC[3]) {
          maximumOmissionC[3] = maximumOmission[3];
        }
        if (maximumOmission[4] > maximumOmissionC[4]) {
          maximumOmissionC[4] = maximumOmission[4];
        }
        if (single) {
          occurrencesNum[4]++;
          maximumOutputCurrentList[4]++;
          maximumOutputCurrentList[3] = 0;
          maximumOmission[3]++;
          maximumOmission[4] = 0;
        } else {
          occurrencesNum[3]++;
          maximumOutputCurrentList[3]++;
          maximumOutputCurrentList[4] = 0;
          maximumOmission[4]++;
          maximumOmission[3] = 0;
        }
        _singleListView.add(_trendSingleDoubleContent(1,index,  single ? "0" : singleNumEx, single, single ? false : true));//单
        _singleListView.add( _trendSingleDoubleContent(1,index, single ? singleNumEx : "0", single, single ? true : false));//双
      }

      if (i == 1) {
        /// 第二位
        if(maximumOutputCurrentList[5] > maximumOutput[5]) {
          maximumOutput[5] = maximumOutputCurrentList[5];
        }
        if(maximumOutputCurrentList[6] > maximumOutput[6]) {
          maximumOutput[6] = maximumOutputCurrentList[6];
        }
        if (maximumOmission[5] > maximumOmissionC[5]) {
          maximumOmissionC[5] = maximumOmission[5];
        }
        if (maximumOmission[6] > maximumOmissionC[6]) {
          maximumOmissionC[6] = maximumOmission[6];
        }
        if (single) {
          occurrencesNum[6]++;
          maximumOutputCurrentList[6]++;
          maximumOutputCurrentList[5] = 0;
          maximumOmission[5]++;
          maximumOmission[6] = 0;
        } else {
          occurrencesNum[5]++;
          maximumOutputCurrentList[5]++;
          maximumOutputCurrentList[6] = 0;
          maximumOmission[6]++;
          maximumOmission[5] = 0;
        }
        _singleListView.add(_trendSingleDoubleContent(1,index,  single ? "0" : singleNumEx, single, single ? false : true));//单
        _singleListView.add(_trendSingleDoubleContent(1,index, single ? singleNumEx : "0", single, single ? true : false));//双
      }

      if (i == 2) {
        /// 第三位

        if(maximumOutputCurrentList[7] > maximumOutput[7]) {
          maximumOutput[7] = maximumOutputCurrentList[7];
        }
        if(maximumOutputCurrentList[8] > maximumOutput[8]) {
          maximumOutput[8] = maximumOutputCurrentList[8];
        }
        if (maximumOmission[7] > maximumOmissionC[7]) {
          maximumOmissionC[7] = maximumOmission[7];
        }
        if (maximumOmission[8] > maximumOmissionC[8]) {
          maximumOmissionC[8] = maximumOmission[8];
        }
        if (single) {
          occurrencesNum[8]++;
          maximumOutputCurrentList[8]++;
          maximumOutputCurrentList[7] = 0;
          maximumOmission[7]++;
          maximumOmission[8] = 0;
        } else {
          occurrencesNum[7]++;
          maximumOutputCurrentList[7]++;
          maximumOutputCurrentList[8] = 0;
          maximumOmission[8]++;
          maximumOmission[7] = 0;
        }
        _singleListView.add(_trendSingleDoubleContent(1,index,  single ? "0" : singleNumEx, single, single ? false : true));//单
        _singleListView.add(_trendSingleDoubleContent(1,index, single ? singleNumEx : "0", single, single ? true : false));//双
      }

    }

    return _singleListView;
  }

  /// 走势图的 (多号走势)
  Widget _trendMoreContentView(int color, int index, String title, String qs, List<String> numStr) {


    return new Container(
      height: 25.0,
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

  String _currentMoreNumText = "-1";//多号时 表示当前的数字 每行 每列 的数字

  List<Widget> _trendMoreContentNumListView(int color, int index, String title,List<String> numStr) {
    List<Widget> _trendMoreContentList = new List();
    //对应的位置
    List<int> _trendMoreContentSmallInt = [0,0,0,0,0,0,0,0,0,0];
    var length = numStr.length;
    maximumOutputCurrentList = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
    int _currentMoreNumPage = 1;
    for (int i = 0; i < 10; i++) {
      bool vi = false;
      String num = "0";

      for (int n = 0; n < length; n++) {
        var numS = numStr[n];
        maximumOutputCurrentList[int.parse(numS)] = int.parse(numS);
        if ("$i" == numS) {
          occurrencesNum[i]++;//出现次数
          vi = true;
          num = numS;
          // 对应次数
          _trendMoreContentSmallInt[i]++;
          //break;
        }
      }
      print("右上角的数字标志 _currentMoreNumText= $_currentMoreNumText  num = $num");

      // 多号时 右上角的数字标志
//      if (vi) {
//        if (_currentMoreNumText == num) {
//          _currentMoreNumPage++;
//        } else {
//          _currentMoreNumPage = 1;
//        }
//      } else {
//
//      }
      _currentMoreNumPage = _trendMoreContentSmallInt[i];

      this._currentMoreNumText = num;
      _trendMoreContentList.add(_trendContentExpStack(1,index, num, "$_currentMoreNumPage",vi));
    }

    print("右上角的数字标志 ##################################");

    // 最大连出
    for ( int mC = 0; mC < maximumOutputCurrentList.length; mC++) {
      var parse = maximumOutputCurrentList[mC];

      if(maximumOmission[mC] != 0 && maximumOmissionC[mC] < maximumOmission[mC]) {
        maximumOmissionC[mC] = maximumOmission[mC];
      }

      if(parse != -1) {
        maximumOutputOld[mC]++;
      } else {
        if (parse <= 1) {
          maximumOutputOld[mC] = 0;
        }
      }

      if (parse == -1) {
        maximumOmission[mC] ++;
      } else {
        maximumOmission[mC] = 0;
      }

      if (maximumOutputOld[mC] > maximumOutput[mC]) {
        maximumOutput[mC] = maximumOutputOld[mC];
      }

    }

    return _trendMoreContentList;
  }


  /// 走势图的头 （五星和值走势）
  Widget _trendContentFiveSumView(int color, int index, String title, String qs, String draw_code, String sum, String dx, String ds) {

    return new Container(
      height: 25.0,
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

    if(maximumOutputCurrentList[6] > maximumOutput[6]) {
      maximumOutput[6] = maximumOutputCurrentList[6];
    }
    if(maximumOutputCurrentList[7] > maximumOutput[7]) {
      maximumOutput[7] = maximumOutputCurrentList[7];
    }
    if (maximumOmission[6] > maximumOmissionC[6]) {
      maximumOmissionC[6] = maximumOmission[6];
    }
    if (maximumOmission[7] > maximumOmissionC[7]) {
      maximumOmissionC[7] = maximumOmission[7];
    }
    if (dx == "大") {
      occurrencesNum[6]++;
      maximumOmission[7]++;
      maximumOmission[6] = 0;
      maximumOutputCurrentList[6]++;
      maximumOutputCurrentList[7] = 0;
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  dx, true, true));//大
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//小
    } else {
      occurrencesNum[7]++;
      maximumOmission[6]++;
      maximumOmission[7] = 0;
      maximumOutputCurrentList[7]++;
      maximumOutputCurrentList[6] = 0;
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//大
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  dx, true, true));//小
    }

    if(maximumOutputCurrentList[8] > maximumOutput[8]) {
      maximumOutput[8] = maximumOutputCurrentList[8];
    }
    if(maximumOutputCurrentList[9] > maximumOutput[9]) {
      maximumOutput[9] = maximumOutputCurrentList[9];
    }
    if (maximumOmission[8] > maximumOmissionC[8]) {
      maximumOmissionC[8] = maximumOmission[8];
    }
    if (maximumOmission[9] > maximumOmissionC[9]) {
      maximumOmissionC[9] = maximumOmission[9];
    }

    if (ds == "单") {
      occurrencesNum[8]++;
      maximumOmission[9]++;
      maximumOmission[8] = 0;
      maximumOutputCurrentList[8]++;
      maximumOutputCurrentList[9] = 0;
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  ds, true, true));//单
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//双
    } else {
      occurrencesNum[9]++;
      maximumOmission[8]++;
      maximumOmission[9] = 0;
      maximumOutputCurrentList[9]++;
      maximumOutputCurrentList[8] = 0;
      _fiveSumListView.add( _trendSingleDoubleContent(1,index, "0", false,  false));//单
      _fiveSumListView.add(_trendSingleDoubleContent(1,index,  ds, true, true));//双
    }


    return _fiveSumListView;
  }


  /// 走势图的头 （各类 和值）
  Widget _trendContentVariousTypeSumView(int color, int index, String title, String qs, String draw_code, String qe, String qss, String zs, String hs, String he) {

    return new Container(
      height: 25.0,
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
      height: 25.0,
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
        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.wq, 2, 3, 4);

        isDragon = false;
        isTiger = false;
        isAnd = false;
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));
        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.wb, 7, 8, 9);
        break;

      case 2:
        // 万十 万个
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.ws, 2, 3, 4);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[0], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.wg, 7, 8, 9);
        break;
      case 3:
        // 千百 千十
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.qb, 2, 3, 4);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.qs, 7, 8, 9);
        break;
      case 4:
        // 千个 百十
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[1], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.qg, 2, 3, 4);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.bs, 7, 8, 9);
        break;
      case 5:
        // 百个  十个
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[2], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.bg, 2, 3, 4);

        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[3], 0, false));
        _fiveSumListView.add( _trendVariousTypeContent(1,index, codeNumList[4], 0, false));

        _addDragonTigerList(index, _fiveSumListView, isDragon, isTiger, isAnd, singleReDataBeen.sg, 7, 8, 9);
        break;
    }


    return _fiveSumListView;
  }

  _addDragonTigerList(int index, List<Widget> _fiveSumListView, bool isDragon, bool isTiger, bool isAnd, String dragonTigerEx, int indexL, int indexH, int indexHE) {
    isDragon = false;
    isTiger = false;
    isAnd = false;
    isDragon = dragonTigerEx == "龙";
    isTiger = dragonTigerEx == "虎";
    isAnd = dragonTigerEx == "和";

    if(maximumOutputCurrentList[indexL] > maximumOutput[indexL]) {
      maximumOutput[indexL] = maximumOutputCurrentList[indexL];
    }
    if (maximumOmission[indexL] > maximumOmissionC[indexL]) {
      maximumOmissionC[indexL] = maximumOmission[indexL];
    }

    if(maximumOutputCurrentList[indexH] > maximumOutput[indexH]) {
      maximumOutput[indexH] = maximumOutputCurrentList[indexH];
    }
    if (maximumOmission[indexH] > maximumOmissionC[indexH]) {
      maximumOmissionC[indexH] = maximumOmission[indexH];
    }

    if(maximumOutputCurrentList[indexHE] > maximumOutput[indexHE]) {
      maximumOutput[indexHE] = maximumOutputCurrentList[indexHE];
    }
    if (maximumOmission[indexHE] > maximumOmissionC[indexHE]) {
      maximumOmissionC[indexHE] = maximumOmission[indexHE];
    }

    if (isDragon) {

      occurrencesNum[indexL]++;
      maximumOmission[indexL] = 0;
      maximumOmission[indexH]++;
      maximumOmission[indexHE]++;
      maximumOutputCurrentList[indexL]++;
      maximumOutputCurrentList[indexH] = 0;
      maximumOutputCurrentList[indexHE] = 0;

    }
    if (isTiger) {
      occurrencesNum[indexH]++;
      maximumOmission[indexL]++;
      maximumOmission[indexH] = 0;
      maximumOmission[indexHE]++;
      maximumOutputCurrentList[indexL] = 0;
      maximumOutputCurrentList[indexH]++;
      maximumOutputCurrentList[indexHE] = 0;
    }
    if (isAnd) {
      occurrencesNum[indexHE]++;
      maximumOmission[indexL]++;
      maximumOmission[indexH]++;
      maximumOmission[indexHE] = 0;
      maximumOutputCurrentList[indexL] = 0;
      maximumOutputCurrentList[indexH] = 0;
      maximumOutputCurrentList[indexHE]++;
    }

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

  /// 走势图 最后显示
  Widget _trendContentColor(int flex, int index, String title, int colorInt) {

    return new Expanded(
      child: _trendContentLast(index, title, colorInt),
      flex: flex,
    );
  }

  /// 多号走势
  Widget _trendContentExpStack(int flex, int index, String title, String secondText,bool visible) {

    return new Expanded(
      child: _trendContentMore(index, title, secondText,visible),
      flex: flex,
    );
  }

  /// 显示期数（不带颜色）
  Widget _trendNumberOfPeriodsContent(int index, String title) {

    return new Container(
      width: numberOfPeriodsLength,
      height: 25.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: new Align(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: new TextStyle(
                  color: Color(ColorUtil.textColor_333333),
                  fontSize: 12.0,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  /// 显示期数 (带颜色)
  Widget _trendNumberOfPeriodsContentColor(int index, String title, int colorInt) {

    return new Container(
      width: numberOfPeriodsLength,
      height: 25.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: new Align(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: new TextStyle(
                  color: Color(colorInt),
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
                  color: Color(ColorUtil.textColor_333333),
                  fontSize: title.length >=4 ?8.0 : 12.0,
                ),
              ),
            ),
        ),

      ],
    );
  }

  /// 每格内容 最后栏目
  Widget _trendContentLast(int index, String title, int colorInt) {

    return new Row(
      children: <Widget>[
        CommonView().commonLineW(context),

        new Expanded(
          child: new Align(
            alignment: Alignment.center,
            child: new Text(
              title,
              style: new TextStyle(
                color: Color(colorInt),
                fontSize: title.length >=4 ?8.0 : 12.0,
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
                  color: Color(isBg ? ColorUtil.whiteColor : ColorUtil.textColor_333333),
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
                  color: Color(isBg ? ColorUtil.whiteColor : ColorUtil.textColor_333333),
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
  Widget _trendContentMore(int index, String title, String secondText, bool visible) {

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
                      color: Color(ColorUtil.textColor_333333),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),

              _trendMarkContent(title, 30.0, 30.0, 14.0, visible),
              _trendMarkContentSmall(secondText, 12.0, 12.0, 8.0,
                  TextUtil.isEmpty(secondText) ? false : int.parse(secondText) >= 2 ? true : false),//多号的小数字

            ],
          ),
        ),

      ],
    );
  }

  /// 多选是显示期数
  Widget _trendMarkContent(String num, double width, double height, double fontSize, bool visible) {
    return new Align(
      alignment: Alignment.center,
      child: new Visibility(
        visible: visible,
        child: new Container(
          height: height,
          width: width,
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
              fontSize: fontSize,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// 多选是显示期数 (小标题)
  Widget _trendMarkContentSmall(String num, double width, double height, double fontSize, bool visible) {
    return new Align(
      alignment: Alignment.topRight,
      child: new Visibility(
        visible: visible,
        child: new Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Color(ColorUtil.textColor_1396DA),
            border: new Border.all(
              color: Color(ColorUtil.textColor_1396DA ),
              width: 1,
            ), // 边色与边宽度
            //borderRadius: new BorderRadius.circular((24.0)), // 圆角度
          ),
          child: new Text(
            num,
            style: TextStyle(
              fontSize: fontSize,
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
    if (isLineConnection) {
      for (int i = 0; i < dataTrendOneLottery.length; i++) {
        var randomNext = int.parse(dataTrendOneLottery[i].num);
        var trendCoordinateBeen = new TrendCoordinateBeen(
            screenW / 2 + (screenW * (randomNext) + numberOfPeriodsLength ) ,
            12.0 + ((i) * 25.0));
        trendCoordinateBeen.indexNum = "$randomNext";
        trendPointList.add(trendCoordinateBeen);
      }
    }

    if (mounted)
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

  @override
  void onResumed() {
    super.onResumed();
    //当界面可见时 调用
      _postHttpTrend();
  }

  /// 请求
  _postHttpTrend() {
    //_cleanDataBeen();
    if (isLineConnection) {
      trendPointList.clear();
      _starLastData();
      GameService.instance.hanoiOneOddNumber(this, _limitStr, _indexPage);///单号
    } else {
      if (isSingleDouble || isMaxMin) {
        /// 单双， 大小
        _singleLastData();
        if (isMaxMin) {
          GameService.instance.hanoiOneMaxMin(this, _limitStr, _indexPage);//大小
        } else {
          GameService.instance.hanoiOneSingleDouble(this, _limitStr, _indexPage);//单双
        }

      } else {
        if (isFiveNum) {
          _starLastData();
          GameService.instance.hanoiOneFiveValue(this, _limitStr);//五星和值
        } else {

          if (isVariousSum || isVariousSpan) {
            _andSumLastData();
            if (isVariousSum) {
              GameService.instance.hanoiOneVariousSum(this, _limitStr);//各类和值
            } else {
              GameService.instance.hanoiOneVariousSpan(this, _limitStr);//各类跨度
            }
          } else {
            if (isDragonTiger) {
              _dragonTigerLastData();
              GameService.instance.hanoiOneDragonTiger(this);//龙虎和
            } else {
              _starLastData();
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

    //_paintH = size.height;
    if (trendPointList.length >= 2) {

      for (int i = -1; i < trendPointList.length - 1; i++) {

        double dx1 = trendPointList[i + 1].dx;
        double dy1 = trendPointList[i + 1].dy;

        _paint.color = Color(ColorUtil.butColor_EB303B);
        canvas.drawCircle(Offset(dx1, dy1), 10, _paint);
        print("坐标 数值 ： ${trendPointList[i + 1].indexNum}");
        _paint.color = Color(ColorUtil.whiteColor);
        paragraphBuilder.addText(trendPointList[i + 1].indexNum);
        paragraph = paragraphBuilder.build()
          ..layout(ui.ParagraphConstraints(width: textWidth));
        //paragraph.layout(ui.ParagraphConstraints(width: textWidth));

        canvas.drawParagraph(paragraph, Offset(dx1 - textWidth /2, dy1 - 5));

        if (i >= 0) {
          _paint.color = Color(ColorUtil.butColor_EB303B);
          canvas.drawLine( Offset(trendPointList[i].dx , trendPointList[i].dy ),
              Offset(dx1, dy1 ), _paint);
        }


      }
    }

  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return true;
  }
}

