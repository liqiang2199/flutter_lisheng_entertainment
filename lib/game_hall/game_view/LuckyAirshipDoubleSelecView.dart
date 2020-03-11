import 'dart:math';

/**
 *  龙虎 龙 虎  大小 单双 View
 */
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/LuckyAirshipSecSumInterface.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

/// 龙  虎
class LuckyAirshipDoubleSelecView extends StatefulWidget{

  final LuckyAirshipSecSumInterface dragonTigerSumInterface;
  final String cpNumStrTitle;
  Play11Choice5DataPlayBeen currentPlayBeen;

  LuckyAirshipDoubleSelecView(Key key, this.dragonTigerSumInterface, this.cpNumStrTitle, this.currentPlayBeen): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LuckyAirshipDoubleSelecStateView(this.dragonTigerSumInterface, this.cpNumStrTitle, this.currentPlayBeen);
  }

}

class LuckyAirshipDoubleSelecStateView extends BaseController<LuckyAirshipDoubleSelecView> {

  List<bool> cpNumBool = [false, false];
  List<String> cpNumStr = ["龙", "虎"];//幸运飞艇 双选
  String cpNumStrTitle = "第一位";//幸运飞艇 双选
  int typeIndex;
  List<int> cpNumIndex = [-1, -1];
  List<String> choiceCpNumList = new List();//选中list 的集合

  Play11Choice5DataPlayBeen currentPlayBeen;
  LuckyAirshipSecSumInterface dragonTigerSumInterface;
  LuckyAirshipDoubleSelecStateView(this.dragonTigerSumInterface, this.cpNumStrTitle, this.currentPlayBeen);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (currentPlayBeen != null) {
      setLuckyAirshipPlayModel(currentPlayBeen.id);
    }
  }

  @override
  Widget build(BuildContext context) {


    return new Row(
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

    return new Expanded(
        child: new Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 15.0, top: 15.0),
          child: new GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            //padding: const EdgeInsets.all(8.0),
            primary: false,
            mainAxisSpacing: 0.0,//竖向间距
            crossAxisSpacing: 0.0,//横向间距
            childAspectRatio: 2.5,
            children: _gridListItemView(),
            shrinkWrap: true,

          ),
        )
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

        cpNumBool[index] = !cpNumBool[index];
        cpNumIndex[index] = cpNumIndex[index] == 0 ? -1 : 0;
//        if (cpNumBool[index]) {
//
//        } else {
//          for (int i = 0; i < cpNumBool.length; i++) {
//            cpNumBool[i] = false;
//          }
//          for (int i = 0; i < cpNumIndex.length; i++) {
//            cpNumIndex[i] = -1;
//          }
//          cpNumBool[index] = true;
//          cpNumIndex[index] = 0;
//        }


        if (mounted) {
          setState(() {

          });
        }
        if (dragonTigerSumInterface!= null) {
          dragonTigerSumInterface.setLuckyAirshipSecSumHandler(choiceCpNumList);
        }
      },
      child: new Container(
        height: 25.0,
        width: 25.0,
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
    int index = Random().nextInt(2);
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
    for (int i = 0; i < 2; i++) {
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

  setLuckyAirshipPlayModel(int id) {
    if(id == 142 || id == 1535 || id == 1540) {
      cpNumStrTitle = "第一位";
    }
    if(id == 143 || id == 1536 || id == 1541) {
      cpNumStrTitle = "第二位";
    }
    if(id == 144 || id == 1537 || id == 1542) {
      cpNumStrTitle = "第三位";
    }

    if(id == 142 || id == 143 || id == 144) {
      cpNumStr = ["大", "小"];
    }
    if(id == 1535 || id == 1536 || id == 1537) {
      cpNumStr = ["单", "双"];
    }
    if(id == 1540 || id == 1541 || id == 1542) {
      cpNumStr = ["龙", "虎"];
    }
    if (mounted)
      setState(() {

      });
  }


}