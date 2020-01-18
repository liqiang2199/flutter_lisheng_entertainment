
import 'dart:async';
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/DateUtils.dart';
import 'package:flutter_lisheng_entertainment/Util/EventBusUtil.dart';
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
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/hanoi_util/DragonTigerSumInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/hanoi_util/HanoiPlayModelChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/vietnam_hanoi_one_lottery/hanoi_util/HanoiPlayModelChoiceUtils.dart';
import 'package:flutter_lisheng_entertainment/model/bus/BettingResultTabBettingRecordBus.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryDataInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/common/loading.dart';

import 'OptionalGroupFormView.dart';
import 'OptionalSingleFormView.dart';

class VietnamHanoiOneLotteryBettingView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VietnamHanoiOneLotteryBettingView();
  }


}

class _VietnamHanoiOneLotteryBettingView extends BaseController<VietnamHanoiOneLotteryBettingView> with AutomaticKeepAliveClientMixin implements BettingNumAndOperationHandler
, BonusAdjustmentInterface,Choose11And5Interface, Choose11And5EditContentHandle, HanoiPlayModelChoiceInterface, VietnamHanoiBettingHandler
,DragonTigerSumInterface{

  /// 彩票数
  List<String> cpNumStr = ["00","01","02","03","04","05","06","07","08","09"];

  int bettingMultipleNum = 1;//投注倍数
  int _segmentedIndex = 0;//元角分厘 下标
  double sliderValue = 1800.0;// 奖金调节 滑动距离
  String playMoneyAward;//玩法奖金
  CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额

  /// 倒计时开奖时间 玩法规则说明
  bool isLookLotteryTitle = true;//是否是下拉查看开奖号码 标题
  bool isLookLotteryList = false;//是否是下拉查看开奖号码
  String playRemark;//玩法规则说明
  String openLotteryTime = "00:00:00";//开奖时间
  String openLotteryDrawIssue = "00000";//当前期数
  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen = new List();//

  List<int> _typeIndexList = new List();/// 选择彩种 大小单双 类型
  List<String> _groupTitleList = new List();/// 每组选择列表标题
  List<List<int>> groupCpNumList = new List();/// 选择彩票集合
  List<List<String>> choiceCpNumList = new List();//选中彩票的集合
  Play11Choice5DataPlayBeen currentPlayBeen;/// 当前玩法Been
  List<String> groupBitsList = new List();/// 组选时 万,千,百,十,个

  bool isClickType = false;//是否点击类型
  int _choiceTypeGroupNum = 3;//选号组数多少
  String editContentSingle = "";//单式玩法的 输入号码


  Timer _countdownTimer; /// 开间时间倒计时

  /// 当前选择的玩法列表
  List<Play11Choice5DataPlayBeen> playModeBeenList = new List();

  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
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
  GlobalKey<BettingNumAndOperationStateView> numAndOperationStateViewKey = GlobalKey();//注数显示
  GlobalKey<LotteryNumListStateView> lotteryNumListStateViewKey = GlobalKey();//开奖号码
  /// 彩票列表 选号 key
  List<GlobalKey<Choose11And5StateView>> listCpNumKey = new List();

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

    VietnamHanoiService.instance.hanoiOneKjLog(this, "1", "5");
    VietnamHanoiService.instance.hanoiOneGetKjTime(this);
  }

  _initPlayModelChoiceOne(bool isChoice) {
    Play11Choice5DataPlayBeen play11choice5dataPlayBeen = new Play11Choice5DataPlayBeen(147, 15, 146, "前三直选复式", "0", "1", "0.000", "1.000"
        , "投注方案：345； 开奖号码：345，即中前三直选一等奖\r\n从万、千、百位中选择一个3位号码组成一注，所选号码与开奖号码的前3位相同，且顺序一致，即为中奖。");

    play11choice5dataPlayBeen.isGroupSelection = false;
    play11choice5dataPlayBeen.playMode = 1;
    play11choice5dataPlayBeen.playModeTitle = "";
    play11choice5dataPlayBeen.playModeSingleOrDouble = 2;
    play11choice5dataPlayBeen.isChoiceType = true;
    play11choice5dataPlayBeen.groupSelectionNum = 1;
    playRemark = play11choice5dataPlayBeen.remark;
    playMoneyAward = play11choice5dataPlayBeen.money_award;
    playModeBeenList.add(play11choice5dataPlayBeen);
    _getPlayModeChoiceNumList(play11choice5dataPlayBeen);
    if (isChoice) {

      //切换 单式 或者 复式 或者龙虎 或者 任选
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
          key: numAndOperationStateViewKey,
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

        if(pix <= -60) {
          if(!isLookLotteryList && isLookLotteryTitle && pix <= -60) {
            //打开开奖列表
            isLookLotteryList = true;
            isLookLotteryTitle = false;

          }
        }

        if(isLookLotteryList && !isLookLotteryTitle && pix >= 100) {
          //关闭开奖列表
          isLookLotteryList = false;
          isLookLotteryTitle = true;
        }
        lotteryNumListStateViewKey.currentState.onSetRefreshLotteryNumList(isLookLotteryList, openLotteryListBeen);
        textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
        return false;
      },

//      child: smartRefreshBase(_listViewData()),
      child: _singleView(),
    );
  }

  ///_separatedWidget()
  Widget _singleView() {

    return new SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: scrollController,
      child: new Center(
        child: _separatedWidget(),
      ),
    );
  }


  Widget _listViewData() {

    return new ListView(
      physics: BouncingScrollPhysics(),
      controller: scrollController,
      children: <Widget>[

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
            LotteryNumListView(
              isLookLotteryList: isLookLotteryList,
              openLotteryListBeen: openLotteryListBeen,
            ),
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


  /// 407  玩法选择  开奖时间  投注号码选择
  Widget _separatedWidget() {
    return new ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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

        LotteryNumListView(
          key: lotteryNumListStateViewKey,
          isLookLotteryList: isLookLotteryList,
          openLotteryListBeen: openLotteryListBeen,
          lotteryID: "15",
        ),
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
          if(mounted) {
            setState(() {

            });
          }

          if (numAndOperationStateViewKey != null) {
            calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额
            numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);
          }
          currentPlayBeen = playBeen;
          textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);

          if (_isDragonTiger) {
            if (dragonTigerStateKey != null && dragonTigerStateKey.currentState != null) {
              dragonTigerStateKey.currentState.cleanDragonTigerChoiceNum();
            }
          }

          if (_isSingle && !isCurrentOptionalCp) {
            // 是单式  非任选单式
            editContent11Choose5Handle("");
          }

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
          listView.add(DragonTigerSumView(dragonTigerStateKey, this));
        } else {

          if (_sumValue) {
            // 是 和值
            if (_isGroupSumNum) {
              // 是 组选和值
              if (currentPlayBeen.playMode == 4 || currentPlayBeen.playMode == 5) {
                // 前2 后2
                _initGroupCpSumNum(1, 18);
              } else {
                // 前3 后3 中3
                _initGroupCpSumNum(1, 27);
              }

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
        listView.add(OptionalSingleFormView(singleFormStateKey,this));
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
    for (int cp = 0; cp < 10; cp++) {
      cpNumStr.add("$cp");
    }
    for(int i = 0; i < _choiceTypeGroupNum; i++) {

      List<int> _cpNumIndex = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ];//彩票数字 是否选择标志
      groupCpNumList.add(_cpNumIndex);
      int _typeIndex = -1; // 选择彩种 大小单双 类型
      _typeIndexList.add(_typeIndex);
      choiceCpNumList.add(new List<String>());

    }
    print("key = ${listCpNumKey.toString()}");
  }

  /// 和值初始化
  _initGroupCpSumNum(int startNum ,int num) {
    groupCpNumList.clear();
    _typeIndexList.clear();
    choiceCpNumList.clear();//清空这次选中的数字列表
    cpNumStr.clear();
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
      if (isCurrentOptionalCp) {
        singleFormStateKey.currentState.randomEditAndCheckState(currentPlayBeen.id
            , HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBase(currentPlayBeen));
        _sendBettingNumRequest(2000, false, 0);
      } else {
        _randomSingleFormEditGetCpNum(HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBase(currentPlayBeen));
      }
    } else {
      _initGroupCpNum();

      if (mounted) {
        setState(() {
          /// 滚动到对应位置
          scrollController.animateTo( 0.0 ,
              duration: Duration(milliseconds: 200),
              curve: Curves.ease
          );
        });
      }

      var h = 0.0;
      var length = groupCpNumList.length;
      if (length == 1) {
        h =  (187 + 205 + 60 ) - (ScreenUtil.getScreenH(context) - 60 - 100) ;
      } else {
        h =  (187 + ( 205 * length) + 60 ) - (ScreenUtil.getScreenH(context) - 60 - 100) ;
      }
      if (length == 2) {
        h = h + 26;
      }

      Future.delayed(Duration(milliseconds: 500)).then((e) {

        if (isCurrentOptionalCp) {
          //是任选
          if (_choiceTypeGroupNum > 1) {
            for (int i = 0; i < listCpNumKey.length; i++) {
              GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
              chooseCpNumKey.currentState.randomChoiceCpNum(currentPlayBeen.id,
                  HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(currentPlayBeen));
              if (h < 0) {
                h = h * (-1);
              }
              scrollController.animateTo( h.toDouble() ,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.ease
              );

            }
          } else {
            //组选
            optionalGroupFormKey.currentState.randomOptionalGroupNumView(currentPlayBeen);
          }

          _sendBettingNumRequest(2000, false, 0);
        } else {

          if (_isDragonTiger) {
            // 龙虎和
            dragonTigerStateKey.currentState.randomDragonTigerChoiceNum();
            _sendBettingDragonTiger(2000, false, 0);
          } else {
            for (int i = 0; i < listCpNumKey.length; i++) {
              GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
              chooseCpNumKey.currentState.randomChoiceCpNum(currentPlayBeen.id
                  ,HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(currentPlayBeen));
              /// 滚动到对应位置 187 头部   + 80 标题
              if (h < 0) {
                h = h * (-1);
              }
              scrollController.animateTo( h.toDouble() ,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.ease
              );
            }
            _sendBettingNumRequest(1500, false, 0);
          }


        }


      });

    }
  }

  /// 任选 中 组选 万,千,百,十,个
  _getOptionalGroupBitsList() {
    if (currentPlayBeen != null) {
      if (currentPlayBeen.id == 228 || currentPlayBeen.id == 231
          || currentPlayBeen.id == 232) {
        groupBitsList = optionalGroupFormKey.currentState.getGroupBitsList();
      }
      if (currentPlayBeen.id == 227 || currentPlayBeen.id == 230) {
        groupBitsList = singleFormStateKey.currentState.getThousandsOfBitsStateStr();
      }
    }

  }

  /// 非单式 是 获取选中的号码
  _getChoiceCpNumList() {
    if (_isSingle) {
      return;
    }
    bool getNumBool = false;
    choiceCpNumList.clear();
    if (isCurrentOptionalCp) {

      if(_choiceTypeGroupNum > 1) {
        getNumBool = true;
      } else {
        if (optionalGroupFormKey != null && optionalGroupFormKey.currentState != null) {
          choiceCpNumList.add(optionalGroupFormKey.currentState.getOptionalGroupCpNumList());
        }
      }

    } else {
      getNumBool = true;
    }

    if (getNumBool) {
      for (int i = 0; i < listCpNumKey.length; i++) {
        GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
        if (chooseCpNumKey != null) {
          choiceCpNumList.add(chooseCpNumKey.currentState.getChoiceCpNumList());
        }

      }
    }

  }

  /// 发送注数请求
  _sendBettingNumRequest(int milliseconds, bool isBetting, int multiple) {
    Future.delayed(Duration(milliseconds: milliseconds)).then((e) {
      _getOptionalGroupBitsList();
      _getChoiceCpNumList();
      HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(context,currentPlayBeen, choiceCpNumList, groupBitsList, this, isBetting, multiple);

    });
  }

  /// 虎 龙 和
  _sendBettingDragonTiger(int milliseconds, bool isBetting, int multiple) {
    groupBitsList.clear();
    if (_isDragonTiger) {
      groupBitsList = dragonTigerStateKey.currentState.getRandomDragonTigerList();
    }
    Future.delayed(Duration(milliseconds: milliseconds)).then((e) {

      HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNumDragonTiger(context,currentPlayBeen, groupBitsList, this, isBetting, multiple);

    });
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
    //choiceCpNumList.add(new List<String>()..add(stringBuffer.toString()));
    editContent11Choose5Handle("${stringBuffer.toString()},");
    /// 发送请求注数
    //_sendBettingNumRequest(500);

  }

  /**
   * BonusAdjustmentInterface, 调节
   */
  ///
  @override
  void bettingMultipleAddAndSub(bool isAdd, int num) {
    bettingMultipleNum = num;
    adjustmentKey.currentState.bonusAdjustmentRefreshState(_segmentedIndex,sliderValue, bettingMultipleNum);
    numAndOperationStateViewKey.currentState.setBettingNum(num);//下注信息
  }

  @override
  void butAddNumber() {
    //添加号码
  }

  @override
  void butImmediateBet() {
    //立即投注
    if (_isDragonTiger) {
      _sendBettingDragonTiger(100, true, bettingMultipleNum);
    } else {
      _sendBettingNumRequest(100, true, bettingMultipleNum);
    }
  }

  @override
  void butMachineSelection() {
    //机选
    _randomChoiceCpNum();
    //_showLoadingDialog();
  }

  /// 加载弹窗 提示 弹窗
  _showLoadingDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog();
        });
  }

  @override
  void butShopCart() {
    // 购物车
  }

  @override
  void setSegmentedIndex(int index) {
    _segmentedIndex = index;
    adjustmentKey.currentState.bonusAdjustmentRefreshState(_segmentedIndex,sliderValue, bettingMultipleNum);
    numAndOperationStateViewKey.currentState.setBettingNumAndSlideValue(bettingMultipleNum, _segmentedIndex);//下注信息
  }

  @override
  void sliderChangeNum(double sliderValue) {
    this.sliderValue = sliderValue;
    adjustmentKey.currentState.bonusAdjustmentRefreshState(_segmentedIndex,sliderValue, bettingMultipleNum);
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
      optionalGroupFormKey.currentState.optionalGroupCpNumViewListTypeIndexRefresh(groupCpNum
          , _typeIndexList[viewOnClickIndex], isClickType, viewOnClickIndex);
    } else {
      GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
      if(cpNumKey != null) {
        cpNumKey.currentState.chooseCpNumViewListTypeIndexRefresh(groupCpNum,
            _typeIndexList[viewOnClickIndex], isClickType, viewOnClickIndex);
      }

    }

    _sendBettingNumRequest(300, false, 0);
  }

  @override
  void cpNumChoiceState(int index, int viewOnClickIndex) {
    isClickType = false;

    List<int> cpNumList = groupCpNumList[viewOnClickIndex];
    //cpNumList[index] = cpNumList[index] == 0 ? -1 : 0;
    if (isCurrentOptionalCp && _choiceTypeGroupNum == 1) {
      optionalGroupFormKey.currentState.optionalGroupCpNumViewListRefresh(cpNumList, isClickType, index );
    } else {

      GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
      if (cpNumKey != null && cpNumKey.currentState != null) {
        if(currentPlayBeen.id == 180 || currentPlayBeen.id == 198 || currentPlayBeen.id == 203) {
          // 包胆 只能选择一个
          cpNumKey.currentState.chooseCpNumViewListPlayBraveryRefresh(currentPlayBeen.id, cpNumList, isClickType, index);
        } else {
          cpNumKey.currentState.chooseCpNumViewListRefresh(cpNumList, isClickType, index);
        }

      }

    }


    _sendBettingNumRequest(300, false, 0);
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
      if(cpNumKey != null) {
        cpNumKey.currentState.chooseCpNumViewListTypeIndexList(_typeIndexList[viewOnClickIndex], isClickType);
      }

    }

    _sendBettingNumRequest(300, false, 0);
  }

  /**
   * Choose11And5EditContentHandle
   */
  ///
  @override
  void editContent11Choose5Handle(String strContent) {
    this.editContentSingle = strContent;
    if (!TextUtil.isEmpty(strContent)) {
      choiceCpNumList.clear();
      var randomBase = HanoiPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBase(currentPlayBeen);
      var splitSingleNumStr = editContentSingle.split(",");
      List<String> strNumList = new List();
      for (int sp = 0; sp < splitSingleNumStr.length; sp++) {
        var splitSingleNum = splitSingleNumStr[sp];
        if(splitSingleNum.length == randomBase) {
          strNumList.add(splitSingleNum);
        }

      }
      choiceCpNumList.add(strNumList);
      /// 发送请求注数
      _sendBettingNumRequest(100, false, 0);
      if (!isCurrentOptionalCp) {
        /// 只刷新局部
        if(mounted)
          setState(() {
          });
      }
    } else {
      calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");
      numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);
      if(mounted)
        setState(() {
        });
    }


  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    scrollController.dispose();
    _countdownTimer?.cancel();
    _countdownTimer = null;
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
    //_groupTitleList = groupTitleList;
    _groupTitleList.clear();
    groupTitleList.forEach((value){
      _groupTitleList.add(value);
    });

    _cpChoiceTitle = cpChoiceTitle;
    _isGroupSumNum = isGroupSumNum;
    _isDragonTiger = isDragonTiger;
    listCpNumKey.clear();
    if (cpChoiceNum > 0) {
      for(int i = 0; i < _choiceTypeGroupNum; i++) {
        GlobalKey<Choose11And5StateView> _chooseCpNumViewKey = new GlobalKey();
        listCpNumKey.add(_chooseCpNumViewKey);

      }
    }


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
    this.calculationBettingNumBeen = data;
    if (_isDragonTiger) {
      /// 新龙虎
      Future.delayed(Duration(milliseconds: 300)).then((e) {
        numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);
      });
    } else {

      Future.delayed(Duration(milliseconds: 300)).then((e) {
        numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);
      });

    }

  }

  /// 清空新龙虎 状态
  @override
  void cleanDragonTigerStatus(bool result) {
    numAndOperationStateViewKey.currentState.cleanDragonTigerStatusText();
  }


  void reGetCountdown(String drawTime) {
    if (_countdownTimer != null) {
      return;
    }
    textKey.currentState.onBeginTimeOpenLottery(false);
    _countdownTimer =
    new Timer.periodic(new Duration(seconds: 1), (timer) {

      var formatLongToTimeStrToDay = DateUtils.formatLongToTimeStrToDay(drawTime);
      if (formatLongToTimeStrToDay == ("00:00:00") || formatLongToTimeStrToDay == "0:0:0") {
        _countdownTimer.cancel();
        _countdownTimer = null;
        this.openLotteryTime = "";//00:00:00
        textKey.currentState.onBeginTimeOpenLotteryStatusChange(true, openLotteryDrawIssue);
        VietnamHanoiService.instance.hanoiOneGetKjTime(this);
        Future.delayed(Duration(milliseconds: 8000)).then((e) {
          // 再次请求开奖时间
          VietnamHanoiService.instance.hanoiOneKjLog(this, "1", "5");
        });

      } else {
        this.openLotteryTime = formatLongToTimeStrToDay;
        textKey.currentState.onSetRefreshState(openLotteryTime, openLotteryDrawIssue);
      }

    });
  }

  /// 开奖时间
  @override
  void openVietnamHanoiLotteryTime(String time, String numberPeriods) {
    this.openLotteryDrawIssue = numberPeriods;
    reGetCountdown(time);
  }

  /// 投注成功
  @override
  void bettingSuccessResult() {
    /// 清空界面
    showToast("投注成功");
    choiceCpNumList.clear();//清空这次选中的数字列表

    eventBus.fire(BettingResultTabBettingRecordBus());

    if (_isSingle) {
      //单式
      if (isCurrentOptionalCp) {
        // 任选单选
        calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");
        numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);
        singleFormStateKey.currentState.cleanEditText();
      } else {
        editContent11Choose5Handle("");
      }
    } else {
      calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");
      numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);
      if (isCurrentOptionalCp) {
        //是任选
        if (_choiceTypeGroupNum > 1) {
          for (int i = 0; i < listCpNumKey.length; i++) {
            GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
            chooseCpNumKey.currentState.cleanChoiceState();

          }
        } else {
          //组选
          optionalGroupFormKey.currentState.cleanOptionalGroupNum();
        }
      } else {

        if (_isDragonTiger) {
          // 龙虎和
          dragonTigerStateKey.currentState.cleanDragonTigerChoiceNum();

        } else {
          for (int i = 0; i < listCpNumKey.length; i++) {
            GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
            chooseCpNumKey.currentState.cleanChoiceState();

          }
        }


      }

    }

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void setDragonTigerSumHandler(List<String> choiceCpNumList) {
    _sendBettingDragonTiger(1000, false, 0);
  }

  /**
   * LotteryNum11Choice5Handler 获取历史开奖列表
   */
  ///
  @override
  void setAccountChangeRecord(OpenLotteryListDataBeen changeRecordBeen) {
    // 开奖记录列表
    isLookLotteryList = false;
    isLookLotteryTitle = true;
    var dataList = changeRecordBeen.data;
    var dataListBeen = dataList.data;
    this.openLotteryListBeen = dataListBeen;
    textKey.currentState.openLotteryListBeen = dataListBeen;
    textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
    lotteryNumListStateViewKey.currentState.onSetRefreshLotteryNumList(isLookLotteryList, openLotteryListBeen);
  }

}