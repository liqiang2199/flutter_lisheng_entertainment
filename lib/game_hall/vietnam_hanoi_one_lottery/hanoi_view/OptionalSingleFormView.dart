
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/ThousandsOfBitsView.dart';

/**
 * 任选单式
 */
///
class OptionalSingleFormView extends StatefulWidget {

  OptionalSingleFormView(Key key): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OptionalSingleFormStateView();
  }

}

class OptionalSingleFormStateView extends BaseController<OptionalSingleFormView> {

  List<int> editNumList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,];
  Set<int> _randomSet = new Set();// 保存随机数

  TextEditingController textEditingController = new TextEditingController();

  GlobalKey<ThousandsOfBitsStateView> _bitsStateViewKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        children: <Widget>[

          ThousandsOfBitsView(_bitsStateViewKey),
          _bettingNumEdit(),

        ],
      ),
    );
  }

  /// 号码输入框
  Widget _bettingNumEdit() {

    return new Container(
      height: 145.0,
      margin: EdgeInsets.only(top: 15.0,),
      padding: EdgeInsets.only(right: 5.0,left: 5.0,),
      alignment: Alignment.topLeft,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: "",
                contentPadding: const EdgeInsets.only(top: 0.0, bottom: 13.5),
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14.0, color: Color(ColorUtil.textColor_888888)),
                labelStyle: TextStyle(fontSize: 14.0, color: Color(ColorUtil.textColor_333333)),
              ),
              controller: textEditingController,
              onChanged: _editContentHandle,

            ),
          ),

        ],

      ),
    );
  }

  _editContentHandle(String str) {

  }

  /**
   * id 彩票 玩法ID
   * randomNum 随机个数
   */
  ///
  randomEditAndCheckState(int id, int randomNum) {
    //editNumList
    _randomSet.clear();
    while (_randomSet.length < randomNum) {
      var randomIndex = Random().nextInt(5) + 1;
      _randomSet.add(randomIndex);
    }

    StringBuffer stringBuffer = new StringBuffer();
    var iterator = _randomSet.iterator;
    while (iterator.moveNext()) {
      var current = iterator.current;
      stringBuffer.write("${editNumList[current]}");
    }


    textEditingController.text = stringBuffer.toString();

    if(mounted)
      setState(() {

      });
  }

}