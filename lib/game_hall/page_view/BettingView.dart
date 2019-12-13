
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/GameConstant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BettingNumAndOperationHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5EditContentHandle.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5Interface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumAndOperationView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumSingleFormEditView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BonusAdjustmentView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/CalculationBettingNumHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/GameGd11Choice5Service.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import '../cp_find_view/Choose11And5View.dart';

class BettingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BettingView();
  }

}

class _BettingView extends BaseController<BettingView> implements Choose11And5Interface
,CalculationBettingNumHandler,Choose11And5EditContentHandle, BettingNumAndOperationHandler {

  int _typeIndex = -1; // 选择彩种 大小单双 类型
  List<int> _cpNumIndex = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];// 选择彩种 号码

  bool isClickType = false;
  int _choiceTypeGroupNum = 3;//选号组数多少
  List<int> _typeIndexList = new List();/// 选择彩种 大小单双 类型
  List<String> _groupTitleList = new List();/// 每组选择列表标题
  List<List<int>> groupCpNumList = new List();/// 选择彩票集合
  List<List<String>> choiceCpNumList = new List();//选中彩票的集合

  /// 当前选择的玩法列表
  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();
  String currentPlayType = GameConstant.gd11_5_1_3;//默认三码直选复式
  bool isSinglePlay = false;/// 单式玩法
  String editContentSingle = "";//单式玩法的 输入号码

  CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Play11Choice5DataPlayBeen play11choice5dataPlayBeen = new Play11Choice5DataPlayBeen(4, 9, 2, "三码直选复式", "0", "1", "2.00", "1.00"
        , "从01-11共11个号码中选择3个不重复的号码组成一注，所选号码与当期顺序摇出的5个号码中的前3个号码相同，且顺序一致，即为中奖。");

    play11choice5dataPlayBeen.isGroupSelection = false;
    play11choice5dataPlayBeen.isGroupSelection = false;
    play11choice5dataPlayBeen.playMode = 1;
    play11choice5dataPlayBeen.playModeTitle = "";
    play11choice5dataPlayBeen.playModeSingleOrDouble = 2;
    play11choice5dataPlayBeen.isChoiceType = true;
    play11choice5dataPlayBeen.groupSelectionNum = 3;

    playModeBeenList.add(play11choice5dataPlayBeen);

    _choiceThreeTitleTip();
    _initGroupCpNum();
  }

  /// 三位选号 文本提示 (默认)
  _choiceThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("第一位");
    _groupTitleList.add("第二位");
    _groupTitleList.add("第三位");
  }

  /// 二位选号 文本提示
  _choiceTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("第一位");
    _groupTitleList.add("第二位");
  }

  /// 只有一位选号
  _choiceOneTitleTip(String title) {
    _groupTitleList.clear();
    _groupTitleList.add(title);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new Expanded(
            child: new ListView(
              children: <Widget>[

                _getRightArrowView("玩法选择", ImageUtil.imgLotteryCenterCqSSC, 1),
                CommonView().commonLine_NoMargin(context),
                _playType(),
                CommonView().commonLine_NoMarginChange(context, 10.0),

                _numTypeChoiceView(),

                BonusAdjustmentView(),


              ],
            ),
        ),
        /// 下面投注 按钮
        BettingNumAndOperationView(calculationBettingNumBeen: calculationBettingNumBeen, operationHandler: this,),

      ],
    );
  }

  /// 选择玩法
  _getRightArrowView(String title, String icon, int index) {

    return new GestureDetector(
      onTap: () {
        switch(index) {
          case 1:
            //玩法选择
            Navigator.pushNamed(context, 
              RouteUtil.playMode11Choice5Controller,
              arguments: playModeBeenList,
            ).then((value){
              //回传的数据
              if (value != null) {
                playModeBeenList = value;

                if (playModeBeenList.length > 0) {
                  playModeBeenList.forEach((value) {
                    value.isChoiceType = false;
                  });
                  playModeBeenList[0].isChoiceType = true;
                  _getPlayModeChoiceNumList(playModeBeenList[0]);
                  _initGroupCpNum();
                }

                setState(() {
                  //刷新列表
                });
              }

            });
            break;
        }
      },
      child: new ListStateItemView(
        title,
        isSwitch: false,
        isRightArrow: true,
        isSetImgWh: true,
        imgH: 33.0,
        imgW: 33.0,
        leftIcon: icon,
      ),
    );
  }

  /// 获取选号组数
  _getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen) {
    ///1 三码 2 二码 3 不定胆 4 定胆位 5 任选
    switch(playBeen.playMode) {
      case 1:
        /// 三码
        _choiceTypeGroupNum = playBeen.groupSelectionNum;
        if (playBeen.playModeSingleOrDouble == 2) {
          //复式的
          isSinglePlay = false;
          if (playBeen.isGroupSelection) {
            //组选
            currentPlayType = GameConstant.gd11_5_1_6;
            _choiceOneTitleTip("选号");
          } else {
            //直选
            currentPlayType = GameConstant.gd11_5_1_3;
            _choiceThreeTitleTip();
          }
        } else {
          //单式
          isSinglePlay = true;
          if (playBeen.isGroupSelection) {
            //组选
            currentPlayType = GameConstant.gd11_5_1_5;
          } else {
            //直选
            currentPlayType = GameConstant.gd11_5_1_4;
          }
        }
        break;
      case 2:
        /// 二码

        if (playBeen.playModeSingleOrDouble == 2) {
          //复式的
          isSinglePlay = false;
          if (playBeen.isGroupSelection) {
            //组选
            currentPlayType = GameConstant.gd11_5_2_35;
            _choiceTypeGroupNum = 1;
            _choiceOneTitleTip("选号");
          } else {
            //直选
            currentPlayType = GameConstant.gd11_5_2_10;
            _choiceTypeGroupNum = 2;
            _choiceTwoTitleTip();
          }
        } else {
          //单式
          isSinglePlay = true;
          if (playBeen.isGroupSelection) {
            //组选
            currentPlayType = GameConstant.gd11_5_2_36;
          } else {
            //直选
            currentPlayType = GameConstant.gd11_5_2_11;
          }
        }
        break;
      case 3:
        isSinglePlay = false;
        currentPlayType = GameConstant.gd11_5_3_13;
        _choiceTypeGroupNum = playBeen.groupSelectionNum;
        _choiceOneTitleTip(playBeen.playModeTitle);
        break;
      case 4:
        isSinglePlay = false;
        currentPlayType = GameConstant.gd11_5_4_15;
        _choiceTypeGroupNum = playBeen.groupSelectionNum;
        _choiceThreeTitleTip();
        break;
      case 5:
        if (playBeen.playModeSingleOrDouble == 2) {
          isSinglePlay = false;
        } else {
          isSinglePlay = true;
        }
        currentPlayType = GameConstant().gbChoiceNumType(playBeen.playModeTitle,playBeen.playModeSingleOrDouble);
        _choiceTypeGroupNum = 1;
        _choiceOneTitleTip(playBeen.playModeTitle);
        break;
    }
  }

  /// 玩法方式
  _playType() {
    return new Container(
      height: 47.0,
      child: new ListView(
        //设置水平方向排列
        scrollDirection: Axis.horizontal,
        children: _playTypeList(),
      ),
    );
  }

  List<Widget> _playTypeList() {
    List<Widget> playList = new List();
    for (int i = 0; i < playModeBeenList.length; i++) {
      playList.add(_playTypeItem(playModeBeenList[i].name,
       playModeBeenList[i].isChoiceType? ColorUtil.textColor_FF8814 : ColorUtil.textColor_888888, playModeBeenList[i] ));
    }
    return playList;
  }

  // 玩法 类型
  Widget _playTypeItem(String name, int colorId, Play11Choice5DataPlayBeen playBeen) {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        height: 30.0  ,
        margin: EdgeInsets.only( left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //

          playModeBeenList.forEach((value) {
            value.isChoiceType = false;
          });
          playBeen.isChoiceType = true;
          _getPlayModeChoiceNumList(playBeen);
          _initGroupCpNum();
          setState(() {

          });

        },color: Color(ColorUtil.whiteColor),
          child: new Text(name
            , style: TextStyle(fontSize: 13.0,color: Color(colorId)),),
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

  /**
   * 号码类型选择
   */
  Widget _numTypeChoiceView() {

    return new Column(
      children: _numTypeChoiceListView(),
    );
  }


  List<Widget> _numTypeChoiceListView() {

    List<Widget> listView = new List();

    if (!isSinglePlay) {
      for(int i = 0; i < _choiceTypeGroupNum; i++) {
        listView.add(Choose11And5View(choose11and5interface: this, typeIndex: _typeIndexList[i],
          cpNumIndex: groupCpNumList[i], isClickType: isClickType,
          viewIndex: i, titleTip: _groupTitleList[i], choiceCpNumList: choiceCpNumList[i],));
      }
    } else {
      /// 单式
      listView.add(BettingNumSingleFormEditView(editContent: editContentSingle, contentHandle: this,));
    }

    return listView;
  }

  /// 初始化 选择 类型 和 数字 数据
  _initGroupCpNum() {
    groupCpNumList.clear();
    _typeIndexList.clear();
    choiceCpNumList.clear();//清空这次选中的数字列表
    for(int i = 0; i < _choiceTypeGroupNum; i++) {
      List<int> _cpNumIndex = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];//彩票数字 是否选择标志
      groupCpNumList.add(_cpNumIndex);
      int _typeIndex = -1; // 选择彩种 大小单双 类型
      _typeIndexList.add(_typeIndex);
      choiceCpNumList.add(new List<String>());
    }
  }

  /**
   * 随机选中彩票
   */
  _randomChoiceCpNum() {
    groupCpNumList.forEach((cpNumList){
      List<int> numList = cpNumList;
      for (var i = 0; i < numList.length; i++) {
        numList[i] = -1;
      }
    });
    groupCpNumList.forEach((cpNumList){
      List<int> numList = cpNumList;
      var randomNum = Random().nextInt(4)+1;

      for (var i = 0; i < randomNum; i++) {
        numList[Random().nextInt(11)] = 0;
      }
    });
  }

  /// 清空所有的选项
  _cleanChoiceState() {
    groupCpNumList.forEach((cpNumList){
      List<int> numList = cpNumList;
      for (var i = 0; i < numList.length; i++) {
        numList[i] = -1;
      }
    });

    _typeIndexList.forEach((value){
      value = -1;
    });
    setState(() {

    });
  }

  @override
  void cpNumChoiceState(int index, int viewClickIndex) {
    isClickType = false;

    setState(() {
      //刷新界面
      List<int> cpNumList = groupCpNumList[viewClickIndex];
      cpNumList[index] = cpNumList[index] == 0 ? -1 : 0;
//      _cpNumIndex[index] = _cpNumIndex[index] == 0 ? -1 : 0;
    });
    Future.delayed(Duration(milliseconds: 300)).then((e) {
      setState(() {
        choiceNumAfter();
      });
    });
  }

  @override
  void cpTypeChoiceState(int index, int viewClickIndex) {
//    for (int i = 0; i < _cpNumIndex.length; i++) {
//      _cpNumIndex[i] = -1;
//    }

    isClickType = true;
    setState(() {
      //刷新界面
      _typeIndexList[viewClickIndex] = index;

    });
    Future.delayed(Duration(milliseconds: 300)).then((e) {
      setState(() {
        choiceNumAfter();
      });
    });
  }

  @override
  void cleanAllState(int viewClickIndex) {
    var groupCpNum = groupCpNumList[viewClickIndex];
    for (int j = 0; j < groupCpNum.length; j++) {
      groupCpNum[j] = -1;
    }
//    choiceNumAfter();
    isClickType = false;
//    _typeIndex = 5;
    _typeIndexList[viewClickIndex] = 5;
    setState(() {
      
    });
    Future.delayed(Duration(milliseconds: 300)).then((e) {
      setState(() {
        choiceNumAfter();
      });
    });
  }

  @override
  void choiceNumAfter() {
    addBettingAndBettingNum(false, 0);
  }

  /**
   * 添加投注 和 注数请求
   * bettingMultiple  投注倍数
   * isAddBetting 是否在投注
   */
  void addBettingAndBettingNum(bool isAddBetting, int bettingMultiple) {

    switch(currentPlayType) {
      case GameConstant.gd11_5_1_3:
        if (choiceCpNumList.length >= 3) {
          GameGd11Choice5Service.instance.threeYardDirectlyElectedCompound(choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_1_6:
      // 三码/前三组合/复式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.threeYardCombinationCompound(choiceCpNumList[0]
              , this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_2_10:
      // 二码/前二直选/复式（计算注数）
        if (choiceCpNumList.length >= 2) {
          GameGd11Choice5Service.instance.twoYardDirectlyElectedCompound(choiceCpNumList[0]
              , choiceCpNumList[1], this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_2_35:
      // 二码/前二组合/复式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.twoYardCombinationCompound(choiceCpNumList[0]
              , this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_3_13:
      // 不定胆/前三位（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.uncertainGallbladderCombinationCompound(choiceCpNumList[0]
              , this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_4_15:
      // 定位胆/定位胆（计算注数）
        if (choiceCpNumList.length >= 2) {
          GameGd11Choice5Service.instance.certainGallbladderCombinationCompound(choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], this, isAddBetting, bettingMultiple);
        }
        break;
      default:
        //默认
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0], this
              , GameConstant().getGD11Choice5PlayID(currentPlayType), isAddBetting, bettingMultiple);
        }
        break;

    }
  }

  @override
  void getCalculationBettingNumData(CalculationBettingNumDataBeen data) {
    this.calculationBettingNumBeen = data;

    Future.delayed(Duration(milliseconds: 300)).then((e) {
      setState(() {

      });
    });
  }

  @override
  void editContent11Choose5Handle(String strContent) {
    /// 输入单式 内容
    this.editContentSingle = strContent;
    setState(() {

    });
  }

  @override
  void multipleSuccess(bool result) {
    /// 下注结果
    if (result) {
      //清空所有的选项
      _cleanChoiceState();
    }
  }

  @override
  void butAddNumber() {
  }

  @override
  void butImmediateBet() {
    //立即投注
    addBettingAndBettingNum(true, 1);
  }

  @override
  void butMachineSelection() {
    //机选
    _randomChoiceCpNum();
    setState(() {
    });

    Future.delayed(Duration(milliseconds: 300)).then((e) {
      setState(() {
        choiceNumAfter();
      });
    });

  }


}