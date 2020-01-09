import 'dart:math';

/**
 *  河内一分彩  河内五分彩
 *  万位 千位 百位 十位 个位
 */
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/ThousandsOfBitsChoiceInterface.dart';

///
class ThousandsOfBitsView extends StatefulWidget{

  ThousandsOfBitsChoiceInterface bitsChoiceInterface;

  ThousandsOfBitsView(
      Key key
      ,{
        this.bitsChoiceInterface,
      }
      ):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ThousandsOfBitsStateView(bitsChoiceInterface);
  }

}

class ThousandsOfBitsStateView extends BaseController<ThousandsOfBitsView> {

  ThousandsOfBitsChoiceInterface bitsChoiceInterface;

  List<bool> _checkStateList = [false, false, false, false, false,];
  List<String> _checkStateStrList = ["万位", "千位", "百位", "十位", "个位",];
  int _cpID = 0;//彩票ID
  int _randomNum = 0;// 机选是 随机个数
  Set<int> _randomSet = new Set();// 保存随机数

  ThousandsOfBitsStateView(
      this.bitsChoiceInterface
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Row(
        children: _checkListView(),
      ),
    );
  }

  /// 选择状态
  List<Widget> _checkListView() {
    List<Widget> _checkList = new List();

    for (int i = 0; i < _checkStateList.length; i++) {
      _checkList.add(
        new Expanded(child: _checkView(_checkStateStrList[i], _checkStateList[i], i))
      );
    }
    return _checkList;
  }

  Widget _checkView(String text, bool state, int index) {

    return new GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            //state = !state;
            _checkStateList[index] = !state;
          });
        }
      },
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Checkbox(
            value: state,
            activeColor: Color(ColorUtil.butColor), //选中时的颜色
            onChanged:(value){
              if (mounted) {
                setState(() {
                  _checkStateList[index] = !state;
                });
              }
            } ,

          ),

          Text(
            text,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

        ],
      ),
    );
  }

  /// 刷新状态 id  彩票ID
  randomThousandsOfBitsStateRefresh(int id) {
    _cpID = id;
    switch(id) {
      case 227:
        // 任二单式
        _randomNum = 2;
        break;
      case 228:
        // 任二 组选
        _randomNum = 2;
        break;
      case 230:
      case 231:
      case 232:
        _randomNum = 3;
        break;
    }

    _randomCheckState();
  }

  /// 机选
  _randomCheckState() {

    _randomSet.clear();

    while (_randomSet.length < _randomNum) {
      var randomIndex = Random().nextInt(5) + 1;
      _randomSet.add(randomIndex);
    }

    if (_randomSet.length == _randomNum) {
      var iterator = _randomSet.iterator;

      for (int s = 0; s <  _checkStateList.length; s++) {
        _checkStateList[s] = false;
      }
      while (iterator.moveNext()) {
        var current = iterator.current;
        _checkStateList[current] = true;
      }

      if (mounted)
        setState(() {

        });

    }

  }

}