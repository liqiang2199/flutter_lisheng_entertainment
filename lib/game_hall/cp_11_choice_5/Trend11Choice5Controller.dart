
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/TrendTypeChoiceView.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendCoordinateBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'dart:ui' as ui;


class Trend11Choice5Controller extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Trend11Choice5Controller();
  }

}

class _Trend11Choice5Controller extends BaseController<Trend11Choice5Controller> with AutomaticKeepAliveClientMixin{

  List<TrendCoordinateBeen> trendPointList = new List();
  /// 期数 多少选择 30 50 100
  List<bool> numberOfPeriodsNum = [true, false, false];
  List<String> trendTitleList = ["期数", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"];

  double numberOfPeriodsLength = 60.0;
  var screenW;

  @override
  Widget build(BuildContext context) {
    //trendPointList.clear();
    screenW = (ScreenUtil.getScreenW(context) - numberOfPeriodsLength) / 11;

    return new Column(
      children: <Widget>[
        _trendTypeChoice(),
        _trendHeadView(ColorUtil.textColor_FF8814,-1),

//        new Expanded(child: _cpList(),),
        new Expanded(child: _list(),),

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
              "单号走势_第一名",
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

          numberOfPeriodsNum[index] = true;
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
    return new CustomPaint(
      foregroundPainter: new LinePainter(trendPointList),
      child: new ListView(

        children: _listWidget(),

      ),

    );
  }

  /// 走势图的头
  Widget _trendHeadView(int color, int index) {

    return new Container(
      height: 20.0,
      color: Color(color),
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: new Row(
              children: _titleListWidget(index),
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

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

  List<Widget> _listWidget() {
    List<Widget> list = new List();
    for (int i = 1; i<= 10; i++) {

      list.add( _trendContentView(ColorUtil.whiteColor, i,"12"));
    }
    return list;
  }

  /// 走势图的头
  Widget _trendContentView(int color, int index, String title) {
    if (index != -1) {
      var randomNext = (Random().nextInt(10) + 2);
      var trendCoordinateBeen = new TrendCoordinateBeen(
          screenW / 2 + (screenW * (randomNext - 1) + numberOfPeriodsLength ) ,
          10.0 + ((index - 1) * 20.0));
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
                _trendNumberOfPeriodsContent(index, title),
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
                _trendContentExp(1,index, title),

              ],
            ),
          ),

          CommonView().commonLine_NoMargin(context),

        ],
      ),
    );
  }

  Widget _trendContentExp(int flex, int index, String title) {

    return new Expanded(
        child: _trendContent(index, title),
      flex: flex,
    );
  }

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


  /// 每格内容
  Widget _trendContent(int index, String title) {

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


  _trendTypeChoiceDialog(BuildContext context) {



  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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

      for (int i = -1; i < trendPointList.length - 1; i++) {

        _paint.color = Color(ColorUtil.butColor_EB303B);
        canvas.drawCircle(Offset(trendPointList[i + 1].dx, trendPointList[i + 1].dy), 10, _paint);
        print("坐标 数值 ： ${trendPointList[i + 1].indexNum}");
        _paint.color = Color(ColorUtil.whiteColor);
        paragraphBuilder.addText(trendPointList[i + 1].indexNum);
        paragraph = paragraphBuilder.build()
          ..layout(ui.ParagraphConstraints(width: textWidth));
        canvas.drawParagraph(paragraph, Offset(trendPointList[i + 1].dx - textWidth /2,trendPointList[i + 1].dy - 5));

        if (i >= 0) {
          _paint.color = Color(ColorUtil.butColor_EB303B);
          canvas.drawLine( Offset(trendPointList[i].dx , trendPointList[i].dy ),
              Offset(trendPointList[i + 1].dx, trendPointList[i + 1].dy ), _paint);
        }

      }
    }


  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return false;
  }
}