
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5Interface.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 彩种  11 选 5 的 布局
 * 越南 河内一分彩
 */
///

class Choose11And5View extends StatefulWidget {

  //List<String> cpNumStr = ["01","02","03","04","05","06","07","08","09","10","11"];
  List<bool> cpNumBool = [false, false, false, false, false, false, false, false, false, false, false];
  List<bool> chooseTypeList = [false, false, false, false, false, false];

  final List<String> cpNumStr;
  final int typeIndex;
  final List<int> cpNumIndex ;
  final List<String> choiceCpNumList ;//选中list 的集合

  final bool isClickType;
  final int viewIndex;
  final String titleTip;

  final Choose11And5Interface choose11and5interface;

  Choose11And5View({
    Key key,
    this.choose11and5interface,
    this.typeIndex = -1,
    this.cpNumIndex,
    this.isClickType = false,
    this.viewIndex,
    /// 每行的文本提示
    this.titleTip,
    this.choiceCpNumList,
    this.cpNumStr,
  }) : assert(
  choose11and5interface != null,
  ), super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Choose11And5StateView(
      choose11and5interface: choose11and5interface,
      typeIndex: typeIndex,
      cpNumIndex: cpNumIndex,
      isClickType: isClickType,
      viewIndex: viewIndex,
      titleTip: titleTip,
      choiceCpNumList: choiceCpNumList,
      cpNumStr: cpNumStr,
    );
  }


}

class Choose11And5StateView extends BaseController<Choose11And5View> {

  //List<String> cpNumStr = ["01","02","03","04","05","06","07","08","09","10","11"];
  List<bool> cpNumBool = new List();
  List<bool> chooseTypeList = [false, false, false, false, false, false];// 大小单双

  List<String> cpNumStr;
  int typeIndex;
  List<int> cpNumIndex ;
  List<String> choiceCpNumList ;//选中list 的集合

  bool isClickType;
  int viewIndex;
  String titleTip;

  Choose11And5Interface choose11and5interface;

  Choose11And5StateView({
    this.choose11and5interface,
    this.typeIndex = -1,
    this.cpNumIndex,
    this.isClickType = false,
    this.viewIndex,
    /// 每行的文本提示
    this.titleTip,
    this.choiceCpNumList,
    this.cpNumStr,
  }) ;

  /// 选中 全
  _selectionAll() {
    if (isClickType) {
      if (typeIndex == 0) {
        //全 默认全部选中
        for (int i = 0; i < cpNumIndex.length; i++) {
          cpNumIndex[i] = 0;
        }

      }
    }
  }

  /// 选中大号
  _selectionBig() {
    if (isClickType) {
      if (typeIndex == 1) {
        //全 默认全部选中
        var length = cpNumIndex.length;
        var lSize = length / 2;
        for (int i = 0; i < length; i++) {
          if(i >= lSize) {
            cpNumIndex[i] = 0;
          } else {
            cpNumIndex[i] = -1;
          }
        }
      }
    }
  }

  /// 选中小号
  _selectionSmall() {
    if (isClickType) {
      if (typeIndex == 2) {
        //全 默认全部选中
        var length = cpNumIndex.length;
        var lSize = length / 2;
        for (int i = 0; i < length; i++) {
          if(i >= lSize) {
            cpNumIndex[i] = -1;
          } else {
            cpNumIndex[i] = 0;
          }
        }

        _choiceCpNumAddList();

      }
    }
  }

  /// 选中 奇偶切换   odd(奇)
  _selectionParity(bool isOdd) {
    if (isClickType) {
      if (typeIndex == 3 || typeIndex == 4) {
        //全 默认全部选中
        var length = cpNumIndex.length;
        if (length % 2 == 0) {
          // length 偶数
          for (int i = 0; i < length; i++) {
            if(i%2 == 0) {
              // 偶
              cpNumIndex[i] = isOdd ? -1 : 0;
            } else {
              cpNumIndex[i] = isOdd ? 0 : -1;
            }
          }
        } else {
          // length 奇数
          for (int i = 0; i < length; i++) {
            if((i+1)%2 == 0) {
              // 偶
              cpNumIndex[i] = isOdd ? -1 : 0;
            } else {
              cpNumIndex[i] = isOdd ? 0 : -1;
            }
          }
        }

      }
    }
  }

  /// 清空所有选中状态
  _cleanAllSelection() {
    if (typeIndex >= 0) {
      for (int i = 0; i<chooseTypeList.length; i++) {
        chooseTypeList[i] = false;
      }
    }

  }

  /// 选中彩票的数字
  _choiceCpNumAddList(){
    for (int num = 0; num < cpNumIndex.length; num++) {

      if (cpNumIndex[num] >= 0) {
        if (!choiceCpNumList.contains(cpNumStr[num])) {
          choiceCpNumList.add(cpNumStr[num]);
        }

      } else {
        if (choiceCpNumList.contains(cpNumStr[num])) {
          choiceCpNumList.remove(cpNumStr[num]);
        }
      }
    }
//    print("选中的号码");
//    if (choose11and5interface != null) {
//      choose11and5interface.choiceNumAfter();
//    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (cpNumStr != null) {
      for (int i = 0;i < cpNumStr.length; i++) {
        cpNumBool.add(false);
      }
    }
  }

  /// 改变彩票类型选择状态
  _changeCpTypeChoiceState() {
    if (typeIndex >= 0) {

      for (int i = 0; i<chooseTypeList.length; i++) {
        chooseTypeList[i] = false;
      }
      if(typeIndex != 5) {
        chooseTypeList[typeIndex] = true;

        switch (typeIndex) {
          case 0:
            _selectionAll();
            break;
          case 1:
            _selectionBig();
            break;
          case 2:
            _selectionSmall();
            break;
          case 3:
            _selectionParity(true);
            break;
          case 4:
            _selectionParity(false);
            break;
          default:
        }
      }

    }

    if (cpNumIndex != null && cpNumIndex.length > 0) {
      for (int num = 0; num < cpNumIndex.length; num++) {
        if(cpNumIndex[num] >= 0) {
          cpNumBool[num] = true;
        } else {
          cpNumBool[num] = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Column(
      children: <Widget>[
        // 45 + 24 + 40 + 40 + 15 + 1
        _chooseTypeView(),
        _chooseTitle(this.titleTip),
        _gridList(),
        CommonView().commonLine_NoMargin(context),

      ],
    );
  }

  _chooseTypeView() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0,right: 15.0, top: 15.0),
      child: new Row(
        children: <Widget>[

          _chooseTitleOne(this.titleTip),
//          _chooseType(titleTip, ColorUtil.whiteColor, -1),

          _chooseType("全", chooseTypeList[0] ?ColorUtil.textColor_FF8814: ColorUtil.textColor_888888, 0),
          _chooseType("大", chooseTypeList[1] ?ColorUtil.textColor_FF8814:ColorUtil.textColor_888888, 1),
          _chooseType("小", chooseTypeList[2] ?ColorUtil.textColor_FF8814:ColorUtil.textColor_888888, 2),
          _chooseType("奇", chooseTypeList[3] ?ColorUtil.textColor_FF8814:ColorUtil.textColor_888888, 3),
          _chooseType("偶", chooseTypeList[4] ?ColorUtil.textColor_FF8814:ColorUtil.textColor_888888, 4),
          _chooseType("清", chooseTypeList[5] ?ColorUtil.textColor_FF8814:ColorUtil.textColor_888888, 5),

        ],
      ),
    );
  }

  /// 全 大 小  奇 偶  清
  _chooseType(String title, int colorId, int index) {

    return new Align(
      alignment: Alignment.center,
      child: new Container(
        height: 30.0  ,
        width: 40.0,
        margin: EdgeInsets.only( right: 10.0),
        child: new RaisedButton(onPressed: (){
          //

          if (index == 5) {
            if (choose11and5interface != null) {
              choose11and5interface.cleanAllState(viewIndex);
            }
          } else {
            if (choose11and5interface != null) {
              choose11and5interface.cpTypeChoiceState(index, viewIndex);
            }
          }

        },color: Color(ColorUtil.whiteColor),
          child: new Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(colorId),
            ),
            textAlign: TextAlign.center,
          ),
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(colorId),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  /// 位数标题显示
  Widget _chooseTitle(String title) {

    return new Visibility(
      visible: title.length >= 2,
        child: new Align(
          alignment: Alignment.centerLeft,
          child: new Container(
            margin: EdgeInsets.only(left: 15.0, top: 15.0),
            child: new Text(
              title,
              style: new TextStyle(
                color: Color(ColorUtil.textColor_333333),
                fontSize: 14.0,
              ),
            ),
          ),
        ),
    );
  }

  Widget _chooseTitleOne(String title) {

    return new Visibility(
      visible: title.length == 1,
        child: new Align(
          alignment: Alignment.center,
          child: new Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0),
            child: new Text(
              title,
              style: new TextStyle(
                color: Color(ColorUtil.textColor_333333),
                fontSize: 14.0,
              ),
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
        crossAxisCount: 5,
        //padding: const EdgeInsets.all(8.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 1.4,
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

        if (choose11and5interface != null) {
          choose11and5interface.cpNumChoiceState(index,viewIndex);
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

  /// 选中刷新
  chooseCpNumViewListRefresh(List<int> cpNumList, bool isClickType, int index) {
    //this.cpNumIndex = cpNumList;
    this.cpNumIndex[index] = this.cpNumIndex[index] == 0 ? -1 : 0;
    this.isClickType = isClickType;
    _changeCpTypeChoiceState();
    if (mounted)
      setState(() {

      });
  }

  /// 选中刷新 包胆 刷新 只能选择一个（河内一分彩）
  chooseCpNumViewListPlayBraveryRefresh(int playID, List<int> cpNumList, bool isClickType, int index) {
    var length = cpNumIndex.length;
    for (var i = 0; i < length; i++) {
      cpNumIndex[i] = -1;
    }
    this.cpNumIndex[index] = this.cpNumIndex[index] == 0 ? -1 : 0;
    this.isClickType = isClickType;
    _changeCpTypeChoiceState();
    if (mounted)
      setState(() {

      });
  }

  /// 大小单双
  chooseCpNumViewListTypeIndexList(int _typeIndexList, bool isClickType) {
    this.typeIndex = _typeIndexList;
    this.isClickType = isClickType;
    _changeCpTypeChoiceState();
    if (mounted)
      setState(() {

      });
  }

  /// 大小单双  号码
  chooseCpNumViewListTypeIndexRefresh(List<int> cpNumList, int _typeIndexList, bool isClickType, int index) {

    this.cpNumIndex = cpNumList;
    this.typeIndex = _typeIndexList;
    this.isClickType = isClickType;
    _changeCpTypeChoiceState();
    if (mounted)
      setState(() {

      });
  }

  // 初始化 选中状态
  _initChoiceNumListState() {
    if (choiceCpNumList == null) {
      choiceCpNumList = new List();
    }
    var length = cpNumIndex.length;
    for (var i = 0; i < length; i++) {
      cpNumIndex[i] = -1;
    }
    this.typeIndex = 5;
    this.isClickType = false;
    _cleanAllSelection();
  }

  /// 随机选中 baseNum 随机基数
  randomChoiceCpNum(int playID, int baseNum) {
//    if (choiceCpNumList == null) {
//      choiceCpNumList = new List();
//    }
    var length = cpNumIndex.length;
//    for (var i = 0; i < length; i++) {
//      cpNumIndex[i] = -1;
//    }
//    this.typeIndex = 5;
//    this.isClickType = false;
//    _cleanAllSelection();
    _initChoiceNumListState();
    if(playID == 180 || playID == 198 || playID == 203 ||
        playID == 349 ||
        //河内5分彩
        playID == 512 || playID == 525 || playID == 536 ||
        //腾讯5分彩
        playID == 679 || playID == 690 ||
        //腾讯10分彩
        playID == 834 || playID == 845 ||
        //奇趣一分彩
        playID == 1078 || playID == 1079 || playID == 1080 || playID == 989 || playID == 1000||
        //奇趣5分彩
        playID == 1098 || playID == 1110 || playID == 1123 || playID == 1136 || playID == 1147||
        //奇趣10分彩
        playID == 1241 || playID == 1253 || playID == 1266 || playID == 1279 || playID == 1290


    ) {
      // 包胆 只能选择一个
      cpNumIndex[Random().nextInt(length)] = 0;
    } else {
      var randomNum = Random().nextInt(4) + baseNum;

      for (var i = 0; i <= randomNum; i++) {
        // 所选号码不能重复
        var cpNumIndexRandomPage = cpNumIndex[Random().nextInt(length)];

        if (cpNumIndexRandomPage == 0) {
          while (cpNumIndexRandomPage == 0) {
            cpNumIndexRandomPage = cpNumIndex[Random().nextInt(length)];
            if (cpNumIndexRandomPage != 0) {
              cpNumIndex[Random().nextInt(length)] = 0;
              break;
            }
          }
        } else {
          if (cpNumIndexRandomPage != 0) {
            cpNumIndex[Random().nextInt(length)] = 0;
          }
        }
      }
    }

    _changeCpTypeChoiceState();
    if (mounted)
      setState(() {

      });
  }

  /**
   * cyclicNum 循环次数
   * isRepeat 是否是重号
   *
   */
  /// 循环选号
  _cyclicSelectionNumList(int cyclicNum, int length, bool isRepeat) {
    _initChoiceNumListState();
    for (int i = 0; i < cyclicNum; i++) {
      var nextInt = Random().nextInt(length);
      // 所选号码不能重复
      if (cpNumIndex[nextInt] == 0) {
        while(cpNumIndex[nextInt] == 0) {
          nextInt = Random().nextInt(length);
          if (cpNumIndex[nextInt] != 0) {
            cpNumIndex[nextInt] = 0;
            break;
          }

        }
      } else {
        if (cpNumIndex[nextInt] != 0) {
          cpNumIndex[nextInt] = 0;
        }
      }
    }

  }

  ///带有 重号 时 选择
  repeatRandomNumChoiceList(int index, int playID, int baseNum) {
    // 腾讯一分彩组选60 30 后四组选 12
    var length = cpNumIndex.length;
    if (playID == 287 || playID == 288 || playID == 301 ||
        playID == 619 || playID == 620 || playID == 631 ||
        playID == 774 || playID == 775 || playID == 786) {
      // 二重号
      if (index == 0) {
        if (playID == 619 || playID == 631 || playID == 774 ||
            playID == 786 || playID == 287 || playID == 301) {
          // 组选 60 组选 12
          _initChoiceNumListState();
          cpNumIndex[Random().nextInt(length)] = 0;
        } else {
          // 组选 30
          _cyclicSelectionNumList(2, length, false);
          ///
        }

      } else {
        // 不等于 0 时
        var randomCyclicNum = Random().nextInt(4) + baseNum;
        _cyclicSelectionNumList(randomCyclicNum, length, true);
        ///

      }

    }

    if (playID == 289 || playID == 621 || playID == 776) {
      // 三重号
      if (index == 0) {
        // 组选 20
        _initChoiceNumListState();
        cpNumIndex[Random().nextInt(length)] = 0;

      } else {
        // 不等于 0 时
        var randomCyclicNum = Random().nextInt(4) + baseNum;
        _cyclicSelectionNumList(randomCyclicNum, length, true);
        ///
      }

    }

    if (playID == 290 || playID == 303 ||
        playID == 622 || playID == 633 ||
        playID == 777 || playID == 788) {
      // 组选 10 / 后四 组选 4
      // 三重号
      _initChoiceNumListState();
      cpNumIndex[Random().nextInt(length)] = 0;

    }

    if (playID == 302 || playID == 632 || playID == 787) {
      // 后四组选 6
      var randomCyclicNum = Random().nextInt(4) + baseNum;
      _cyclicSelectionNumList(randomCyclicNum, length, true);
    }


    _changeCpTypeChoiceState();
    if (mounted)
      setState(() {

      });

  }

  //清空状态
  cleanChoiceState() {
    var length = cpNumIndex.length;
    for (var i = 0; i < length; i++) {
      cpNumIndex[i] = -1;
    }

    for (var i = 0; i < cpNumBool.length; i++) {
      cpNumBool[i] = false;
    }
    _cleanAllSelection();
    if (mounted)
      setState(() {

      });
  }

  /// 获取选择列表
  getChoiceCpNumList() {
    return choiceCpNumList;
  }

}