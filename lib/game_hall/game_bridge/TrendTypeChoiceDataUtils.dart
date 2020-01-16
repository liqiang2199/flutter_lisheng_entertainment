/**
 * 走势选择 been
 */
import 'package:flutter_lisheng_entertainment/model/been/TrendTypeChoiceDataBeen.dart';

///
class TrendTypeChoiceDataUtils {

  initMapData(Map<String, List<String>> mapTrendType) {
    //单号走势
    List<String> singleNumTrend = new List();
    singleNumTrend.add("第一名");
    singleNumTrend.add("第二名");
    singleNumTrend.add("第三名");
    singleNumTrend.add("第四名");
    singleNumTrend.add("第五名");
    singleNumTrend.add("中位");
    mapTrendType["单号走势"] = singleNumTrend;

    //多号走势
    List<String> moreNumTrend = new List();
    moreNumTrend.add("五星");
    moreNumTrend.add("前二");
    moreNumTrend.add("前三");
    mapTrendType["多号走势"] = moreNumTrend;

    //大小走势
    List<String> sizeNumTrend = new List();
    sizeNumTrend.add("一二三");
    sizeNumTrend.add("三四五");
    mapTrendType["大小走势"] = sizeNumTrend;

    //单双走势
    List<String> doubleNumTrend = new List();
    doubleNumTrend.add("一二三");
    doubleNumTrend.add("三四五");
    mapTrendType["单双走势"] = doubleNumTrend;

    //号码单双
    List<String> numDoubleTrend = new List();
    numDoubleTrend.add("个数比");
    mapTrendType["号码单双"] = numDoubleTrend;

  }

  /// 河内一分彩 走势筛选数据
  static void vietnamHanoiMapData(Map<String, List<TrendTypeChoiceDataBeen>> mapTrendType) {
    //单号走势
    List<TrendTypeChoiceDataBeen> singleNumTrend = new List();
    TrendTypeChoiceDataBeen singleNumTrendDataBeenW = new TrendTypeChoiceDataBeen(0, "万位", 1, "单号走势_万位");
    TrendTypeChoiceDataBeen singleNumTrendDataBeenQ = new TrendTypeChoiceDataBeen(1, "千位", 1, "单号走势_千位");
    TrendTypeChoiceDataBeen singleNumTrendDataBeenB = new TrendTypeChoiceDataBeen(2, "百位", 1, "单号走势_百位");
    TrendTypeChoiceDataBeen singleNumTrendDataBeenS = new TrendTypeChoiceDataBeen(3, "十位", 1, "单号走势_十位");
    TrendTypeChoiceDataBeen singleNumTrendDataBeenG = new TrendTypeChoiceDataBeen(4, "个位", 1, "单号走势_个位");
    //singleNumTrendDataBeenW.isChoice = true;
    singleNumTrend.add(singleNumTrendDataBeenW);
    singleNumTrend.add(singleNumTrendDataBeenQ);
    singleNumTrend.add(singleNumTrendDataBeenB);
    singleNumTrend.add(singleNumTrendDataBeenS);
    singleNumTrend.add(singleNumTrendDataBeenG);

    mapTrendType["单号走势"] = singleNumTrend;

    //多号走势
    List<TrendTypeChoiceDataBeen> moreNumTrend = new List();

    TrendTypeChoiceDataBeen moreNumTrend0 = new TrendTypeChoiceDataBeen(0, "五星", 2, "多号走势_五星");
    TrendTypeChoiceDataBeen moreNumTrend1 = new TrendTypeChoiceDataBeen(1, "后四", 2, "多号走势_后四");
    TrendTypeChoiceDataBeen moreNumTrend2 = new TrendTypeChoiceDataBeen(2, "前四", 2, "多号走势_前四");
    TrendTypeChoiceDataBeen moreNumTrend3 = new TrendTypeChoiceDataBeen(3, "后三", 2, "多号走势_后三");
    TrendTypeChoiceDataBeen moreNumTrend4 = new TrendTypeChoiceDataBeen(4, "中三", 2, "多号走势_中三");
    TrendTypeChoiceDataBeen moreNumTrend5 = new TrendTypeChoiceDataBeen(5, "前三", 2, "多号走势_前三");
    TrendTypeChoiceDataBeen moreNumTrend6 = new TrendTypeChoiceDataBeen(6, "后二", 2, "多号走势_后二");
    TrendTypeChoiceDataBeen moreNumTrend7 = new TrendTypeChoiceDataBeen(7, "前二", 2, "多号走势_前二");

    moreNumTrend.add(moreNumTrend0);
    moreNumTrend.add(moreNumTrend1);
    moreNumTrend.add(moreNumTrend2);
    moreNumTrend.add(moreNumTrend3);
    moreNumTrend.add(moreNumTrend4);
    moreNumTrend.add(moreNumTrend5);
    moreNumTrend.add(moreNumTrend6);
    moreNumTrend.add(moreNumTrend7);

    mapTrendType["多号走势"] = moreNumTrend;

    //大小走势
    List<TrendTypeChoiceDataBeen> sizeNumTrend = new List();
    TrendTypeChoiceDataBeen sizeNumTrendWQB = new TrendTypeChoiceDataBeen(1, "万千百", 3, "大小走势_万千百");
    TrendTypeChoiceDataBeen sizeNumTrendBSG = new TrendTypeChoiceDataBeen(2, "百十个", 3, "大小走势_百十个");

    sizeNumTrend.add(sizeNumTrendWQB);
    sizeNumTrend.add(sizeNumTrendBSG);
    mapTrendType["大小走势"] = sizeNumTrend;

    //单双走势
    List<TrendTypeChoiceDataBeen> doubleNumTrend = new List();
    TrendTypeChoiceDataBeen doubleNumTrendWQB = new TrendTypeChoiceDataBeen(1, "万千百", 4, "单双走势_万千百");
    TrendTypeChoiceDataBeen doubleNumTrendBSG = new TrendTypeChoiceDataBeen(2, "百十个", 4, "单双走势_百十个");

    doubleNumTrend.add(doubleNumTrendWQB);
    doubleNumTrend.add(doubleNumTrendBSG);
    mapTrendType["单双走势"] = doubleNumTrend;

    //五星和值
    List<TrendTypeChoiceDataBeen> fiveTotalNumTrend = new List();
    TrendTypeChoiceDataBeen fiveTotalNumTrendW = new TrendTypeChoiceDataBeen(0, "大小单双", 5, "五星和值_大小单双");

    fiveTotalNumTrend.add(fiveTotalNumTrendW);
    mapTrendType["五星和值"] = fiveTotalNumTrend;

    //和值 各类
    List<TrendTypeChoiceDataBeen> totalNumTrend = new List();
    TrendTypeChoiceDataBeen totalNumTrendW = new TrendTypeChoiceDataBeen(0, "各类", 6, "和值_各类");

    totalNumTrend.add(totalNumTrendW);
    mapTrendType["和值"] = totalNumTrend;

    //跨度 各类
    List<TrendTypeChoiceDataBeen> kdTrend = new List();
    TrendTypeChoiceDataBeen kdTrendG = new TrendTypeChoiceDataBeen(0, "各类", 7, "和值_跨度");

    kdTrend.add(kdTrendG);
    mapTrendType["跨度"] = kdTrend;

    // 龙虎和
    List<TrendTypeChoiceDataBeen> dragonTigerTrend = new List();
    TrendTypeChoiceDataBeen dragonTigerTrend2WB = new TrendTypeChoiceDataBeen(1, "万千\n万百", 8, "龙虎和_万千|万百");
    TrendTypeChoiceDataBeen dragonTigerTrend2WG = new TrendTypeChoiceDataBeen(2, "万十\n万个", 8, "龙虎和_万十|万个");
    TrendTypeChoiceDataBeen dragonTigerTrend2QB = new TrendTypeChoiceDataBeen(3, "千百\n千十", 8, "龙虎和_千百|千十");
    TrendTypeChoiceDataBeen dragonTigerTrendQBS = new TrendTypeChoiceDataBeen(4, "千个\n百十", 8, "龙虎和_千个|百十");
    TrendTypeChoiceDataBeen dragonTigerTrendBSG = new TrendTypeChoiceDataBeen(5, "百个\n十个", 8, "龙虎和_百个|十个");

    dragonTigerTrend.add(dragonTigerTrend2WB);
    dragonTigerTrend.add(dragonTigerTrend2WG);
    dragonTigerTrend.add(dragonTigerTrend2QB);
    dragonTigerTrend.add(dragonTigerTrendQBS);
    dragonTigerTrend.add(dragonTigerTrendBSG);

    mapTrendType["龙虎和"] = dragonTigerTrend;

  }

}