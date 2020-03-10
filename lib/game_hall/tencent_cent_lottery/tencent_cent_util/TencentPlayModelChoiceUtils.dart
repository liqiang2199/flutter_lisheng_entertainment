
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/tencent_game/TencentCentService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/tencent_game/TencentCnetBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/vietnam_hanoi/VietnamHanoiService.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/Play11Choice5DataPlayBeen.dart';

import 'TencentPlayModelChoiceInterface.dart';

class TencentPlayModelChoiceUtils {

  bool isSingle = false;
  bool sumValue = false;
  bool isGroupSumNum = false;
  bool isDragonTiger = false;
  bool isContainsRepeat = false;
  bool isFiveStarsTotalNum = false;// 是否是五星中和
  int cpChoiceNum = 3;
  String cpChoiceTitle = "";
  List<String> _groupTitleList = new List();

  TencentPlayModelChoiceUtils._();

  static TencentPlayModelChoiceUtils _instance;

  static TencentPlayModelChoiceUtils getInstance() {
    if (_instance == null) {
      _instance = TencentPlayModelChoiceUtils._();
    }
    _instance.isSingle = false;
    _instance.sumValue = false;
    _instance.isGroupSumNum = false;
    _instance.isDragonTiger = false;
    _instance.isFiveStarsTotalNum = false;
    _instance.isContainsRepeat = false;
    _instance.cpChoiceNum = 3;
    _instance.cpChoiceTitle = "";
    _instance._groupTitleList.clear();
    return _instance;
  }

  getPlayModeChoiceNumList(Play11Choice5DataPlayBeen playBeen, TencentPlayModelChoiceInterface modelChoiceInterface) {

    switch(playBeen.playMode) {
      case 1:
        _fiveStarsPlayModel(playBeen);
        break;
      case 2:
        _lasterFourPlayModel(playBeen);
        break;
      case 3:
        _topThreeChoicePlayModel(playBeen);
        break;
      case 4:
        _middleThreeChoicePlayModel(playBeen);
        break;
      case 5:
        _laterThreeChoicePlayModel(playBeen);
        break;
      case 6:
        _topTwoChoicePlayModel(playBeen);
        break;
      case 7:
        _laterTwoChoicePlayModel(playBeen);
        break;
      case 8:
        _choiceFiveTitleTip();
        cpChoiceNum = 5;
        break;
      case 9:
        _uncertainGallbladderChoicePlayModel(playBeen);
        break;
      case 10:
        _optionalChoicePlayModel(playBeen);
        break;
      case 11:
        _interestChoicePlayModel(playBeen);
        break;
      case 12:
        isDragonTiger = true;
        break;
      case 13:
        isDragonTiger = true;
        break;
    }
    if (_groupTitleList.length <= 0) {
      choiceTopThreeTitleTip();
    }
    if (modelChoiceInterface != null) {
      modelChoiceInterface.setTencentPlayChoiceValue(isSingle, sumValue, cpChoiceNum, cpChoiceTitle,
          isGroupSumNum, isDragonTiger, isFiveStarsTotalNum, isContainsRepeat, _groupTitleList);
    }
  }

  /// 五星
  _fiveStarsPlayModel(Play11Choice5DataPlayBeen playBeen) {
    if (playBeen.id == 282 || playBeen.id == 615 || playBeen.id == 770) {
      // 五星/五星直选/复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }

    if (playBeen.id == 284 || playBeen.id == 616 || playBeen.id == 771) {
      // 五星/五星直选/单式
      isSingle = true;
      cpChoiceNum = 0;
    }

    if (playBeen.id == 286 || playBeen.id == 618 || playBeen.id == 773) {
      // 五星/五星组选/组选120
      cpChoiceNum = 1;
      cpChoiceTitle = "选号";
      _choiceOneTitleTip(cpChoiceTitle);
    }

    if (playBeen.id == 287 || playBeen.id == 288
        || playBeen.id == 619 || playBeen.id == 620
        || playBeen.id == 774 || playBeen.id == 775) {
      // 五星/五星组选/组选60 组选 30
      isContainsRepeat = true;
      cpChoiceNum = 2;
      _choiceFiveStars60TitleTip();
    }

    if (playBeen.id == 289 || playBeen.id == 621 || playBeen.id == 776) {
      // 组选 20
      isContainsRepeat = true;
      cpChoiceNum = 2;
      _choiceFiveStars20TitleTip();
    }

    if (playBeen.id == 290 || playBeen.id == 622 || playBeen.id == 777) {
      // 组选 10
      isContainsRepeat = true;
      cpChoiceNum = 2;
      _choiceFiveStars10TitleTip();
    }
    /// 和值大小单双
    if (playBeen.id == 293 || playBeen.id == 624 || playBeen.id == 779) {
      isFiveStarsTotalNum = true;
      cpChoiceNum = 1;
    }

  }

  /// 后四
  _lasterFourPlayModel(Play11Choice5DataPlayBeen playBeen) {
    if (playBeen.id == 297 || playBeen.id == 627 || playBeen.id == 782) {
      // 复式
      cpChoiceNum = 4;
      _choiceLaterFourTitleTip();
    }

    if (playBeen.id == 298 || playBeen.id == 628 || playBeen.id == 783) {
      // 单式
      isSingle = true;
      cpChoiceNum = 0;
    }

    if (playBeen.id == 300 || playBeen.id == 630 || playBeen.id == 785) {
      // 组24
      cpChoiceNum = 1;
      cpChoiceTitle = "选号";
      _choiceOneTitleTip(cpChoiceTitle);
    }

    if (playBeen.id == 301 || playBeen.id == 631 || playBeen.id == 786) {
      // 组12
      isContainsRepeat = true;
      cpChoiceNum = 2;
      _choiceFiveStars60TitleTip();
    }

    if (playBeen.id == 302 || playBeen.id == 632 || playBeen.id == 787) {
      // 组6
      cpChoiceNum = 1;
      cpChoiceTitle = "二重号";
      _choiceOneTitleTip(cpChoiceTitle);
    }

    if (playBeen.id == 303 || playBeen.id == 633 || playBeen.id == 788) {
      // 组4
      isContainsRepeat = true;
      cpChoiceNum = 2;
      _choiceFiveStars20TitleTip();
    }

  }

  /// 前三 直选
  _topThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    //前三 直选
    if (playBeen.id == 308 || playBeen.id == 636 || playBeen.id == 791) {
      //复式
      cpChoiceNum = 3;
      choiceTopThreeTitleTip();
    }
    if (playBeen.id == 309 || playBeen.id == 637 || playBeen.id == 792) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 310 || playBeen.id == 638 || playBeen.id == 793) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 311 || playBeen.id == 639 || playBeen.id == 794) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 312 || playBeen.id == 641 || playBeen.id == 796) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 313 || playBeen.id == 642 || playBeen.id == 797) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 314 || playBeen.id == 643 || playBeen.id == 798) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 315 || playBeen.id == 645 || playBeen.id == 800) {
      //和值 尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 中三
  _middleThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 320 || playBeen.id == 648 || playBeen.id == 803) {
      //复式
      cpChoiceNum = 3;
      _choiceMiddleThreeTitleTip();
    }
    if (playBeen.id == 321 || playBeen.id == 649 || playBeen.id == 804) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 322 || playBeen.id == 650 || playBeen.id == 805) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 323 || playBeen.id == 651 || playBeen.id == 806) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 324 || playBeen.id == 653 || playBeen.id == 808) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 325 || playBeen.id == 654 || playBeen.id == 809) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 326 || playBeen.id == 656 || playBeen.id == 811) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后三
  _laterThreeChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 331 || playBeen.id == 659 || playBeen.id == 814) {
      //复式
      cpChoiceNum = 3;
      _choiceLaterThreeTitleTip();
    }
    if (playBeen.id == 332 || playBeen.id == 660 || playBeen.id == 815) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 333 || playBeen.id == 661 || playBeen.id == 816) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 334 || playBeen.id == 662 || playBeen.id == 817) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 335 || playBeen.id == 664 || playBeen.id == 819) {
      //组选 组三
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 336 || playBeen.id == 665 || playBeen.id == 820) {
      //组选 组六
      cpChoiceNum = 1;
      cpChoiceTitle = "组六";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 337 || playBeen.id == 666 || playBeen.id == 821) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 338 || playBeen.id == 668 || playBeen.id == 823) {
      //组选 和值尾数
      cpChoiceNum = 1;
      cpChoiceTitle = "和值尾数";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 前二
  _topTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 342 || playBeen.id == 671 || playBeen.id == 826) {
      //复式
      cpChoiceNum = 2;
      _choiceTopTwoTitleTip();
    }
    if (playBeen.id == 343 || playBeen.id == 672 || playBeen.id == 827) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 344 || playBeen.id == 673 || playBeen.id == 828) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
//    if (playBeen.id == 345) {
//      //大小单双
//      isSingle = false;
//      sumValue = true;
//      cpChoiceNum = 1;
//      cpChoiceTitle = "直选和值";
//      _choiceOneTitleTip(cpChoiceTitle);
//    }
    if (playBeen.id == 345 || playBeen.id == 674 || playBeen.id == 829) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 346 || playBeen.id == 676 || playBeen.id == 831) {
      //组选 复式
      cpChoiceNum = 1;
      cpChoiceTitle = "组三";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 347 || playBeen.id == 677 || playBeen.id == 832) {
      //组选 单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 349 || playBeen.id == 679 || playBeen.id == 834) {
      //组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 348 || playBeen.id == 678 || playBeen.id == 833) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 后二
  _laterTwoChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    if (playBeen.id == 353 || playBeen.id == 682 || playBeen.id == 837) {
      //复式
      cpChoiceNum = 2;
      _choiceLaterTwoTitleTip();
    }
    if (playBeen.id == 354 || playBeen.id == 683 || playBeen.id == 838) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 355 || playBeen.id == 684 || playBeen.id == 839) {
      //和值
      isSingle = false;
      sumValue = true;
      cpChoiceNum = 1;
      cpChoiceTitle = "直选和值";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 356 || playBeen.id == 685 || playBeen.id == 840) {
      //跨度
      cpChoiceNum = 1;
      cpChoiceTitle = "直选跨度";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 357 || playBeen.id == 687 || playBeen.id == 842) {
      //组选 复式
      cpChoiceNum = 1;
      cpChoiceTitle = "组选";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 358 || playBeen.id == 688 || playBeen.id == 843) {
      //组选 单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 689 || playBeen.id == 844) {
      //组选和值
      cpChoiceNum = 1;
      cpChoiceTitle = "组选和值";
      isGroupSumNum = true;//组选和值
      sumValue = true;
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 690 || playBeen.id == 845) {
      //组选 组选包胆
      cpChoiceNum = 1;
      cpChoiceTitle = "组选包胆";
      _choiceOneTitleTip(cpChoiceTitle);
    }
  }

  /// 不定胆
  _uncertainGallbladderChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {

    cpChoiceNum = 1;
    cpChoiceTitle = "不定胆";
    _choiceOneTitleTip(cpChoiceTitle);
  }

  /// 任选
  _optionalChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    // 任二
    if (playBeen.id == 382 || playBeen.id == 712 || playBeen.id == 867) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 383 || playBeen.id == 713 || playBeen.id == 868) {
      //单式
      isSingle = true;
      cpChoiceNum = 0;
    }
    if (playBeen.id == 384 || playBeen.id == 714 || playBeen.id == 869) {
      //组选
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
   //任三
    if (playBeen.id == 385 || playBeen.id == 716 || playBeen.id == 871) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 386 || playBeen.id == 717 || playBeen.id == 872) {
      //单式
      cpChoiceNum = 0;
      isSingle = true;
    }
    if (playBeen.id == 387 || playBeen.id == 718 || playBeen.id == 873) {
      //组三
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    if (playBeen.id == 388 || playBeen.id == 719 || playBeen.id == 874) {
      //组六
      cpChoiceNum = 1;
      cpChoiceTitle = "号码";
      _choiceOneTitleTip(cpChoiceTitle);
    }
    //任四
    if (playBeen.id == 389) {
      //复式
      cpChoiceNum = 5;
      _choiceFiveTitleTip();
    }
    if (playBeen.id == 390) {
      //单式
      cpChoiceNum = 0;
      isSingle = true;
    }
  }

  /// 趣味
  _interestChoicePlayModel(Play11Choice5DataPlayBeen playBeen) {
    cpChoiceNum = 1;
    cpChoiceTitle = "号码";
    _choiceOneTitleTip(cpChoiceTitle);
  }

  /// 五位选号 文本提示 (默认)
  _choiceFiveTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
    _groupTitleList.add("百");
    _groupTitleList.add("十");
    _groupTitleList.add("个");
  }

  /// 五星 60 和 30
  _choiceFiveStars60TitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("二重号");
    _groupTitleList.add("单号");
  }
  /// 五星 20
  _choiceFiveStars20TitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("三重号");
    _groupTitleList.add("单号");
  }

  /// 五星 10
  _choiceFiveStars10TitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("三重号");
    _groupTitleList.add("二重号");
  }

  /// 后四位选号 文本提示 (默认) 位
  _choiceLaterFourTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
    _groupTitleList.add("百");
    _groupTitleList.add("十");
  }

  /// 后三位选号 文本提示 (默认) 位
  _choiceLaterThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
    _groupTitleList.add("百");
  }

  /// 中三位
  _choiceMiddleThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("千");
    _groupTitleList.add("百");
    _groupTitleList.add("十");
  }

  /// 前三位
  choiceTopThreeTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
    _groupTitleList.add("百");
  }

  /// 前二位选号 文本提示
  _choiceTopTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("万");
    _groupTitleList.add("千");
  }

  /// 后二
  _choiceLaterTwoTitleTip() {
    _groupTitleList.clear();
    _groupTitleList.add("十");
    _groupTitleList.add("个");
  }

  /// 只有一位选号
  _choiceOneTitleTip(String title) {
    _groupTitleList.clear();
    _groupTitleList.add(title);
  }




  /// 玩法类型随机基数 (复式 可以选号)
  int getGamePlayModelRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 286://五星 组选 120

      case 618://五星 组选 120 5分彩
      case 773://五星 组选 120 10分彩
        basNum = 5;
        break;
      case 300://后四 组选 24
      case 630://后四 组选 24 5分彩
      case 785://后四 组选 24 10分彩
        basNum = 4;
        break;
      case 287://五星 组选 60
      case 619://五星 组选 60 5分彩
      case 774://五星 组选 60 10分彩

      case 369://五星不定胆 三码
      case 697://五星不定胆 三码 5分彩
      case 852://五星不定胆 三码 10分彩
        basNum = 3;
        break;
      case 289://五星 组选 20
      case 621://五星 组选 20// 5分彩
      case 776://五星 组选 20// 10分彩

      case 301://后四 组选 6
      case 632://后四 组选 6 5分彩
      case 787://后四 组选 6 10分彩

      case 368://不定胆 二码
      case 371://前四不定胆 二码
      case 373://后四不定胆 二码
      case 376://三星不定胆 二码 前三
      case 377://三星不定胆 二码 后三
        //5分彩
      case 696://五星不定胆 二码
      case 700://前四不定胆 二码
      case 703://后四不定胆 二码
      case 709://三星不定胆 二码 前三
      case 708://三星不定胆 二码 后三
      //10分彩
      case 851://五星不定胆 二码
      case 855://前四不定胆 二码
      case 858://后四不定胆 二码
      case 863://三星不定胆 二码 前三
      case 864://三星不定胆 二码 后三
        basNum = 2;
        break;
      case 288://五星 组选 30
      case 290://五星 组选 10
        //5分彩
      case 620://五星 组选 30
      case 622://五星 组选 10
      //10分彩
      case 775://五星 组选 30
      case 777://五星 组选 10

      case 303://后四 组选 4
      case 633://后四 组选 4 5分彩
      case 788://后四 组选 4 10分彩
        basNum = 1;
        break;
    }
    return basNum;

  }

  /// 玩法类型随机基数 (单式 可输入号码)
  int getGamePlayModelSingleRandomBase(Play11Choice5DataPlayBeen playBeen) {
    int basNum = 1;
    switch(playBeen.id) {
      case 284:

      case 616://五星直选单式 5分彩
      case 771://五星直选单式 10分彩
        basNum = 5;
        break;
      case 297:// 后四 直选单式
      case 628:// 后四 直选单式 5分彩
        basNum = 4;
        break;
      case 309:// 前三 直选单式
      case 320:// 中三 直选单式
      case 332:// 后三 直选单式
      case 386:// 任选 三 单式
        //5分彩
      case 637:// 前三 直选单式
      case 649:// 中三 直选单式
      case 660:// 后三 直选单式
      case 717:// 任选 三 单式
      //10分彩
      case 792:// 前三 直选单式
      case 804:// 中三 直选单式
      case 815:// 后三 直选单式
      case 872:// 任选 三 单式
        basNum = 3;
        break;
      case 343:// 前二 直选单式
      case 347:// 前二 组选单式
      case 354:// 后二 直选单式
      case 358:// 后二 组选单式
      case 383:// 任选 二 单式
        //5分彩
      case 672:// 前二 直选单式
      case 677:// 前二 组选单式
      case 683:// 后二 直选单式
      case 688:// 后二 组选单式
      case 713:// 任选 二 单式
      //10分彩
      case 827:// 前二 直选单式
      case 832:// 前二 组选单式
      case 838:// 后二 直选单式
      case 843:// 后二 组选单式
      case 868:// 任选 二 单式
        basNum = 2;
        break;
    }
    return basNum;

  }

  /**
   * playBeen 获取是哪种 玩法
   * choiceCpNumList 获取选中的彩票
   * hanoiBettingHandler 通知界面
   */
  /// 请求投注数量
  getGameHttpBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, TencentCnetBettingHandler hanoiBettingHandler, bool isBetting, int multiple, String colorVarietyID) {

    if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
      postTencentOneGameBettingNum(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
      postTencentFiveGameBettingNum(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_10_TENCENT}") {
      postTencent10GameBettingNum(context, playBeen, choiceCpNumList, groupBitsList
          , hanoiBettingHandler, isBetting, multiple, colorVarietyID);
    }

  }

  /// 腾讯一分彩
  postTencentOneGameBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, TencentCnetBettingHandler hanoiBettingHandler, bool isBetting,
      int multiple, String colorVarietyID) {
    switch(playBeen.id) {
      case 308://前三/前三直选/复式（计算注数）
      case 320://中三/中三直选/复式（计算注数）
      case 331://后三/后三直选/复式（计算注数）
        if (choiceCpNumList.length >= 3) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 298://后四/后四直选/单式（计算注数）
      case 309://前三/前三直选/单式（计算注数）
      case 321://中三/中三直选/单式（计算注数）
      case 332://后三/后三直选/单式（计算注数）
      case 343://前二/直选/单试（计算注数）
      case 347://前二/组选/单式（计算注数）
      case 354://后二/直选/单式（计算注数）
      case 358://后二/组选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 286://五星/五星组选/组选120（计算注数）

      case 300://后四/后四组选/组选24（计算注数）
      case 302://后四/组选/6（计算注数）

      case 310://前三/前三组选/组选和值（计算注数）
      case 311://前三/前三组选/直选跨度（计算注数）
      case 312://前三/前三组选/组三（计算注数）
      case 313://前三/前三组选/组六（计算注数）
      case 314://前三/前三组选/和值（计算注数）
      case 315://前三/前三其他 /和值尾数（计算注数）

      case 323://中三/中三直选/直选跨度（计算注数）
      case 322://中三/中三直选/直选和值（计算注数）
      case 324://中三/中三组选/组三（计算注数）
      case 325://中三/中三组选/组六（计算注数）
      case 326://中三/中三组选/和值尾数（计算注数）

      case 333://后三/后三直选/直选和值（计算注数）
      case 334://后三/后三直选/直选跨度（计算注数）
      case 335://后三/后三直选/组三（计算注数）
      case 336://后三/后三直选/组六（计算注数）
      case 337://后三/后三组选/组选和值（计算注数）

      case 344://前二/直选/直选和值（计算注数）
      case 345://前二/直选/跨度（计算注数）
      case 346://前二/组选/复式（计算注数）
      case 348://前二/组选/和值（计算注数）
      case 349://前二/组选/包胆（计算注数）

      case 355://后二/直选/直选和值（计算注数）
      case 356://后二/直选/跨度（计算注数）
      case 357://后二/组选/复式（计算注数）
      case 477://后二/组选/和值（计算注数）
      case 478://后二/组选/包胆（计算注数）

      case 393://趣味/特殊/一帆风顺（计算注数）
      case 394://趣味/特殊/好事成双（计算注数）
      case 395://趣味/特殊/三星报喜（计算注数）
      case 396://趣味/特殊/四季发财（计算注数）

      case 368://不定胆/五星不定胆/二码不定位（计算注数）
      case 369://不定胆/五星不定胆/三码不定位（计算注数）
      case 370://不定胆/前四不定胆 /一码不定位（计算注数）
      case 371://不定胆/前四不定胆 /一码不定位（计算注数）
      case 372://不定胆/后四不定胆 /二码不定位（计算注数）
      case 373://不定胆/后四不定胆 /二码不定位（计算注数）
      case 374://不定胆/三星不定胆一码/后三（计算注数）
      case 375://不定胆/三星不定胆一码/前三（计算注数）
      case 376://不定胆/三星不定胆二码/前三（计算注数）
      case 377://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 342://前二/直选/复试（计算注数）
      case 353://后二/直选/复试（计算注数）

        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}"
              , true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 382://任选/任二/复式（计算注数）
      case 385://任选/任三/复式（计算注数）
      case 361://定位胆/定位胆/定位胆（计算注数）
      case 282://五星/五星直选/复式（计算注数）
        if (choiceCpNumList.length >= 5) {
          TencentCentService.instance.tencentFiveGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3]
              , choiceCpNumList[4],"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 383://任选/任二/单式（计算注数）
      case 386://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 384://任选/任二/组选（计算注数）
      case 387://任选/任三/组三（计算注数）
      case 388://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 297://后四/后四直选/复式（计算注数）
        if (choiceCpNumList.length >= 4) {
          TencentCentService.instance.tencentFourGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }
        break;
      case 287://五星/组选/60（计算注数）//重号
      case 288://五星/组选/30（计算注数）
      case 289://五星/组选/20（计算注数）
      case 290://五星/组选/10（计算注数）

      case 301://后四/组选/12（计算注数）//重号
//      case 302://后四/组选/6（计算注数）
      case 303://后四/组选/4（计算注数）
        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentDuplicateNumberGroupChoiceGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }
        break;
    }
  }

  /// 腾讯5分彩
  postTencentFiveGameBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, TencentCnetBettingHandler hanoiBettingHandler, bool isBetting,
      int multiple, String colorVarietyID) {
    switch(playBeen.id) {
      case 636://前三/前三直选/复式（计算注数）
      case 648://中三/中三直选/复式（计算注数）
      case 659://后三/后三直选/复式（计算注数）
        if (choiceCpNumList.length >= 3) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 616://五星/直选/单式（计算注数）
      case 628://后四/后四直选/单式（计算注数）
      case 637://前三/前三直选/单式（计算注数）
      case 649://中三/中三直选/单式（计算注数）
      case 660://后三/后三直选/单式（计算注数）
      case 672://前二/直选/单试（计算注数）
      case 677://前二/组选/单式（计算注数）
      case 683://后二/直选/单式（计算注数）
      case 688://后二/组选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 618://五星/五星组选/组选120（计算注数）

      case 630://后四/后四组选/组选24（计算注数）
      case 632://后四/组选/6（计算注数）

      case 638://前三/前三直选/组选和值（计算注数）
      case 639://前三/前三直选/直选跨度（计算注数）
      case 641://前三/前三组选/组三（计算注数）
      case 642://前三/前三组选/组六（计算注数）
      case 643://前三/前三组选/和值（计算注数）
      case 645://前三/前三其他 /和值尾数（计算注数）

      case 650://中三/中三直选/直选跨度（计算注数）
      case 651://中三/中三直选/直选和值（计算注数）
      case 653://中三/中三组选/组三（计算注数）
      case 654://中三/中三组选/组六（计算注数）
      case 656://中三/中三组选/和值尾数（计算注数）

      case 661://后三/后三直选/直选和值（计算注数）
      case 662://后三/后三直选/直选跨度（计算注数）
      case 664://后三/后三直选/组三（计算注数）
      case 665://后三/后三直选/组六（计算注数）
      case 666://后三/后三组选/组选和值（计算注数）
      case 668://后三/后三其他/和值尾数（计算注数）

      case 673://前二/直选/直选和值（计算注数）
      case 674://前二/直选/跨度（计算注数）
      case 676://前二/组选/复式（计算注数）
      case 678://前二/组选/和值（计算注数）
      case 679://前二/组选/包胆（计算注数）

      case 684://后二/直选/直选和值（计算注数）
      case 685://后二/直选/跨度（计算注数）
      case 687://后二/组选/复式（计算注数）
      case 689://后二/组选/和值（计算注数）
      case 690://后二/组选/包胆（计算注数）

      case 722://趣味/特殊/一帆风顺（计算注数）
      case 723://趣味/特殊/好事成双（计算注数）
      case 724://趣味/特殊/三星报喜（计算注数）
      case 725://趣味/特殊/四季发财（计算注数）

      case 696://不定胆/五星不定胆/二码不定位（计算注数）
      case 697://不定胆/五星不定胆/三码不定位（计算注数）
      case 699://不定胆/前四不定胆 /一码不定位（计算注数）
      case 700://不定胆/前四不定胆 /2码不定位（计算注数）
      case 702://不定胆/后四不定胆 /1码不定位（计算注数）
      case 703://不定胆/后四不定胆 /二码不定位（计算注数）
      case 705://不定胆/三星不定胆一码/后三（计算注数）
      case 706://不定胆/三星不定胆一码/前三（计算注数）
      case 709://不定胆/三星不定胆二码/前三（计算注数）
      case 708://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 671://前二/直选/复试（计算注数）
      case 682://后二/直选/复试（计算注数）

        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 712://任选/任二/复式（计算注数）
      case 716://任选/任三/复式（计算注数）
      case 693://定位胆/定位胆/定位胆（计算注数）
      case 615://五星/五星直选/复式（计算注数）
        if (choiceCpNumList.length >= 5) {
          TencentCentService.instance.tencentFiveGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 713://任选/任二/单式（计算注数）
      case 717://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 714://任选/任二/组选（计算注数）
      case 718://任选/任三/组三（计算注数）
      case 719://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 627://后四/后四直选/复式（计算注数）
        if (choiceCpNumList.length >= 4) {
          TencentCentService.instance.tencentFourGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3],"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }
        break;
      case 619://五星/组选/60（计算注数）//重号
      case 620://五星/组选/30（计算注数）
      case 621://五星/组选/20（计算注数）
      case 622://五星/组选/10（计算注数）

      case 631://后四/组选/12（计算注数）//重号
//      case 302://后四/组选/6（计算注数）
      case 633://后四/组选/4（计算注数）
        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentDuplicateNumberGroupChoiceGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }
        break;
    }
  }

  /// 腾讯10分彩
  postTencent10GameBettingNum(BuildContext context,Play11Choice5DataPlayBeen playBeen, List<List<String>> choiceCpNumList
      , List<String> groupBitsList, TencentCnetBettingHandler hanoiBettingHandler, bool isBetting,
      int multiple, String colorVarietyID) {
    switch(playBeen.id) {
      case 791://前三/前三直选/复式（计算注数）
      case 803://中三/中三直选/复式（计算注数）
      case 814://后三/后三直选/复式（计算注数）
        if (choiceCpNumList.length >= 3) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2],"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 771://五星/直选/单式（计算注数）
      case 783://后四/后四直选/单式（计算注数）
      case 792://前三/前三直选/单式（计算注数）
      case 804://中三/中三直选/单式（计算注数）
      case 815://后三/后三直选/单式（计算注数）
      case 827://前二/直选/单试（计算注数）
      case 832://前二/组选/单式（计算注数）
      case 838://后二/直选/单式（计算注数）
      case 843://后二/组选/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsEditSingle(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 773://五星/五星组选/组选120（计算注数）

      case 785://后四/后四组选/组选24（计算注数）
      case 787://后四/组选/6（计算注数）

      case 793://前三/前三直选/组选和值（计算注数）
      case 794://前三/前三直选/直选跨度（计算注数）
      case 796://前三/前三组选/组三（计算注数）
      case 797://前三/前三组选/组六（计算注数）
      case 798://前三/前三组选/和值（计算注数）
      case 800://前三/前三其他 /和值尾数（计算注数）

      case 805://中三/中三直选/直选跨度（计算注数）
      case 806://中三/中三直选/直选和值（计算注数）
      case 808://中三/中三组选/组三（计算注数）
      case 809://中三/中三组选/组六（计算注数）
      case 811://中三/中三组选/和值尾数（计算注数）

      case 816://后三/后三直选/直选和值（计算注数）
      case 817://后三/后三直选/直选跨度（计算注数）
      case 819://后三/后三直选/组三（计算注数）
      case 820://后三/后三直选/组六（计算注数）
      case 821://后三/后三组选/组选和值（计算注数）
      case 822://后三/后三其他/和值尾数（计算注数）

      case 828://前二/直选/直选和值（计算注数）
      case 829://前二/直选/跨度（计算注数）
      case 831://前二/组选/复式（计算注数）
      case 833://前二/组选/和值（计算注数）
      case 834://前二/组选/包胆（计算注数）

      case 839://后二/直选/直选和值（计算注数）
      case 840://后二/直选/跨度（计算注数）
      case 842://后二/组选/复式（计算注数）
      case 844://后二/组选/和值（计算注数）
      case 845://后二/组选/包胆（计算注数）

      case 877://趣味/特殊/一帆风顺（计算注数）
      case 878://趣味/特殊/好事成双（计算注数）
      case 879://趣味/特殊/三星报喜（计算注数）
      case 880://趣味/特殊/四季发财（计算注数）

      case 851://不定胆/五星不定胆/二码不定位（计算注数）
      case 852://不定胆/五星不定胆/三码不定位（计算注数）
      case 854://不定胆/前四不定胆 /一码不定位（计算注数）
      case 855://不定胆/前四不定胆 /2码不定位（计算注数）
      case 857://不定胆/后四不定胆 /1码不定位（计算注数）
      case 858://不定胆/后四不定胆 /二码不定位（计算注数）
      case 860://不定胆/三星不定胆一码/后三（计算注数）
      case 861://不定胆/三星不定胆一码/前三（计算注数）
      case 863://不定胆/三星不定胆二码/前三（计算注数）
      case 864://不定胆/三星不定胆二码/后三（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsSpan(context,hanoiBettingHandler, choiceCpNumList[0]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 826://前二/直选/复试（计算注数）
      case 837://后二/直选/复试（计算注数）

        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentThreeGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[0],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 867://任选/任二/复式（计算注数）
      case 871://任选/任三/复式（计算注数）
      case 848://定位胆/定位胆/定位胆（计算注数）
      case 770://五星/五星直选/复式（计算注数）
        if (choiceCpNumList.length >= 5) {
          TencentCentService.instance.tencentFiveGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3], choiceCpNumList[4]
              ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }

        break;
      case 868://任选/任二/单式（计算注数）
      case 872://任选/任三/单式（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }

        break;
      case 869://任选/任二/组选（计算注数）
      case 873://任选/任三/组三（计算注数）
      case 874://任选/任三/组六（计算注数）
        if (choiceCpNumList.length >= 1) {
          TencentCentService.instance.tencentGetGDBetsOptionalGroup(context,hanoiBettingHandler, choiceCpNumList[0]
              , groupBitsList,"${ playBeen.id}", false, isBetting, multiple, colorVarietyID);
        }

        break;
      case 782://后四/后四直选/复式（计算注数）
        if (choiceCpNumList.length >= 4) {
          TencentCentService.instance.tencentFourGetGDBetsOptional(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1], choiceCpNumList[2], choiceCpNumList[3],"${ playBeen.id}", isBetting, multiple, colorVarietyID);
        }
        break;
      case 774://五星/组选/60（计算注数）//重号
      case 775://五星/组选/30（计算注数）
      case 776://五星/组选/20（计算注数）
      case 777://五星/组选/10（计算注数）

      case 786://后四/组选/12（计算注数）//重号
      case 788://后四/组选/4（计算注数）
        if (choiceCpNumList.length >= 2) {
          TencentCentService.instance.tencentDuplicateNumberGroupChoiceGdBets(context,hanoiBettingHandler, choiceCpNumList[0]
              , choiceCpNumList[1],"${ playBeen.id}", true, isBetting, multiple, colorVarietyID);
        }
        break;
    }
  }

  /// 请求大小单双
  postSizeSingleAndDouble(BuildContext context, Play11Choice5DataPlayBeen playBeen
      , List<String> sizeSingleDoubleList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {


    if (sizeSingleDoubleList.length >= 1) {
      //(1=总和大，2=总和小，3=总和单，4=总和双)
      List<String> sizeSingleAndDoubleList = new List();


      sizeSingleDoubleList.forEach((value) {
        if (value == "大") {
          sizeSingleAndDoubleList.add("1");
        }
        if (value == "小") {
          sizeSingleAndDoubleList.add("2");
        }
        if (value == "单") {
          sizeSingleAndDoubleList.add("3");
        }
        if (value == "双") {
          sizeSingleAndDoubleList.add("4");
        }
      });
      TencentCentService.instance.tencentGetGDBetsSpan(context,hanoiBettingHandler, sizeSingleAndDoubleList
          ,"${ playBeen.id}", isBetting, multiple, colorVarietyID);
    }
  }

  /// 新龙虎
  getGameHttpBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {
    if (!isBetting) {
      hanoiBettingHandler.cleanDragonTigerStatus(true);
    }
    if (dragonTigerList.length <= 0) {
      hanoiBettingHandler.showToast("你还没有选择号码或所选号码不全");
      return;
    }

    if (colorVarietyID == "${Constant.GAME_NUM_TENCENT}") {
      getGameOneBettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

    if (colorVarietyID == "${Constant.GAME_NUM_5_TENCENT}") {
      getGameFiveBettingNumDragonTiger(context, playBeen, dragonTigerList, hanoiBettingHandler
          , isBetting, multiple, colorVarietyID);
    }

  }

  /// 腾讯一分彩
  getGameOneBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    var playIdIndex = 0;
    switch(playBeen.id) {
      case 437:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 447;

                break;
              case "虎":
                playIdIndex = 448;
                break;
              case "和":
                playIdIndex = 449;
                break;
            }
            TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 438:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 450;
              break;
            case "虎":
              playIdIndex = 451;
              break;
            case "和":
              playIdIndex = 452;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 439:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 453;
              break;
            case "虎":
              playIdIndex = 454;
              break;
            case "和":
              playIdIndex = 455;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 440:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 456;
              break;
            case "虎":
              playIdIndex = 457;
              break;
            case "和":
              playIdIndex = 458;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 441:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 459;
              break;
            case "虎":
              playIdIndex = 460;
              break;
            case "和":
              playIdIndex = 461;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 442:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 462;
              break;
            case "虎":
              playIdIndex = 463;
              break;
            case "和":
              playIdIndex = 464;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 443:// 新龙虎/新龙虎/2v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 465;
              break;
            case "虎":
              playIdIndex = 466;
              break;
            case "和":
              playIdIndex = 467;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 444:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 468;
              break;
            case "虎":
              playIdIndex = 469;
              break;
            case "和":
              playIdIndex = 470;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 445:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 471;
              break;
            case "虎":
              playIdIndex = 472;
              break;
            case "和":
              playIdIndex = 473;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 446:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 474;
              break;
            case "虎":
              playIdIndex = 475;
              break;
            case "和":
              playIdIndex = 476;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

  /// 腾讯5分彩
  getGameFiveBettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    var playIdIndex = 0;
    switch(playBeen.id) {
      case 728:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 729;

                break;
              case "虎":
                playIdIndex = 730;
                break;
              case "和":
                playIdIndex = 731;
                break;
            }
            TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 732:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 733;
              break;
            case "虎":
              playIdIndex = 734;
              break;
            case "和":
              playIdIndex = 735;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 736:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 737;
              break;
            case "虎":
              playIdIndex = 738;
              break;
            case "和":
              playIdIndex = 739;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 740:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 741;
              break;
            case "虎":
              playIdIndex = 742;
              break;
            case "和":
              playIdIndex = 743;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 744:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 745;
              break;
            case "虎":
              playIdIndex = 746;
              break;
            case "和":
              playIdIndex = 747;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 748:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 749;
              break;
            case "虎":
              playIdIndex = 750;
              break;
            case "和":
              playIdIndex = 751;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 752:// 新龙虎/新龙虎/2v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 753;
              break;
            case "虎":
              playIdIndex = 754;
              break;
            case "和":
              playIdIndex = 755;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 756:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 757;
              break;
            case "虎":
              playIdIndex = 758;
              break;
            case "和":
              playIdIndex = 759;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 760:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 761;
              break;
            case "虎":
              playIdIndex = 762;
              break;
            case "和":
              playIdIndex = 763;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 764:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 765;
              break;
            case "虎":
              playIdIndex = 766;
              break;
            case "和":
              playIdIndex = 767;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

  /// 腾讯10分彩
  getGame10BettingNumDragonTiger(BuildContext context,Play11Choice5DataPlayBeen playBeen
      , List<String> dragonTigerList, TencentCnetBettingHandler hanoiBettingHandler
      , bool isBetting, int multiple, String colorVarietyID) {

    var playIdIndex = 0;
    switch(playBeen.id) {
      case 883:// 新龙虎/新龙虎/1v2/和（计算注数）
        if (dragonTigerList.length > 0) {

          for (int i = 0; i < dragonTigerList.length; i++) {
            var dragonTigerStr = dragonTigerList[i];
            switch(dragonTigerStr) {
              case "龙":
                playIdIndex = 884;

                break;
              case "虎":
                playIdIndex = 885;
                break;
              case "和":
                playIdIndex = 886;
                break;
            }
            TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
                dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
          }


        }

        break;

      case 887:// 新龙虎/新龙虎/1v3/虎（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 888;
              break;
            case "虎":
              playIdIndex = 889;
              break;
            case "和":
              playIdIndex = 890;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

      case 891:// 新龙虎/新龙虎/1v4/和（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 892;
              break;
            case "虎":
              playIdIndex = 893;
              break;
            case "和":
              playIdIndex = 894;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 895:// 新龙虎/新龙虎/1v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 896;
              break;
            case "虎":
              playIdIndex = 897;
              break;
            case "和":
              playIdIndex = 898;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 899:// 新龙虎/新龙虎/2v3/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 900;
              break;
            case "虎":
              playIdIndex = 901;
              break;
            case "和":
              playIdIndex = 902;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 903:// 新龙虎/新龙虎/2v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 904;
              break;
            case "虎":
              playIdIndex = 905;
              break;
            case "和":
              playIdIndex = 906;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 907:// 新龙虎/新龙虎/2v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 908;
              break;
            case "虎":
              playIdIndex = 909;
              break;
            case "和":
              playIdIndex = 910;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 911:// 新龙虎/新龙虎/3v4/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 912;
              break;
            case "虎":
              playIdIndex = 913;
              break;
            case "和":
              playIdIndex = 914;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 915:// 新龙虎/新龙虎/3v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 916;
              break;
            case "虎":
              playIdIndex = 917;
              break;
            case "和":
              playIdIndex = 918;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;
      case 919:// 新龙虎/新龙虎/4v5/龙（计算注数）
        if (dragonTigerList.length > 0) {
          var dragonTigerStr = dragonTigerList[0];
          switch(dragonTigerStr) {
            case "龙":
              playIdIndex = 920;
              break;
            case "虎":
              playIdIndex = 921;
              break;
            case "和":
              playIdIndex = 922;
              break;
          }
          TencentCentService.instance.tencentGetGDBetsDragonTiger(context,hanoiBettingHandler,
              dragonTigerList, "$playIdIndex", isBetting, multiple, colorVarietyID);
        }

        break;

    }
  }

}