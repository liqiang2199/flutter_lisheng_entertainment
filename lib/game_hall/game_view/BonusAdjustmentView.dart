
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 奖金调节
 */
class BonusAdjustmentView extends StatelessWidget {

  int _segmentedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        _bonusAdjustmentTitle(),
        _sliderPro(),
        _companyRow(),
        CommonView().commonLine_NoMargin(context),

      ],
    );
  }

  /// 位数标题显示
  Widget _bonusAdjustmentTitle() {

    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        margin: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 5.0,),
        child: new Text(
          "奖金调节",
          style: new TextStyle(
            color: Color(ColorUtil.textColor_333333),
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }


  Widget _sliderPro() {

    return new Container(
      child: new Row(
        children: <Widget>[

          new Expanded(
              child: new Slider(
                  value: 10,
                  max: 100,
                  min: 0,
                  divisions: 100,//
                  activeColor: Color(ColorUtil.butColor),
                  inactiveColor: Color(ColorUtil.textColor_888888),
                  onChanged: (value) {
                    print("Slider $value");
                  },
              ),
          ),

          _proportion("1111/12.2%")

        ],
      ),
    );

  }

  // 奖金调节比例显示
  Widget _proportion(String name) {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        height: 30.0  ,
        margin: EdgeInsets.only( left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //

        },color: Color(ColorUtil.bgColor_CCCCCC),
          child: new Text(name
            , style: TextStyle(fontSize: 13.0,color: Color(ColorUtil.textColor_888888)),),
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(ColorUtil.bgColor_CCCCCC),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  /// 单位选择
  Widget _companyRow() {

    return new Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: new Align(
              alignment: Alignment.centerLeft,
              child: _proportionCompany(),
            ),
          ),
          _addBettingView()
        ],
      ),
    );
  }


  Widget _proportionCompany() {

    return new Container(
      child: CupertinoSegmentedControl<int>(children: {
        0:Padding(padding: EdgeInsets.only(top:5.0,bottom: 5.0,left: 15.0, right: 15.0),child: _segmentedTitle("元"),),
        1:Padding(padding: EdgeInsets.all(5.0),child: _segmentedTitle("角"),),
        2:Padding(padding: EdgeInsets.all(5.0),child: _segmentedTitle("分"),),
        3:Padding(padding: EdgeInsets.all(5.0),child: _segmentedTitle("厘"),),
      },
        onValueChanged: (value){
          print("the value changed ! $value");
        },
        groupValue: _segmentedIndex,
        borderColor: Color(ColorUtil.butColor),
        selectedColor: Color(ColorUtil.butColor),
        unselectedColor: Color(ColorUtil.whiteColor),
      ),
    );
  }

  Widget _segmentedTitle(String title) {

    return new Text(
      title,
      style: new TextStyle(
        fontSize: 14.0,
      ),
    );
  }

  Widget _addBettingView() {
    
    return new Container(
      margin: EdgeInsets.only(right: 15.0),
      child: new Row(
        children: <Widget>[

          _addBettingItemView(),
          _bettingTextView(),
          _addBettingItemViewADD(),

        ],
      ),
    );
  }

  Widget _addBettingItemView() {
    
    return new Container(
      height: 30.0,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.bgColor_CCCCCC), width: 0.5), // 边色与边宽度
        borderRadius: new BorderRadius.only(
          topLeft: Radius.circular(2.0),
          bottomLeft: Radius.circular(2.0),
        ), // 圆角度
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Text(
        "-",
        style: TextStyle(
          color: Color(ColorUtil.bgColor_CCCCCC),
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _bettingTextView() {

    return new Container(
      height: 30.0,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.textColor_888888), width: 0.5), // 边色与边宽度
        borderRadius: new BorderRadius.only(), // 圆角度
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0,right: 10.0),
      child: new Text(
        "11",
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _addBettingItemViewADD() {

    return new Container(
      height: 30.0,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.butColor), width: 0.5), // 边色与边宽度
        borderRadius: new BorderRadius.only(
          topLeft: Radius.circular(2.0),
          bottomLeft: Radius.circular(2.0),
        ), // 圆角度
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Text(
        "+",
        style: TextStyle(
          color: Color(ColorUtil.butColor),
          fontSize: 16.0,
        ),
      ),
    );
  }

}