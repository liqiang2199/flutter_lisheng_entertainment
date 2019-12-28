
import 'dart:async';
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/DateUtils.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshNoHeadController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/GameConstant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BettingNumAndOperationHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/BonusAdjustmentInterface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5EditContentHandle.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5Interface.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumAndOperationView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BettingNumSingleFormEditView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/BonusAdjustmentView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LotteryNumListView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/LotteryTimeNumView.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/CalculationBettingNumHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/GameGd11Choice5Service.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryDataInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';
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

class _BettingView extends BaseRefreshNoHeadController<BettingView> with AutomaticKeepAliveClientMixin implements Choose11And5Interface
,CalculationBettingNumHandler,Choose11And5EditContentHandle, BettingNumAndOperationHandler, BonusAdjustmentInterface,LotteryNum11Choice5Handler  {

  // 11 选 5 的好
  List<String> cpNumStr = ["01","02","03","04","05","06","07","08","09","10","11"];

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
  bool isLookLotteryTitle = true;//是否是下拉查看开奖号码 标题
  bool isLookLotteryList = false;//是否是下拉查看开奖号码

  String playRemark;//玩法说明

  int bettingMultipleNum = 1;//投注倍数
  int _segmentedIndex = 0;//元角分厘 下标
  double sliderValue = 1800.0;// 奖金调节 滑动距离
  String playMoneyAward;//玩法奖金
  double dx;
  double dy;
  double scrollY = 0.0;
  int randomNum = 3;//单式随机数量
  var drawTime = "2019-12-24 16:40:00";//开奖时间
  String openLotteryTime = "开奖中";//开奖时间显示
  String openLotteryDrawIssue = "000000";//开奖期数
  GlobalKey<LotteryTimeNumChildView> textKey = GlobalKey();

  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: false,
  );

  CalculationBettingNumDataBeen calculationBettingNumBeen = new CalculationBettingNumDataBeen(new List(),0,"0.00","0.00","0.00");//注数 和 金额

  /// 开奖列表
  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      //print("scrollController.offset = ${scrollController.offset}");
      scrollY = scrollController.offset;
    });

    GameService.instance.getApi("9",this);
    GameService.instance.kjlogList_Betting("9","5",this);

    /// 读取保存 的顶部内容
    List<Map<dynamic, dynamic>> playModel = SpUtil.getObjectList("PlayModeList");
    if(playModel != null && playModel.length != null && playModel.length > 0) {
      playModel.forEach((value) {
        print("string #### = $value");
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

    _choiceThreeTitleTip();
    _initGroupCpNum();
  }

  /// 如果没有数据时显示
  _initPlayModelChoiceOne(bool isChoice) {
    Play11Choice5DataPlayBeen play11choice5dataPlayBeen = new Play11Choice5DataPlayBeen(4, 9, 2, "三码直选复式", "0", "1", "2.00", "1.00"
        , "从01-11共11个号码中选择3个不重复的号码组成一注，所选号码与当期顺序摇出的5个号码中的前3个号码相同，且顺序一致，即为中奖。");

    play11choice5dataPlayBeen.isGroupSelection = false;
    play11choice5dataPlayBeen.isGroupSelection = false;
    play11choice5dataPlayBeen.playMode = 1;
    play11choice5dataPlayBeen.playModeTitle = "";
    play11choice5dataPlayBeen.playModeSingleOrDouble = 2;
    play11choice5dataPlayBeen.isChoiceType = true;
    play11choice5dataPlayBeen.groupSelectionNum = 3;
    playRemark = play11choice5dataPlayBeen.remark;
    playMoneyAward = play11choice5dataPlayBeen.money_award;

    playModeBeenList.add(play11choice5dataPlayBeen);

    if (isChoice) {

      //切换 单式 或者 复式
      _getPlayModeChoiceNumList(play11choice5dataPlayBeen);
      _initGroupCpNum();
    }

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

        if(pix <= -60) {
          if(!isLookLotteryList && isLookLotteryTitle && pix <= -60) {
            //打开开奖列表
            refreshController.refreshCompleted();
            isLookLotteryList = true;
            isLookLotteryTitle = false;
            setState(() {

            });
          }
        }

        if(isLookLotteryList && !isLookLotteryTitle && pix >= 100) {
          //关闭开奖列表
          isLookLotteryList = false;
          isLookLotteryTitle = true;
          setState(() {

          });
        }
        textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
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

  /// 407
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
                  playRemark = playModeBeenList[0].remark;
                  playModeBeenList[0].isChoiceType = true;
                  playMoneyAward = playModeBeenList[0].money_award;
                  _getPlayModeChoiceNumList(playModeBeenList[0]);
                  _initGroupCpNum();
                }

                setState(() {
                  //刷新列表

                });
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
                SpUtil.putObjectList("PlayModeList", playModeBeenList);

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
          randomNum = 3;
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
          randomNum = 2;
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
        randomNum = GameConstant().getGD11Choice5Single_Num(currentPlayType);
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
          playRemark = playBeen.remark;
          playMoneyAward = playBeen.money_award;
          _getPlayModeChoiceNumList(playBeen);
          _initGroupCpNum();
          setState(() {

          });
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
   * isRoll 是否需要滚动
   */
  _randomChoiceCpNum(bool isRoll) {

    if (isSinglePlay) {
      /// 单式玩法 随机
      editContent11Choose5Handle("");

      _randomIndexGetCpNum(randomNum);

    } else {

      _initGroupCpNum();
      setState(() {
        /// 滚动到对应位置
        scrollController.animateTo( 0.0 ,
            duration: Duration(milliseconds: 200),
            curve: Curves.ease
        );
      });
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


      print("ScreenUtil.getScreenH(context) - 60 - 100 = ${ScreenUtil.getScreenH(context) - 60 - 100}");
      print("(187 + ( 165 * groupCpNumList.length) + 60 ) = ${(187 + ( 185 * groupCpNumList.length) + 60 )}");

      Future.delayed(Duration(milliseconds: 500)).then((e) {
        setState(() {


          if (isRoll) {
            int indexCp = 1;
            groupCpNumList.forEach((cpNumList){
              List<int> numList = cpNumList;
              var randomNum = Random().nextInt(4)+1;

              for (var i = 0; i < randomNum; i++) {
                numList[Random().nextInt(11)] = 0;
              }

              /// 滚动到对应位置 187 头部   + 80 标题
              if (h < 0) {
                h = h * (-1);
              }
              scrollController.animateTo( h.toDouble() ,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.ease
              );

              indexCp ++;

            });
          }
        });
      });
      Future.delayed(Duration(milliseconds: 2000)).then((e) {
        setState(() {
          choiceNumAfter();
        });
      });

    }

  }

  int setLength = 0;
  int setLengthIndex = 0;
  var randomCpNum = new Set();
  _randomIndexSix(int len) {

    int index1 = Random().nextInt(11);

    setLength = randomCpNum.length;

    while(setLength <= setLengthIndex && setLengthIndex < len) {
      setLengthIndex ++;
      randomCpNum.add(index1);
      _randomIndexSix(len);
    }
  }

  /**
   * 随机 彩种号码
   */
  _randomIndexGetCpNum(int num) {
    int index1 = Random().nextInt(11);
    int index2 = Random().nextInt(11);
    int index3 = Random().nextInt(11);

    if (num == 1) {
      choiceCpNumList.clear();
      List<String> strRandomSingle = ["${cpNumStr[index1]},"];
      choiceCpNumList.add(strRandomSingle);
      editContent11Choose5Handle("${cpNumStr[index1]},");
    }

    if (num == 2) {
      while(index1 == index2) {
        _randomIndexGetCpNum(num);
        return;
      }
      choiceCpNumList.clear();
      List<String> strRandomSingle = ["${cpNumStr[index1]}${cpNumStr[index2]},"];
      choiceCpNumList.add(strRandomSingle);
      editContent11Choose5Handle("${cpNumStr[index1]}${cpNumStr[index2]},");
    }

    if (num == 3) {
      while(index1 == index2) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index3) {
        _randomIndexGetCpNum(num);
        return;
      }

      while(index3 == index1) {
        _randomIndexGetCpNum(num);
        return;
      }
      choiceCpNumList.clear();
      List<String> strRandomSingle = ["${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]},"];
      choiceCpNumList.add(strRandomSingle);
      editContent11Choose5Handle("${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]},");
    }
    int index4 = Random().nextInt(11);
    if (num == 4) {
      while(index1 == index2) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index1) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index1 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index3) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      choiceCpNumList.clear();
      List<String> strRandomSingle = ["${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]}${cpNumStr[index4]},"];
      choiceCpNumList.add(strRandomSingle);
      editContent11Choose5Handle("${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]}${cpNumStr[index4]},");
    }

    int index5 = Random().nextInt(11);
    if (num == 5) {
      while(index1 == index2) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index1) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index1 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index1 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index3) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index4 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      choiceCpNumList.clear();
      List<String> strRandomSingle = ["${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]}${cpNumStr[index4]}${cpNumStr[index5]},"];
      choiceCpNumList.add(strRandomSingle);
      editContent11Choose5Handle("${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]}${cpNumStr[index4]}${cpNumStr[index5]},");
    }

    int index6 = Random().nextInt(11);
    if (num == 6) {
      while(index1 == index2) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index1) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index1 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index1 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index1 == index6) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index3) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index2 == index6) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index4) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index3 == index6) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index4 == index5) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index4 == index6) {
        _randomIndexGetCpNum(num);
        return;
      }
      while(index5 == index6) {
        _randomIndexGetCpNum(num);
        return;
      }
      choiceCpNumList.clear();
      List<String> strRandomSingle = ["${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]}${cpNumStr[index4]}${cpNumStr[index5]}${cpNumStr[index6]},"];
      choiceCpNumList.add(strRandomSingle);
      editContent11Choose5Handle("${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]}${cpNumStr[index4]}${cpNumStr[index5]}${cpNumStr[index6]},");
    }

    /// 请求单式 随机玩法注数请求
    Future.delayed(Duration(milliseconds: 1000)).then((e) {
      setState(() {
        choiceNumAfter();
      });
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
        //三码/前三直选/复式（计算注数）
        if (choiceCpNumList.length >= 3) {
          GameGd11Choice5Service.instance.threeYardDirectlyElectedCompound(choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_1_4:
        //三码/前三直选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,this,"5", isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_1_6:
      // 三码/前三组合/复式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.threeYardCombinationCompound(choiceCpNumList[0]
              , this, isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_1_5:
        //三码/前三组合/单式 （计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,this,"6", isAddBetting, bettingMultiple);
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
      case GameConstant.gd11_5_1_4:
      //三码/前三直选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,this,"5", isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_2_36:
        //二码/前二组合/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,this,"40", isAddBetting, bettingMultiple);
        }
        break;
      case GameConstant.gd11_5_2_11:
      //二码/前二直选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          GameGd11Choice5Service.instance.commonOneListDataNum(choiceCpNumList[0]
              ,this,"12", isAddBetting, bettingMultiple);
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
    _randomChoiceCpNum(true);

  }

  @override
  void butShopCart() {
    /// 购物车
    Navigator.pushNamed(context, RouteUtil.gameShoppingCartController).then((value) {

    });
  }

  /**
   * 奖金调节
   */

  @override
  void bettingMultipleAddAndSub(bool isAdd, int num) {
    bettingMultipleNum = num;
    setState(() {

    });
  }

  @override
  void setSegmentedIndex(int index) {
    _segmentedIndex = index;
    setState(() {

    });
  }

  @override
  void sliderChangeNum(double sliderValue) {
    this.sliderValue = sliderValue;
    setState(() {

    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    scrollController.dispose();
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void setOpenLotteryListData(OpenLotteryListDataBeen data) {
    // 开奖记录列表
    var dataList = data.data;
    var dataListBeen = dataList.data;
    setState(() {
      this.openLotteryListBeen = dataListBeen;
      textKey.currentState.openLotteryListBeen = dataListBeen;
    });
    textKey.currentState.onSetRefreshLotteryState(isLookLotteryTitle, playRemark, openLotteryListBeen);
  }
  Timer _countdownTimer;
  @override
  void setOpenLotteryListInfoData(CpOpenLotteryDataInfoBeen data) {

    var lotteryInfoBeen = data.data;
    if (data != null) {
//        var drawTime = lotteryInfoBeen.drawTime;
      if (!TextUtil.isEmpty(drawTime)) {
        var formatLongToTimeStrToDay = DateUtils.formatLongToTimeStrToDay(drawTime);
        print("formatLongToTimeStrToDay = $formatLongToTimeStrToDay");
        this.openLotteryTime = formatLongToTimeStrToDay;
        this.openLotteryDrawIssue = "${lotteryInfoBeen.drawIssue}";
      }

    }
//    setState(() {
//
//    });
    textKey.currentState.onSetRefreshState(openLotteryTime, openLotteryDrawIssue);
    reGetCountdown();

//    var lotteryInfoDataBeen = data.data;
//
//    openLotteryListBeen.clear();
//    lotteryInfoDataBeen.forEach((lotteryDataBeen){
//
//      OpenLotteryListTwoDataListBeen twoDataListBeen = new OpenLotteryListTwoDataListBeen(
//          lotteryDataBeen.id,0,lotteryDataBeen.preDrawCode,lotteryDataBeen.preDrawCode
//        ,lotteryDataBeen.preDrawTime,lotteryDataBeen.preDrawCode,lotteryDataBeen.drawIssue);
//      twoDataListBeen.drawTime = lotteryDataBeen.drawTime;
//      twoDataListBeen.drawIssue = lotteryDataBeen.drawIssue;
//      openLotteryListBeen.add(twoDataListBeen);
//    });



  }

  void reGetCountdown() {
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
        this.openLotteryTime = "00:00:00";
        textKey.currentState.onBeginTimeOpenLottery(true);
      } else {
        this.openLotteryTime = formatLongToTimeStrToDay;
      }
      textKey.currentState.onSetRefreshState(openLotteryTime, openLotteryDrawIssue);
    });
  }


/// 测试向下拉动 回调
//  Widget _ges() {
//
//    return new Listener (
//      onPointerDown: (event) {
//        dx = event.localPosition.dx;
//        dy = event.localPosition.dy;
//        print("dy = $dy");
//      },
//      onPointerMove: (move){
//        print("move = ${move.localPosition.dy}");
////        scrollController
//
//        if (move.localPosition.dy - dy > 50 && scrollY == 0.0) {
////          setState(() {
////            scrollController.animateTo( -(move.localPosition.dy - dy) ,
////                duration: Duration(milliseconds: 100),
////                curve: Curves.ease
////            );
//            scrollController.jumpTo(-(move.localPosition.dy - dy));
////          });
//        }
//      },
//      onPointerUp: (event) {
////        if (event.localPosition.dy - dy < 0) {
////          setState(() {
////            scrollController.animateTo( 0.0 ,
////                duration: Duration(milliseconds: 200),
////                curve: Curves.ease
////            );
////          });
////        }
//
//      },
//      child: _listViewData(),
//    );
//  }

//  Widget _listSeparated() {
//
//    return ListView.separated(
//      controller: scrollController,
//      physics: new NeverScrollableScrollPhysics(),
//      itemCount: 1,
//      itemBuilder: (context, index) {
//        return _separatedWidget();
//      },
//      separatorBuilder: (context, index) {
//        return Divider(
//          height: .5,
//          indent: 75,
//          color: Color(0xFFDDDDDD),
//        );
//      },
//    );
//  }

//  Widget _listViewData() {
//
//    return new ListView(
//      controller: scrollController,
//      children: <Widget>[
//
//        _getRightArrowView("玩法选择", ImageUtil.imgLotteryCenterCqSSC, 1),
//        CommonView().commonLine_NoMargin(context),
//        _playType(),
//        CommonView().commonLine_NoMarginChange(context, 10.0),
//        LotteryTimeNumView(isOpenLotteryList: isLookLotteryTitle, playRemark: this.playRemark,),
//        CommonView().commonLine_NoMarginChange(context, 10.0),
//
//        new Column(
//          children: <Widget>[
//
//            LotteryNumListView(isLookLotteryList: isLookLotteryList,),
//
//            _numTypeChoiceView(),
//
//            BonusAdjustmentView(
//              adjustmentInterface: this,
//              multipleNum: bettingMultipleNum,
//              segmentedIndex: _segmentedIndex,
//              sliderValue: this.sliderValue,
//            ),
//
//          ],
//        ),
//
//
//      ],
//    );
//  }


}