import 'dart:math';

/**
 *  龙虎 龙 虎  大小 单双 View
 */
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/LuckyAirshipSecSumInterface.dart';

/// 龙  虎
class LuckyAirshipDoubleSelecView extends StatefulWidget{

  final LuckyAirshipSecSumInterface dragonTigerSumInterface;

  LuckyAirshipDoubleSelecView(Key key, this.dragonTigerSumInterface,): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LuckyAirshipDoubleSelecStateView(this.dragonTigerSumInterface);
  }

}

class LuckyAirshipDoubleSelecStateView extends BaseController<LuckyAirshipDoubleSelecView> {

  List<bool> cpNumBool = [false, false, false];
  List<String> cpNumStr = ["龙", "虎"];//幸运飞艇 双选
  String cpNumStrTitle = "第一位";//幸运飞艇 双选
  int typeIndex;
  List<int> cpNumIndex = [-1, -1];
  List<String> choiceCpNumList = new List();//选中list 的集合

  LuckyAirshipSecSumInterface dragonTigerSumInterface;
  LuckyAirshipDoubleSelecStateView(this.dragonTigerSumInterface,);

  @override
  Widget build(BuildContext context) {


    return new Column(
      children: <Widget>[
        _chooseTitle(cpNumStrTitle),
        _gridList(),

      ],
    );
  }

  setDragonTigerSumStateRefresh(List<String> choiceCpNumList) {
    this.choiceCpNumList = choiceCpNumList;
    if (mounted) {
      setState(() {

      });
    }
  }

  /// 位数标题显示
  Widget _chooseTitle(String title) {

    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        margin: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 5.0,),
        child: new Text(
          title,
          style: new TextStyle(
            color: Color(ColorUtil.textColor_333333),
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  Widget _gridList() {

    return new Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 15.0),
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        //padding: const EdgeInsets.all(8.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 1.9,
        children: _gridListItemView(),
        shrinkWrap: true,

      ),
    );
  }


  List<Widget> _gridListItemView() {
    List<Widget> gridListItem = new List();

    for (int i = 0; i < cpNumStr.length; i++) {
      gridListItem.add(_cqNumView(cpNumStr[i], cpNumBool[i], i));
    }

    return gridListItem;
  }

  Widget _cqNumView(String num, bool isChoice, int index) {

    if (isChoice) {
      if (!choiceCpNumList.contains(num)) {
        choiceCpNumList.add(num);
      }

    } else {
      if (choiceCpNumList.contains(num)) {
        choiceCpNumList.remove(num);
      }
    }

    return new GestureDetector(
      onTap: () {
        if (cpNumBool[index]) {
          cpNumBool[index] = !cpNumBool[index];
          cpNumIndex[index] = cpNumIndex[index] == 0 ? -1 : 0;
        } else {
          for (int i = 0; i < cpNumBool.length; i++) {
            cpNumBool[i] = false;
          }
          for (int i = 0; i < cpNumIndex.length; i++) {
            cpNumIndex[i] = -1;
          }
          cpNumBool[index] = true;
          cpNumIndex[index] = 0;
        }


        if (mounted) {
          setState(() {

          });
        }
        if (dragonTigerSumInterface!= null) {
          dragonTigerSumInterface.setLuckyAirshipSecSumHandler(choiceCpNumList);
        }
      },
      child: new Container(
        height: 30.0,
        width: 30.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10.0),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Color(isChoice ? ColorUtil.bgColor_E7242C : ColorUtil.whiteColor),
          border: new Border.all(
            color: Color(isChoice ? ColorUtil.bgColor_E7242C : ColorUtil.textColor_888888),
            width: 1,
          ), // 边色与边宽度
          //borderRadius: new BorderRadius.circular((24.0)), // 圆角度
        ),
        child: new Text(
          num,
          style: TextStyle(
            fontSize: 14.0,
            color: isChoice ? Colors.white : Color(ColorUtil.textColor_333333),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// DragonTigerChoiceInterface
  /// 随机 龙虎 单双  大小
  randomLuckyAirshipChoiceNum() {
    int index = Random().nextInt(3);
    for (int i = 0; i < cpNumBool.length; i++) {
      cpNumBool[i] = false;
    }

    cpNumBool[index] = true;
    if (mounted)
      setState(() {

      });
  }

  /// 清空
  cleanLuckyAirshipChoiceNum() {
    for (int i = 0; i < 3; i++) {
      cpNumBool[i] = false;
    }

    if (mounted)
      setState(() {

      });
  }

  List<String> getRandomLuckyAirshipList() {
    if (choiceCpNumList.length <= 0) {
      for (int i = 0; i < cpNumBool.length; i++) {
        if (cpNumBool[i]) {
          choiceCpNumList.add("${cpNumStr[i]}");
        }
      }
    }
    return this.choiceCpNumList;
  }


}