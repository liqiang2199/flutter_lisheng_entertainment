
import 'dart:async';
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/DateUtils.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/cp_find_view/Choose11And5View.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BettingNumAndOperationHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BonusAdjustmentInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5EditContentHandle.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5Interface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/LuckyAirshipSecSumInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumAndOperationView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumSingleFormEditView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BonusAdjustmentView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LotteryNumListView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LotteryTimeNumView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LuckyAirshipDoubleSelecView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/lucky_airship_lottery/PlayModeLuckyAirshipLotteryController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/lucky_airship_lottery/lucky_airship_util/LuckyAirshipPlayModelChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/lucky_airship_lottery/lucky_airship_util/LuckyAirshipPlayModelChoiceUtils.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/lucky_airship/LuckyAirshipHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/lucky_airship/LuckyAirshipService.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';


/**
 * 幸运分艇 彩种投注 页面
 */
///
class LuckyAirshipBettingView extends StatefulWidget{

  String colorVariety;
  LuckyAirshipBettingView(this.colorVariety);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LuckyAirshipBettingView(this.colorVariety);
  }


}

class _LuckyAirshipBettingView extends BaseController<LuckyAirshipBettingView> with AutomaticKeepAliveClientMixin
    implements BettingNumAndOperationHandler
, BonusAdjustmentInterface,Choose11And5Interface, Choose11And5EditContentHandle, LuckyAirshipHandler
,LuckyAirshipPlayModelChoiceInterface, LuckyAirshipSecSumInterface{

  /// 彩票数
  List<String> cpNumStr = ["01","02","03","04","05","06","07","08","09","10"];

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

  FocusNode _focusNode = FocusNode();

  /**
   * isSingle 是否是单式
   * cpChoiceNum 需要彩票 行数
   * cpChoiceTitle 如果 cpChoiceNum == 1 时 就需要 这个标题
   * isDragonTiger 是否是 新龙虎
   * _isFiveStarsTotalNum 是否是 五星中和
   * _isContainsRepeat 是否包含重号
   *
   */
  ///
  bool _isSingle = false;
  bool _isDragonTiger = false;
  bool _isContainsRepeat = false;
  bool isCurrentOptionalCp = false;/// 当前是否是任选
  String _cpChoiceTitle = "";
  ///
  bool isOpeningLottery = false;//是否正在开奖
  bool _isFiveStarsTotalNum = false;

  /// key 局部刷新
  GlobalKey<LotteryTimeNumChildView> textKey = GlobalKey();//开奖时间
  GlobalKey<LuckyAirshipDoubleSelecStateView> dragonTigerStateKey = GlobalKey();//龙虎
  GlobalKey<BonusAdjustmentStateView> adjustmentKey = GlobalKey();//奖金调节
  GlobalKey<BettingNumAndOperationStateView> numAndOperationStateViewKey = GlobalKey();//注数显示
  GlobalKey<LotteryNumListStateView> lotteryNumListStateViewKey = GlobalKey();//开奖号码
  /// 彩票列表 选号 key
  List<GlobalKey<Choose11And5StateView>> listCpNumKey = new List();

  var screenH;
  var isScreenVisibility;
  String colorVariety;


  _LuckyAirshipBettingView(this.colorVariety);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //读取保存的值
    /// 读取保存 的顶部内容
    List<Map<dynamic, dynamic>> playModel = SpUtil.getObjectList("PlayModeLuckyAirshipList");

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
        _cpChoiceTitle = LuckyAirshipPlayModelChoiceUtils.getInstance().getBigAndSmallPlayModelTitleName(playModeBeenList[0]);
      }
    } else {
      playModeBeenList.clear();
      _initPlayModelChoiceOne(false);
    }
    _initGroupCpNum();

    LuckyAirshipService.instance.luckyAirshipKjLog(this, "1", "8", colorVariety);
    LuckyAirshipService.instance.luckyAirshipGetKjTime(this, colorVariety);
  }

  _initPlayModelChoiceOne(bool isChoice) {
    Play11Choice5DataPlayBeen play11choice5dataPlayBeen;
    if (colorVariety == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
      // 5 分彩
      play11choice5dataPlayBeen = new Play11Choice5DataPlayBeen(124, 13, 123, "前一复式", "0", "1", "99700.000", "1.000"
          , "玩法示意： 从万位、千位、百位、十位、个位各选一个号码组成一注\r\n投注方案：23456；\r\n开奖号码：23456，"
              "\r\n从万、千、百、十、个位中选择一个5位号码组成一注，所选号码与开奖号码全部相同，且顺序一致，即为中奖。");
    }

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

    return new GestureDetector(
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: new Column(
        children: <Widget>[

          new Expanded(
            child: _notificationListenerG(),
          ),
          /// 奖金调节
          BonusAdjustmentView(
            key: adjustmentKey,
            adjustmentInterface: this,
            multipleNum: bettingMultipleNum,
            segmentedIndex: _segmentedIndex,
            sliderValue: this.sliderValue,
            focusNode: _focusNode,
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
      ),
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


  /// 407  玩法选择  开奖时间  投注号码选择
  Widget _separatedWidget() {

    /// 当前个数少的时候 不能滑动
    var h = 0.0;
    var length = groupCpNumList.length;
    if (length < 3) {
      if (length == 1) {
        h =  (187 + 205 + 60 ) - (ScreenUtil.getScreenH(context)) ;
      } else {
        h =  (187 + ( 205 * length) + 60 ) - (ScreenUtil.getScreenH(context) - 60 - 100) ;
      }
      if (length == 2) {
        h = h + 26;
      }
      if (!_isFiveStarsTotalNum) {
        screenH = h.toDouble().abs() / 2 ;
      } else {
        screenH = h.toDouble().abs();
      }

      isScreenVisibility = ScreenUtil.getScreenH(context) > h;
    } else {
      isScreenVisibility = false;
    }

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
          lotteryID: "$colorVariety",
        ),
        //187 头部   + 60 标题
        //45 + 24 + 40 + 40 + 15 + 1 = 165(单个)
        _numTypeChoiceView(),

        new Visibility(
            visible: isScreenVisibility,
            child: new Container(
              height: screenH,
              color: Colors.white,
              child: new Text(""),
            )
        ),

      ],
    );
  }

  bool isCanLoadMore() {
    return false;
  }

  /// 选择玩法
  _getRightArrowView(String title, String icon, int index) {

    String titleIssue = "0";
    if (openLotteryDrawIssue != null || openLotteryDrawIssue.length > 0) {
      var length = openLotteryDrawIssue.length;
      titleIssue = "${openLotteryDrawIssue.substring(length - 3, length)}期";
    }

    return new GestureDetector(
      onTap: () {
        switch(index) {
          case 1:
          //玩法选择
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlayModeLuckyAirshipLotteryController(playModeBeenList: playModeBeenList, colorVarietyID: colorVariety,);
          }))
                .then((value){
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
                  _cpChoiceTitle = LuckyAirshipPlayModelChoiceUtils.getInstance().getBigAndSmallPlayModelTitleName(playModeBeenList[0]);
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
                  _cpChoiceTitle = LuckyAirshipPlayModelChoiceUtils.getInstance().getBigAndSmallPlayModelTitleName(playModeBeenList[0]);
                  _initGroupCpNum();
                }

                if (colorVariety == "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}") {
                  SpUtil.putObjectList("PlayModeLuckyAirshipList", playModeBeenList);
                }

              }

            });

            textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
            break;
        }
      },
      child: new Row(
        children: <Widget>[

          new Expanded(
              child: new Container(
                height: 53.0,
                child: new Row(
                  children: <Widget>[
                    SpaceViewUtil.pading_Left(10.0),
                    Image.asset(icon, width: 20.0, height: 20.0,),
                    SpaceViewUtil.pading_Left(10.0),
                    new Expanded(
                      child: new Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(ColorUtil.textColor_333333),
                        ),
                      ),
                    ),


                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        new Text(
                          "第$titleIssue",
                          style: new TextStyle(
                            color: Color(ColorUtil.textColor_333333),
                            fontSize: 14.0,
                          ),
                        ),

                        new Text(
                          "$_timeOpenLotteryTitle",
                          style: new TextStyle(
                            color: Color(openLotteryTitleColor),
                            fontSize: 14.0,
                          ),
                        ),

                        new Text(
                          "$openLotteryTime",
                          style: new TextStyle(
                            color: Color(ColorUtil.butColor),
                            fontSize: 14.0,
                          ),
                        )

                      ],
                    ),

                    //向右图标
                    new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),
                    SpaceViewUtil.pading_Right_10(),

                  ],
                ),
              ),
          ),



        ],
      ),
    );
  }

  String openLotteryDrawIssueOld;/// 记录一个之前的ID
  String _timeOpenLotteryTitle = "开奖还剩:";//开奖时间标题
  int openLotteryTitleColor = ColorUtil.textColor_333333;//开奖时间标题颜色

  void onSetRefreshState(String time, String qs) {
    this.openLotteryTime = time;
    this.openLotteryDrawIssue = qs;

    if (mounted)
      setState(() {

      });
  }

  /**
   * 如果到了开奖时间 显示正在开奖
   */
  ///
  void onBeginTimeOpenLottery(bool isBegin) {
    if (isBegin) {
      _timeOpenLotteryTitle = "正在开奖";
      this.openLotteryTime = "";
      openLotteryTitleColor = ColorUtil.textColor_FF8814;
    } else {
      _timeOpenLotteryTitle = "开奖还剩:";
      openLotteryTitleColor = ColorUtil.textColor_333333;
    }

  }

  /// 开奖状态切换改变
  void onBeginTimeOpenLotteryStatusChange(bool isBegin, String qs) {
    if (isBegin) {
      isOpeningLottery = true;
      this.openLotteryDrawIssue = qs;
      this.openLotteryDrawIssueOld = qs;
      _timeOpenLotteryTitle = "正在开奖";
      this.openLotteryTime = "";
      openLotteryTitleColor = ColorUtil.textColor_FF8814;
    }
    if (mounted)
      setState(() {

      });
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
              dragonTigerStateKey.currentState.cleanLuckyAirshipChoiceNum();
              dragonTigerStateKey.currentState.setLuckyAirshipPlayModel(currentPlayBeen.id);
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

  /// 添加 选号  1. 先看单式 还是 复式  2. 新龙虎 3. 任选 多一个标题
  List<Widget> _numTypeChoiceListView() {

    List<Widget> listView = new List();

    if (!_isSingle) {

      if (_isDragonTiger) {
        // 龙虎  大小  单双
        listView.add(LuckyAirshipDoubleSelecView(dragonTigerStateKey, this, _cpChoiceTitle, currentPlayBeen));

      } else {

        // 非 龙虎  大小  单双
        _initGroupCpNum();
        for(int i = 0; i < _choiceTypeGroupNum; i++) {
          listView.add(Choose11And5View(key:listCpNumKey[i],choose11and5interface: this, typeIndex: _typeIndexList[i],
            cpNumIndex: groupCpNumList[i], isClickType: isClickType,
            viewIndex: i, titleTip: _groupTitleList[i], choiceCpNumList: choiceCpNumList[i], cpNumStr: cpNumStr,));

        }
      }

    } else {
      /// 单式
      var randomBase = LuckyAirshipPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBaseLength(currentPlayBeen);
      listView.add(BettingNumSingleFormEditView(
        editContent: editContentSingle,
        contentHandle: this,
        singleFormBaseNum: 1,
        singleFormMaxNum: 9,
        singleFormNum: randomBase,
        singleFormTotalNum: randomBase,
      ));

    }

    return listView;
  }

  /// 初始化 选择 类型 和 数字 数据
  _initGroupCpNum() {
    groupCpNumList.clear();
    _typeIndexList.clear();
    choiceCpNumList.clear();//清空这次选中的数字列表
    cpNumStr.clear();
    for (int cp = 1; cp <= 10; cp++) {
      if (cp < 10) {
        cpNumStr.add("0$cp");
      } else {
        cpNumStr.add("$cp");
      }

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

    LuckyAirshipPlayModelChoiceUtils.getInstance().getPlayModeChoiceNumList(playBeen, this);
  }

  /// 随机选号
  _randomChoiceCpNum() {
    if (_isSingle) {
      //单式
      editContent11Choose5Handle("");
      _randomSingleFormEditGetCpNum(LuckyAirshipPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBase(currentPlayBeen));
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
      var screenH = ScreenUtil.getScreenH(context);
      if (length == 1) {
        h =  (187 + 205 + 60 ) - (screenH - 60 - 100) ;
      } else {
        if (length >= 3) {
          /// 每组号码显示 大于3 组时
          h =  (187 + ( 170 * length) + 60 ) - (screenH - 60 - 100) ;
        } else {
          h =  (187 + ( 205 * length) + 60 ) - (screenH - 60 - 100) ;
        }

      }
      if (length == 2) {
        h = h + 26;
      }

      Future.delayed(Duration(milliseconds: 500)).then((e) {

        if (_isDragonTiger) {
          // 龙虎
          dragonTigerStateKey.currentState.randomLuckyAirshipChoiceNum();
        } else {

          for (int i = 0; i < listCpNumKey.length; i++) {
            GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
            if (_isContainsRepeat) {
              chooseCpNumKey.currentState.repeatRandomNumChoiceList(i, currentPlayBeen.id
                  ,LuckyAirshipPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(currentPlayBeen));
            } else {
              chooseCpNumKey.currentState.randomChoiceCpNum(currentPlayBeen.id
                  ,LuckyAirshipPlayModelChoiceUtils.getInstance().getGamePlayModelRandomBase(currentPlayBeen));
            }

            /// 滚动到对应位置 187 头部   + 80 标题
            if (h < 0) {
              h = h * (-1);
            }
            scrollController.animateTo( h.toDouble() ,
                duration: Duration(milliseconds: 1000),
                curve: Curves.ease
            );
          }

        }
        _sendBettingNumRequest(1500, false, 0);

      });

    }
  }



  /// 非单式 是 获取选中的号码
  _getChoiceCpNumList() {
    if (_isSingle) {
      return;
    }
    choiceCpNumList.clear();

    if (_isDragonTiger) {
      choiceCpNumList.add(dragonTigerStateKey.currentState.choiceCpNumList);
    } else {
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
      _getChoiceCpNumList();
      LuckyAirshipPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(context,currentPlayBeen,
          choiceCpNumList, this, isBetting, multiple, colorVariety);
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
    editContent11Choose5Handle("${stringBuffer.toString()},");

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
    _sendBettingNumRequest(100, true, bettingMultipleNum);
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
    GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
    if(cpNumKey != null) {
      cpNumKey.currentState.chooseCpNumViewListTypeIndexRefresh(groupCpNum,
          _typeIndexList[viewOnClickIndex], isClickType, viewOnClickIndex);
    }

    _sendBettingNumRequest(300, false, 0);
  }

  @override
  void cpNumChoiceState(int index, int viewOnClickIndex) {
    isClickType = false;

    List<int> cpNumList = groupCpNumList[viewOnClickIndex];
    //cpNumList[index] = cpNumList[index] == 0 ? -1 : 0;
    GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
    if (cpNumKey != null && cpNumKey.currentState != null) {
      if(currentPlayBeen.id == 690 || currentPlayBeen.id == 349 || currentPlayBeen.id == 679 ||
          currentPlayBeen.id == 834 || currentPlayBeen.id == 845 ) {
        // 包胆 只能选择一个
        cpNumKey.currentState.chooseCpNumViewListPlayBraveryRefresh(currentPlayBeen.id, cpNumList, isClickType, index);
      } else {
        cpNumKey.currentState.chooseCpNumViewListRefresh(cpNumList, isClickType, index);
      }

    }

    _sendBettingNumRequest(300, false, 0);
  }

  @override
  void cpTypeChoiceState(int index, int viewOnClickIndex) {
    isClickType = true;

    //刷新界面
    _typeIndexList[viewOnClickIndex] = index;

    GlobalKey<Choose11And5StateView> cpNumKey = listCpNumKey[viewOnClickIndex];
    if(cpNumKey != null) {
      cpNumKey.currentState.chooseCpNumViewListTypeIndexList(_typeIndexList[viewOnClickIndex], isClickType);
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
      var randomBase = LuckyAirshipPlayModelChoiceUtils.getInstance().getGamePlayModelSingleRandomBaseLength(currentPlayBeen);
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
   * LuckyAirshipPlayModelChoiceInterface 玩法类型 选择回调
   */
  ///
  @override
  void setLuckyAirshipPlayChoiceValue(bool isSingle, int cpChoiceNum,
      String cpChoiceTitle, bool isGroupSumNum, bool isDragonTiger,
      List<String> groupTitleList) {
    _isSingle = isSingle;
    _cpChoiceTitle = cpChoiceTitle;

    _choiceTypeGroupNum = cpChoiceNum;
    //_groupTitleList = groupTitleList;
    _groupTitleList.clear();
    groupTitleList.forEach((value){
      _groupTitleList.add(value);
    });
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

  /// 清空龙虎 状态
  @override
  void cleanDragonTigerStatus(bool result) {
    numAndOperationStateViewKey.currentState.cleanDragonTigerStatusText();
  }

  String drawTime = "";// 下期开奖时间

  void reGetCountdown() {
    if (_countdownTimer != null) {
      return;
    }
    //textKey.currentState.
    onBeginTimeOpenLottery(false);
    _countdownTimer =
    new Timer.periodic(new Duration(seconds: 1), (timer) {

      var formatLongToTimeStrToDay = DateUtils.formatLongToTimeStrToDay(drawTime);
      if (!TextUtil.isEmpty(formatLongToTimeStrToDay)) {
        if (formatLongToTimeStrToDay == ("00:00:00") || formatLongToTimeStrToDay == "0:0:0") {
          _countdownTimer.cancel();
          _countdownTimer = null;
          this.openLotteryTime = "";//00:00:00
          onBeginTimeOpenLotteryStatusChange(true, openLotteryDrawIssue);

          LuckyAirshipService.instance.luckyAirshipGetKjTime(this, colorVariety);
          Future.delayed(Duration(milliseconds: 10000)).then((e) {
            // 再次请求开奖时间
            LuckyAirshipService.instance.luckyAirshipKjLog(this, "1", "8", colorVariety);
          });

        } else {
          this.openLotteryTime = formatLongToTimeStrToDay;
          onSetRefreshState(openLotteryTime, openLotteryDrawIssue);
        }

      } else {
        LuckyAirshipService.instance.luckyAirshipGetKjTime(this, colorVariety);
        Future.delayed(Duration(milliseconds: 10000)).then((e) {
          // 再次请求开奖时间
          LuckyAirshipService.instance.luckyAirshipKjLog(this, "1", "8", colorVariety);
        });
      }


    });
  }

  /// 开奖时间
  @override
  void openVietnamHanoiLotteryTime(String time, String numberPeriods) {
    this.openLotteryDrawIssue = numberPeriods;
    this.drawTime = time;
    reGetCountdown();
  }

  /// 投注成功
  @override
  void bettingSuccessResult() {
    /// 清空界面
    showToast("投注成功");
    choiceCpNumList.clear();//清空这次选中的数字列表
    //投注成功 跳转投注记录界面
    //eventBus.fire(BettingResultTabBettingRecordBus());

    if (_isSingle) {
      //单式
      editContent11Choose5Handle("");
    } else {
      calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");
      numAndOperationStateViewKey.currentState.setCalculationBettingNumData(calculationBettingNumBeen);

      if (isCurrentOptionalCp) {
        //是任选
        for (int i = 0; i < listCpNumKey.length; i++) {
          GlobalKey<Choose11And5StateView> chooseCpNumKey = listCpNumKey[i];
          chooseCpNumKey.currentState.cleanChoiceState();

        }
      } else {

        if (_isDragonTiger) {
          // 龙虎和
          dragonTigerStateKey.currentState.cleanLuckyAirshipChoiceNum();

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
    openLotteryListBeen = dataListBeen;
    //textKey.currentState.openLotteryListBeen = dataListBeen;
    if (textKey.currentState != null) {
      textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
      lotteryNumListStateViewKey.currentState.onSetRefreshLotteryNumList(isLookLotteryList, openLotteryListBeen);
    }
  }


  /**
   * 幸运飞艇 大小  单双  龙虎
   */
  ///
  @override
  void setLuckyAirshipSecSumHandler(List<String> choiceCpNumList) {
    _sendBettingNumRequest(200, false, 0);
  }

}