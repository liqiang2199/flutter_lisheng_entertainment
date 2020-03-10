

import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_find_view/Choose11And5View.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5Interface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/OptionalGroupFormInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/ThousandsOfBitsChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/ThousandsOfBitsView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/odd_interest_lottery/odd_interest_util/OddInterestPlayModelChoiceUtils.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/hanoi_util/HanoiPlayModelChoiceUtils.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

/**
 * 任选组选 复式
 */

///
// ignore: must_be_immutable
class OptionalGroupFormView extends StatefulWidget{

  List<bool> cpNumBool = [false, false, false, false, false, false, false, false, false,];
  List<bool> chooseTypeList = [false, false, false, false, false, false];

  final List<String> cpNumStr;
  final int typeIndex;
  final List<int> cpNumIndex ;
  final List<String> choiceCpNumList ;//选中list 的集合

  final bool isClickType;
  final int viewIndex;
  final String titleTip;
  final Choose11And5Interface choose11and5interface;
  final OptionalGroupFormInterface optionalGroupFormInterface;

  OptionalGroupFormView(Key key,{
    this.typeIndex = -1,
    this.cpNumIndex,
    this.isClickType = false,
    this.viewIndex,
    /// 每行的文本提示
    this.titleTip,
    this.choiceCpNumList,
    this.cpNumStr,
    this.choose11and5interface,
    this.optionalGroupFormInterface,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OptionalGroupFormStateView(
        choose11and5interface: choose11and5interface,
      typeIndex:  typeIndex,
      cpNumIndex: cpNumIndex,
      isClickType: isClickType,
      viewIndex: viewIndex,
      titleTip: titleTip,
      choiceCpNumList: choiceCpNumList,
      cpNumStr: cpNumStr,
      optionalGroupFormInterface: optionalGroupFormInterface
    );
  }

}

class OptionalGroupFormStateView extends BaseController<OptionalGroupFormView> implements ThousandsOfBitsChoiceInterface{

  List<bool> cpNumBool = [false, false, false, false, false, false, false, false, false];
  List<bool> chooseTypeList = [false, false, false, false, false, false];
  List<String> groupBitsList = new List();/// 组选时 万,千,百,十,个

  List<String> cpNumStr;
  int typeIndex;
  List<int> cpNumIndex ;
  List<String> choiceCpNumList ;//选中list 的集合

  bool isClickType;
  int viewIndex;
  String titleTip;
  Choose11And5Interface choose11and5interface;
  OptionalGroupFormInterface optionalGroupFormInterface;

  OptionalGroupFormStateView({
    this.choose11and5interface,
    this.typeIndex = -1,
    this.cpNumIndex,
    this.isClickType = false,
    this.viewIndex,
    /// 每行的文本提示
    this.titleTip,
    this.choiceCpNumList,
    this.cpNumStr,
    this.optionalGroupFormInterface});


  GlobalKey<ThousandsOfBitsStateView> _bitsStateViewKey = new GlobalKey();
  GlobalKey<Choose11And5StateView> _chooseCpNumViewKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _groupCpNumAndBitsView();
  }

  Widget _groupCpNumAndBitsView() {

    return new Column(
      children: <Widget>[
        ThousandsOfBitsView(_bitsStateViewKey, bitsChoiceInterface: this,),
        Choose11And5View(key: _chooseCpNumViewKey,choose11and5interface: choose11and5interface, typeIndex: typeIndex,
          cpNumIndex: cpNumIndex, isClickType: isClickType,
          viewIndex: viewIndex, titleTip: titleTip, choiceCpNumList: choiceCpNumList, cpNumStr: cpNumStr,)

      ],
    );
  }

  /// 选中刷新
  optionalGroupCpNumViewListRefresh(List<int> cpNumList, bool isClickType, int viewOnClickIndex) {
    this.cpNumIndex = cpNumList;
    this.isClickType = isClickType;
    _chooseCpNumViewKey.currentState.chooseCpNumViewListRefresh(cpNumList, isClickType, viewOnClickIndex);
    if (mounted)
      setState(() {

      });
  }

  /// 大小单双
  optionalGroupCpNumViewListTypeIndexList(int _typeIndexList, bool isClickType) {
    this.typeIndex = _typeIndexList;
    this.isClickType = isClickType;
    _chooseCpNumViewKey.currentState.chooseCpNumViewListTypeIndexList(_typeIndexList, isClickType);
    if (mounted)
      setState(() {

      });
  }

  /// 大小单双  号码
  optionalGroupCpNumViewListTypeIndexRefresh(List<int> cpNumList, int _typeIndexList, bool isClickType, int viewOnClickIndex) {
    this.cpNumIndex = cpNumList;
    this.typeIndex = _typeIndexList;
    this.isClickType = isClickType;
    _chooseCpNumViewKey.currentState.chooseCpNumViewListTypeIndexRefresh(cpNumList, _typeIndexList, isClickType, viewOnClickIndex);
    if (mounted)
      setState(() {

      });
  }

  /// 随机彩种
  randomOptionalGroupNumView(Play11Choice5DataPlayBeen playBeen) {
    _bitsStateViewKey.currentState.randomThousandsOfBitsStateRefresh(playBeen.id);
    _chooseCpNumViewKey.currentState.randomChoiceCpNum(playBeen.id
        ,HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(playBeen));

  }

  /// 奇趣随机彩种
  randomOddInterestOptionalGroupNumView(Play11Choice5DataPlayBeen playBeen) {
    _bitsStateViewKey.currentState.randomThousandsOfBitsStateRefresh(playBeen.id);
    _chooseCpNumViewKey.currentState.randomChoiceCpNum(playBeen.id
        ,OddInterestPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(playBeen));

  }

  /// 清空选择状态
  cleanOptionalGroupNum() {
    _bitsStateViewKey.currentState.cleanThousandsOfBitsState();
    _chooseCpNumViewKey.currentState.cleanChoiceState();
  }

  /// 彩票数量
  List<String> getOptionalGroupCpNumList() {
    return _chooseCpNumViewKey.currentState.getChoiceCpNumList();
  }

  /// 获取 选中的 万,千,百,十,个
  List<String> getGroupBitsList() {

    return _bitsStateViewKey.currentState.getCheckStateThousandsOfBitsList();
  }

  /**
   * ThousandsOfBitsChoiceInterface
   * 万,千,百,十,个
   */
  ///
  @override
  void setThousandsOfBitsStateSave(Set<String> _bitsStateSet) {
    groupBitsList.clear();

    var iterator = _bitsStateSet.toList();

    iterator?.forEach((value){
      groupBitsList.add(value);
    });

    if (optionalGroupFormInterface != null) {
      optionalGroupFormInterface.getThousandsOfBitsOnClick();
    }

  }


}