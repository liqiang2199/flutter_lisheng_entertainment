
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_find_view/Choose11And5View.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BettingNumAndOperationHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BonusAdjustmentInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5EditContentHandle.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5Interface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumAndOperationView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumSingleFormEditView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BonusAdjustmentView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/DragonTigerSumView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LotteryNumListView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LotteryTimeNumView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/hanoi_util/HanoiPlayModelChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/hanoi_util/HanoiPlayModelChoiceUtils.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import 'OptionalGroupFormView.dart';
import 'OptionalSingleFormView.dart';

class VietnamHanoiOneLotteryBettingView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VietnamHanoiOneLotteryBettingView();
  }


}

class _VietnamHanoiOneLotteryBettingView extends BaseController<VietnamHanoiOneLotteryBettingView> implements BettingNumAndOperationHandler
, BonusAdjustmentInterface,Choose11And5Interface, Choose11And5EditContentHandle, HanoiPlayModelChoiceInterface, VietnamHanoiBettingHandler{

  /// 彩票数
  List<String> cpNumStr = ["00","01","02","03","04","05","06","07","08","09"];

  int bettingMultipleNum = 1;//投注倍数
  int _segmentedIndex = 0;//元角分厘 下标
  double sliderValue = 1800.0;// 奖金调节 滑动距离
  String playMoneyAward;//玩法奖金
  CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额

  /// 倒计时开奖时间 玩法规则说明
  bool isLookLotteryTitle = false;//查看下拉历史开奖号码
  String playRemark;//玩法规则说明
  String openLotteryTime = "00:00:00";//开奖时间
  String openLotteryDrawIssue = "00000";//当前期数
  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen = new List();//

  List<int> _typeIndexList = new List();/// 选择彩种 大小单双 类型
  List<String> _groupTitleList = new List();/// 每组选择列表标题
  List<List<int>> groupCpNumList = new List();/// 选择彩票集合
  List<List<String>> choiceCpNumList = new List();//选中彩票的集合
  Play11Choice5DataPlayBeen currentPlayBeen;/// 当前玩法Been

  bool isClickType = false;//是否点击类型
  int _choiceTypeGroupNum = 3;//选号组数多少
  String editContentSingle = "";//单式玩法的 输入号码

  /// 当前选择的玩法列表
  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();

  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: false,
  );

  /**
   * isSingle 是否是单式
   * sumValue 是否是和值
   * cpChoiceNum 需要彩票 行数
   * cpChoiceTitle 如果 cpChoiceNum == 1 时 就需要 这个标题
   * isGroupSumNum 是组选和值 (1 - 26)还是直选和值 (0 - 27)
   * isDragonTiger 是否是 新龙虎
   *
   */
  ///
  bool _isSingle = false;
  bool _sumValue = false;
  bool _isGroupSumNum = false;
  bool _isDragonTiger = false;
  int _cpChoiceNum = 3;
  String _cpChoiceTitle = "";
  bool isCurrentOptionalCp = false;/// 当前是否是任选

  /// key 局部刷新
  GlobalKey<LotteryTimeNumChildView> textKey = GlobalKey();//开奖时间
  GlobalKey<OptionalSingleFormStateView> singleFormStateKey = GlobalKey();//任选单式
  GlobalKey<DragonTigerSumStateView> dragonTigerStateKey = GlobalKey();//新龙虎
  GlobalKey<BonusAdjustmentStateView> adjustmentKey = GlobalKey();//奖金调节
  GlobalKey<OptionalGroupFormStateView> optionalGroupFormKey = GlobalKey();//任选组选
  /// 彩票列表 选号 key
  List<GlobalKey> listCpNumKey = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //读取保存的值
    /// 读取保存 的顶部内容
    List<Map<dynamic, dynamic>> playModel = SpUtil.getObjectList("PlayModeHanoiOneList");
    if(playModel != null && playModel.length != null && playModel.length > 0) {
      playModel.forEach((value) {
        var play11choice5dataPlayBeen = Play11Choice5DataPlayBeen.fromJson(value);
        play11choice5dataPlayBeen.isChoiceType = false;
        playModeBeenList.add(play11choice5dataPlayBeen);
      });
      if (playModeBeenList != null && playModeBeenList.length > 0) {
        playRemark = playModeBeenList[0].remark;
        playMoneyAward = playModeBeenList[0].money_award;
        playModeBeenList[0].isChoiceType = true;
        _getPlayModeChoiceNumList(playModeBeenList[0]);
      }
    } else {
      playModeBeenList.clear();
      _initPlayModelChoiceOne(false);
    }
    _initGroupCpNum();

  }

  _initPlayModelChoiceOne(bool isChoice) {
    Play11Choice5DataPlayBeen play11choice5dataPlayBeen = new Play11Choice5DataPlayBeen(147, 15, 146, "前三直选复式", "0", "1", "0.000", "1.000"
        , "投注方案：345； 开奖号码：345，即中前三直选一等奖\r\n从万、千、百位中选择一个3位号码组成一注，所选号码与开奖号码的前3位相同，且顺序一致，即为中奖。");

    play11choice5dataPlayBeen.isGroupSelection = false;
    play11choice5dataPlayBeen.playMode = 1;
    play11choice5dataPlayBeen.playModeTitle = "";
    play11choice5dataPlayBeen.playModeSingleOrDouble = 2;
    play11choice5dataPlayBeen.isChoiceType = true;
    play11choice5dataPlayBeen.groupSelectionNum = 3;
    playRemark = play11choice5dataPlayBeen.remark;
    playMoneyAward = play11choice5dataPlayBeen.money_award;
    playModeBeenList.add(play11choice5dataPlayBeen);
    HanoiPlayModelChoiceUtils.getInstance().choiceTopThreeTitleTip();
    if (isChoice) {

      //切换 单式 或者 复式 或者龙虎 或者 任选
      _getPlayModeChoiceNumList(play11choice5dataPlayBeen);
      _initGroupCpNum();
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new Expanded(
          child: _notificationListenerG(),
        ),
        /// 下面投注 按钮
        BettingNumAndOperationView(
          calculationBettingNumBeen: calculationBettingNumBeen,
          operationHandler: this,
          playMoneyAward: this.playMoneyAward,
          bettingNum: bettingMultipleNum,
          moneyCompany: _segmentedIndex,
        ),

      ],
    );
  }

  Widget _notificationListenerG() {

    return new NotificationListener(
      // ignore: missing_return
      onNotification: (ScrollNotification note) {
        //print("  ${note.metrics.pixels.toInt()}  atEdge = ${note.metrics.atEdge}  extentBefore= ${note.metrics.extentBefore}");  // 滚动位置。
        int pix = note.metrics.pixels.toInt();

//        if(pix <= -60) {
//          if(!isLookLotteryList && isLookLotteryTitle && pix <= -60) {
//            //打开开奖列表
//            refreshController.refreshCompleted();
//            isLookLotteryList = true;
//            isLookLotteryTitle = false;
//            setState(() {
//
//            });
//          }
//        }
//
//        if(isLookLotteryList && !isLookLotteryTitle && pix >= 100) {
//          //关闭开奖列表
//          isLookLotteryList = false;
//          isLookLotteryTitle = true;
//          setState(() {
//
//          });
//        }
//        textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
        return false;
      },

//      child: smartRefreshBase(_listViewData()),
      child: _singleView(),
    );
  }

  Widget _singleView() {

    return new SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: scrollController,
      child: new Center(
        child: _separatedWidget(),
      ),
    );
  }

  /// 407  玩法选择  开奖时间  投注号码选择
  Widget _separatedWidget() {
    return new Column(
      children: <Widget>[
        // 53
        _getRightArrowView("玩法选择", ImageUtil.imgLotteryCenterCqSSC, 1),
        CommonView().commonLine_NoMargin(context),
        // 47
        _playType(),
        CommonView().commonLine_NoMarginChange(context, 10.0),
        //14 + 8 + 8 + 2 + (25 + 8 + 8) + 14
        LotteryTimeNumView(
          key: textKey,
          is11Choice5: false,
          isOpenLotteryList: isLookLotteryTitle,
          playRemark: this.playRemark,
          openLotteryTime: openLotteryTime,
          openLotteryDrawIssue: openLotteryDrawIssue,
          openLotteryListBeen: openLotteryListBeen,
        ),
        CommonView().commonLine_NoMarginChange(context, 10.0),

        new Column(
          children: <Widget>[
            // 200
//            LotteryNumListView(
//              isLookLotteryList: isLookLotteryList,
//              openLotteryListBeen: openLotteryListBeen,
//            ),
            //187 头部   + 60 标题
            //45 + 24 + 40 + 40 + 15 + 1 = 165(单个)
            _numTypeChoiceView(),

            /// 奖金调节
            BonusAdjustmentView(
              key: adjustmentKey,
              adjustmentInterface: this,
              multipleNum: bettingMultipleNum,
              segmentedIndex: _segmentedIndex,
              sliderValue: this.sliderValue,
            ),

          ],
        ),
      ],
    );
  }

  bool isCanLoadMore() {
    return false;
  }

  /// 选择玩法
  _getRightArrowView(String title, String icon, int index) {

    return new GestureDetector(
      onTap: () {
        switch(index) {
          case 1:
          //玩法选择
            Navigator.pushNamed(context,
              RouteUtil.playModeHanoiOneLotteryController,
              arguments: playModeBeenList,
            ).then((value){
              //回传的数据
              if (value != null) {
                playModeBeenList = value;

                if (playModeBeenList.length > 0) {
                  playModeBeenList.forEach((value) {
                    value.isChoiceType = false;
                  });
                  playRemark = playModeBeenList[0].remark;
                  playModeBeenList[0].isChoiceType = true;
                  playMoneyAward = playModeBeenList[0].money_award;
                  _getPlayModeChoiceNumList(playModeBeenList[0]);
                  _initGroupCpNum();
                }

              } else {

                if (playModeBeenList  != null && playModeBeenList.length <= 0) {
                  playModeBeenList.clear();
                  _initPlayModelChoiceOne(true);

                }
                if (playModeBeenList  != null && playModeBeenList.length > 0) {
                  /// 当前第一个
                  playModeBeenList.forEach((value) {
                    value.isChoiceType = false;
                  });
                  playRemark = playModeBeenList[0].remark;
                  playModeBeenList[0].isChoiceType = true;
                  playMoneyAward = playModeBeenList[0].money_award;
                  _getPlayModeChoiceNumList(playModeBeenList[0]);
                  _initGroupCpNum();
                }
                SpUtil.putObjectList("PlayModeHanoiOneList", playModeBeenList);

              }

            });
            textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
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
          playRemark = playBeen.remark;
          playMoneyAward = playBeen.money_award;
          _getPlayModeChoiceNumList(playBeen);
          _initGroupCpNum();
          setState(() {

          });
          currentPlayBeen = playBeen;
          textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);

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
  ///
  Widget _numTypeChoiceView() {

    return new Column(
      children: _numTypeChoiceListView(),
    );
  }

  /// 选号  1. 先看单式 还是 复式  2. 新龙虎 3. 任选 多一个标题
  List<Widget> _numTypeChoiceListView() {

    List<Widget> listView = new List();

    if (!_isSingle) {

      if (isCurrentOptionalCp) {
        /// 是任选 组选
        _initGroupCpNum();
        if (_choiceTypeGroupNum > 1) {

          for(int i = 0; i < _choiceTypeGroupNum; i++) {
            listView.add(Choose11And5View(key:listCpNumKey[i],choose11and5interface: this, typeIndex: _typeIndexList[i],
              cpNumIndex: groupCpNumList[i], isClickType: isClickType,
              viewIndex: i, titleTip: _groupTitleList[i], choiceCpNumList: choiceCpNumList[i], cpNumStr: cpNumStr,));
          }
        } else {
          for(int i = 0; i < _choiceTypeGroupNum; i++) {
            listView.add(OptionalGroupFormView(optionalGroupFormKey,choose11and5interface: this, typeIndex: _typeIndexList[i],
              cpNumIndex: groupCpNumList[i], isClickType: isClickType,
              viewIndex: i, titleTip: _groupTitleList[i], choiceCpNumList: choiceCpNumList[i], cpNumStr: cpNumStr,));
          }
        }


      } else {
        /// 非任选
        if (_isDragonTiger) {
          // 新龙虎
          listView.add(DragonTigerSumView(dragonTigerStateKey));
        } else {

          if (_sumValue) {
            // 是 和值
            if (_isGroupSumNum) {
              // 是 组选和值
              _initGroupCpSumNum(0, 27);
            } else {
              _initGroupCpSumNum(0, 28);
            }
          } else {
            // 非和值
            _initGroupCpNum();

          }
          for(int i = 0; i < _choiceTypeGroupNum; i++) {
            listView.add(Choose11And5View(key:listCpNumKey[i],choose11and5interface: this, typeIndex: _typeIndexList[i],
              cpNumIndex: groupCpNumList[i], isClickType: isClickType,
              viewIndex: i, titleTip: _groupTitleList[i], choiceCpNumList: choiceCpNumList[i], cpNumStr: cpNumStr,));
          }
        }
      }


    } else {
      /// 单式
      if (isCurrentOptionalCp) {
        /// 任选 单式
        listView.add(OptionalSingleFormView(singleFormStateKey));
      } else {
        listView.add(BettingNumSingleFormEditView(
          editContent: editContentSingle,
          contentHandle: this,
          singleFormBaseNum: 1,
          singleFormMaxNum: 9,
          singleFormTotalNum: 3,
        ));
      }

    }

    return listView;
  }

  /// 初始化 选择 类型 和 数字 数据
  _initGroupCpNum() {
    groupCpNumList.clear();
    _typeIndexList.clear();
    choiceCpNumList.clear();//清空这次选中的数字列表
    cpNumStr.clear();
    listCpNumKey.clear();
    for (int cp = 0; cp < 10; cp++) {
      cpNumStr.add("$cp");
    }
    for(int i = 0; i < _choiceTypeGroupNum; i++) {

      List<int> _cpNumIndex = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ];//彩票数字 是否选择标志
      groupCpNumList.add(_cpNumIndex);
      int _typeIndex = -1; // 选择彩种 大小单双 类型
      _typeIndexList.add(_typeIndex);
      choiceCpNumList.add(new List<String>());
      GlobalKey<Choose11And5StateView> _chooseCpNumViewKey = new GlobalKey();
      listCpNumKey.add(_chooseCpNumViewKey);
    }
  }

  /// 和值初始化
  _initGroupCpSumNum(int startNum ,int num) {
    groupCpNumList.clear();
    _typeIndexList.clear();
    choiceCpNumList.clear();//清空这次选中的数字列表
    cpNumStr.clear();
    listCpNumKey.clear();
    for (int cp = startNum; cp < num; cp++) {
      cpNumStr.add("$cp");
    }
    for(int i = 0; i < _choiceTypeGroupNum; i++) {
      List<int> _cpNumIndex = new List();
      for (int cp = startNum; cp < num; cp++) {
        //List<int> _cpNumIndex = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ];//彩票数字 是否选择标志
        _cpNumIndex.add(-1);
      }
      groupCpNumList.add(_cpNumIndex);

      int _typeIndex = -1; // 选择彩种 大小单双 类型
      _typeIndexList.add(_typeIndex);
      choiceCpNumList.add(new List<String>());

      GlobalKey<Choose11And5StateView> _chooseCpNumViewKey = new GlobalKey();
      listCpNumKey.add(_chooseCpNumViewKey);

    }
  }

  /// 选择彩种
  _getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen) {
    currentPlayBeen = playBeen;
    if (playBeen.playMode == 8) {
      /// 任选
      isCurrentOptionalCp = true;
    } else {
      /// 非任选
      isCurrentOptionalCp = false;
    }
    HanoiPlayModelChoiceUtils.getInstance().getPlayModeChoiceNumList(playBeen, this);
  }

  /// 随机选号
  _randomChoiceCpNum() {
    if (_isSingle) {
      //单式
      editContent11Choose5Handle("");
      _randomSingleFormEditGetCpNum(HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBase(currentPlayBeen));
    } else {
      _initGroupCpNum();
      if (isCurrentOptionalCp) {
        //是任选
        if (_choiceTypeGroupNum > 1) {
          for (int i = 0; i < listCpNumKey.length; i++) {
            GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
            chooseCpNumKey.currentState.randomChoiceCpNum(HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(currentPlayBeen));
          }
          Future.delayed(Duration(milliseconds: 2000)).then((e) {
            HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(currentPlayBeen, choiceCpNumList, this);
          });
        } else {
          //组选
          optionalGroupFormKey.currentState.randomOptionalGroupNumView(currentPlayBeen);
        }

      } else {

        if (_isDragonTiger) {
          // 龙虎和
          dragonTigerStateKey.currentState.randomDragonTigerChoiceNum();
        } else {
          for (int i = 0; i < listCpNumKey.length; i++) {
            GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
            chooseCpNumKey.currentState.randomChoiceCpNum(HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(currentPlayBeen));
          }
          Future.delayed(Duration(milliseconds: 2000)).then((e) {
            HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(currentPlayBeen, choiceCpNumList, this);
          });
        }

      }


    }
  }

  /// 单式随机获取获取
  _randomSingleFormEditGetCpNum(int num) {
    Set<String> setSingleNum = new Set();
    choiceCpNumList.clear();
    while (setSingleNum.length != num) {
      int index = Random().nextInt(9);
      setSingleNum.add(cpNumStr[index]);
    }
    StringBuffer stringBuffer = new StringBuffer();
    /// 单式
    setSingleNum.forEach((value){
      stringBuffer.write(value);
    });
    stringBuffer.write(",");
    editContent11Choose5Handle("${stringBuffer.toString()},");
    /// 发送请求注数
    Future.delayed(Duration(milliseconds: 1000)).then((e) {

    });

  }

  /**
   * BonusAdjustmentInterface, 调节
   */
  ///
  @override
  void bettingMultipleAddAndSub(bool isAdd, int num) {
    bettingMultipleNum = num;
    adjustmentKey.currentState.bonusAdjustmentRefreshState(_segmentedIndex,sliderValue, bettingMultipleNum);
  }

  @override
  void butAddNumber() {
    //添加号码
  }

  @override
  void butImmediateBet() {
    //立即投注
  }

  @override
  void butMachineSelection() {
    //机选
    _randomChoiceCpNum();
  }

  @override
  void butShopCart() {
    // 购物车
  }

  @override
  void setSegmentedIndex(int index) {
    _segmentedIndex = index;
    adjustmentKey.currentState.bonusAdjustmentRefreshState(_segmentedIndex,sliderValue, bettingMultipleNum);
  }

  @override
  void sliderChangeNum(double sliderValue) {
    this.sliderValue = sliderValue;
    adjustmentKey.currentState.bonusAdjustmentRefreshState(_segmentedIndex,sliderValue, bettingMultipleNum);
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

  /**
   * Choose11And5Interface
   */
  ///
  @override
  void choiceNumAfter() {

    /// 请求注数
    ///addBettingAndBettingNum(false, 0);
  }

  @override
  void cleanAllState(int viewOnClickIndex) {
    var groupCpNum = groupCpNumList[viewOnClickIndex];
    for (int j = 0; j < groupCpNum.length; j++) {
      groupCpNum[j] = -1;
    }
    isClickType = false;
    _typeIndexList[viewOnClickIndex] = 5;
    if (isCurrentOptionalCp && _choiceTypeGroupNum == 1) {
      optionalGroupFormKey.currentState.optionalGroupCpNumViewListTypeIndexRefresh(groupCpNum, _typeIndexList[viewOnClickIndex], isClickType);
    } else {
      GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
      cpNumKey.currentState.chooseCpNumViewListTypeIndexRefresh(groupCpNum, _typeIndexList[viewOnClickIndex], isClickType);
    }

    Future.delayed(Duration(milliseconds: 300)).then((e) {
      HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(currentPlayBeen, choiceCpNumList, this);

    });
  }

  @override
  void cpNumChoiceState(int index, int viewOnClickIndex) {
    isClickType = false;

    List<int> cpNumList = groupCpNumList[viewOnClickIndex];
    cpNumList[index] = cpNumList[index] == 0 ? -1 : 0;
    if (isCurrentOptionalCp && _choiceTypeGroupNum == 1) {
      optionalGroupFormKey.currentState.optionalGroupCpNumViewListRefresh(cpNumList, isClickType);
    } else {
      GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
      cpNumKey.currentState.chooseCpNumViewListRefresh(cpNumList, isClickType);
    }


    Future.delayed(Duration(milliseconds: 300)).then((e) {
      HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(currentPlayBeen, choiceCpNumList, this);

    });
  }

  @override
  void cpTypeChoiceState(int index, int viewOnClickIndex) {
    isClickType = true;

    //刷新界面
    _typeIndexList[viewOnClickIndex] = index;

    if (isCurrentOptionalCp && _choiceTypeGroupNum == 1) {
      optionalGroupFormKey.currentState.optionalGroupCpNumViewListTypeIndexList(_typeIndexList[viewOnClickIndex], isClickType);
    } else {
      GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
      cpNumKey.currentState.chooseCpNumViewListTypeIndexList(_typeIndexList[viewOnClickIndex], isClickType);
    }

    Future.delayed(Duration(milliseconds: 300)).then((e) {
      HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(currentPlayBeen, choiceCpNumList, this);

    });
  }

  /**
   * Choose11And5EditContentHandle
   */
  ///
  @override
  void editContent11Choose5Handle(String strContent) {
    this.editContentSingle = strContent;
    /// 只刷新局部
    if(mounted)
      setState(() {
      });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    scrollController.dispose();
    super.dispose();
  }

  /**
   * HanoiPlayModelChoiceInterface 玩法类型 选择回调
   */
  ///
  @override
  void setHanoiPlayChoiceValue(bool isSingle, bool sumValue, int cpChoiceNum,
      String cpChoiceTitle, bool isGroupSumNum, bool isDragonTiger,  List<String> groupTitleList) {
    _isSingle = isSingle;
    _sumValue = sumValue;

    _cpChoiceNum = cpChoiceNum;
    _choiceTypeGroupNum = cpChoiceNum;
    _groupTitleList = groupTitleList;

    _cpChoiceTitle = cpChoiceTitle;
    _isGroupSumNum = isGroupSumNum;
    _isDragonTiger = isDragonTiger;

    if (mounted) {
      setState(() {

      });
    }

  }

  /**
   * VietnamHanoiBettingHandler  通知更新
   */
  ///
  @override
  void getCalculationBettingNumData(CalculationBettingNumDataBeen data) {
    // TODO: implement getCalculationBettingNumData
  }

}