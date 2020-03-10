import 'dart:math';

/**
 *  河内一分彩  河内五分彩
 *  万位 千位 百位 十位 个位
 */
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
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
  List<String> _checkStateStrListS = ["万", "千", "百", "十", "个",];
  int _cpID = 0;//彩票ID
  int _randomNum = 0;// 机选是 随机个数
  Set<int> _randomSet = new Set();// 保存随机数
  Set<String> _bitsStateSet = new Set();// 保存 万,千,百,十,个

  ThousandsOfBitsStateView(
      this.bitsChoiceInterface
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(top: 15.0),
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
            _checkStateList[index] = !state;
            _addBitsNumList(_checkStateList[index], index);
          });
        }
      },
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Image.asset(state? ImageUtil.imgRadioBgSelection : ImageUtil.imgRadioBg
            , width: 22.0, height: 22.0,),

          new Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_333333),
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),

        ],
      ),
    );
  }

  /// 保存位数位置说明
  _addBitsNumList( bool state, int index) {
    if (state) {
      _bitsStateSet.add(_checkStateStrListS[index]);
    } else {
      _bitsStateSet.remove(_checkStateStrListS[index]);
    }

    if (bitsChoiceInterface != null) {
      bitsChoiceInterface?.setThousandsOfBitsStateSave(_bitsStateSet);
    }
  }

  /// 获取 千 万
  List<String> getCheckStateThousandsOfBitsList() {
    return _bitsStateSet.toList();
  }

  /// 刷新状态 id  彩票ID
  randomThousandsOfBitsStateRefresh(int id) {
    _cpID = id;
    switch(id) {
      case 227:
        // 任二单式
        _randomNum = 2;
        break;
      case 228:// 河内一分彩 任二 组选

      case 559:// 河内5分彩 任二 单式
      case 560:// 河内5分彩 任二 组选

      case 383:// 腾讯一分彩 任二 单式
      case 384:// 腾讯一分彩 任二 组选
      case 713:// 腾讯5分彩 任二 单式
      case 714:// 腾讯5分彩 任二 组选
      case 868:// 腾讯10分彩 任二 单式
      case 869:// 腾讯10分彩 任二 组选

      case 1023:// 奇趣一分彩 任二 单式
      case 1024:// 奇趣一分彩 任二 组选
      case 1170:// 奇趣5分彩 任二 单式
      case 1171:// 奇趣5分彩 任二 组选
      case 1313:// 奇趣10分彩 任二 单式
      case 1314:// 奇趣10分彩 任二 组选
        _randomNum = 2;
        break;
      case 230://河内一分彩
      case 231:
      case 232:

      case 563:// 河内5分彩
      case 564:
      case 565:

      case 386://腾讯一分彩 任三 单式
      case 387://腾讯一分彩 任三 组三
      case 388://腾讯一分彩 任三 组六

      case 717://腾讯5分彩 任三 单式
      case 718://腾讯5分彩 任三 组三
      case 719://腾讯5分彩 任三 组六

      case 872://腾讯10分彩 任三 单式
      case 873://腾讯10分彩 任三 组三
      case 874://腾讯10分彩 任三 组六

      case 1027://奇趣一分彩 任三 单式
      case 1028://奇趣一分彩 任三 组三
      case 1029://奇趣一分彩 任三 组六

      case 1174://奇趣5分彩 任三 单式
      case 1175://奇趣5分彩 任三 组三
      case 1176://奇趣5分彩 任三 组六

      case 1317://奇趣10分彩 任三 单式
      case 1318://奇趣10分彩 任三 组三
      case 1319://奇趣10分彩 任三 组六
        _randomNum = 3;
        break;

      case 1083://奇趣一分彩 任四 单式

      case 1079://奇趣5分彩 任四 单式

      case 1322://奇趣10分彩 任四 单式
        _randomNum = 4;
        break;
    }

    _randomCheckState();
  }

  /// 机选
  _randomCheckState() {

    _randomSet.clear();

    while (_randomSet.length < _randomNum) {
      var randomIndex = Random().nextInt(5);
      _randomSet.add(randomIndex);
    }
    print("set = ${_randomNum.toString()}");

    if (_randomSet.length == _randomNum) {
      for (int s = 0; s <  _checkStateList.length; s++) {
        _checkStateList[s] = false;
      }
      _randomSet.toList().forEach((value) {
        _checkStateList[value] = true;
      });

      _bitsStateSet.clear();
      for (int i = 0 ; i < _checkStateList.length; i++) {
        if (_checkStateList[i] == true) {
          _bitsStateSet.add(_checkStateStrListS[i]);
        }

      }


      if (mounted)
        setState(() {

        });

    }

  }

  /// 清空选择状态
  cleanThousandsOfBitsState() {
    for (int s = 0; s <  _checkStateList.length; s++) {
      _checkStateList[s] = false;
    }
    if (mounted)
      setState(() {

      });
  }

}