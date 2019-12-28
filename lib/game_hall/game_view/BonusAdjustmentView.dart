
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BonusAdjustmentInterface.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 奖金调节
 */
class BonusAdjustmentView extends StatelessWidget {


  TextEditingController textEditingController = new TextEditingController();

  final BonusAdjustmentInterface adjustmentInterface; // 奖金调节回调接口
  final int multipleNum;
  final int segmentedIndex;
  final double sliderValue;

  BonusAdjustmentView({
    Key key,
    this.adjustmentInterface,
    this.multipleNum = 1,
    this.segmentedIndex = 0,
    this.sliderValue = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    textEditingController.text = "$multipleNum";
    textEditingController.selection = new TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: "$multipleNum".length));

    return new Column(
      children: <Widget>[

//        _bonusAdjustmentTitle(),
//        _sliderPro(),
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
                  value: this.sliderValue,
                  max: 1994,
                  min: 1800,
                  divisions: 97,//
                  activeColor: Color(ColorUtil.butColor),
                  inactiveColor: Color(ColorUtil.textColor_888888),
                  onChanged: (value) {
                    print("Slider $value");
                    if(adjustmentInterface != null) {
                      adjustmentInterface.sliderChangeNum(value);
                    }
                  },
              ),
          ),

          _proportion("${this.sliderValue}/${(this.sliderValue - 1800.0)/ 20}%")

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
          if (adjustmentInterface != null) {
            adjustmentInterface.setSegmentedIndex(value);
          }
        },
        groupValue: segmentedIndex,
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
    
    return new GestureDetector(
      onTap: () {
        /// 倍数调节 -
        int num = multipleNum;
        num--;
        if (num < 1) {
          num = 1;
        }
        if (adjustmentInterface != null) {
          adjustmentInterface.bettingMultipleAddAndSub(false, num);
        }
      },
      child: new Container(
        height: 30.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.bgColor_CCCCCC), width: 0.5), // 边色与边宽度
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
          ), // 圆角度
          color: Color(ColorUtil.bgColor_CCCCCC),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Text(
          "--",
          style: TextStyle(
            color: Color(ColorUtil.whiteColor),
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _bettingTextView() {

    return new Container(
      height: 30.0,
      width: 50.0,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.textColor_888888), width: 0.5), // 边色与边宽度
        borderRadius: new BorderRadius.only(), // 圆角度
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0,right: 10.0),
      child: new TextField(
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
        decoration: InputDecoration(
          hintText: "",
          border: InputBorder.none,
          hoverColor: Color(ColorUtil.textColor_333333),
          hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
          contentPadding: const EdgeInsets.only(top: 0.0, bottom: 14.0),

        ),
        onChanged: _textFieldChanged,
        controller: textEditingController,
//        inputFormatters: WhitelistingTextInputFormatter(RegExp("[0-9.]")),
      ),
    );
  }

  _textFieldChanged(String str) {
    if(TextUtil.isEmpty(str)) {
      str = "1";
    }
    if (adjustmentInterface != null) {
      adjustmentInterface.bettingMultipleAddAndSub(true, int.parse(str));
    }
  }

  Widget _addBettingItemViewADD() {

    return new GestureDetector(
      onTap: (){
        /// 倍数调节 +
        int num = multipleNum;
        num++;
        if (adjustmentInterface != null) {
          adjustmentInterface.bettingMultipleAddAndSub(true, num);
        }
      },
      child:  new Container(
        height: 30.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.butColor), width: 0.5), // 边色与边宽度
          borderRadius: new BorderRadius.only(
            bottomRight: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ), // 圆角度
          color: Color(ColorUtil.butColor),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Text(
          "+",
          style: TextStyle(
            color: Color(ColorUtil.whiteColor),
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

}