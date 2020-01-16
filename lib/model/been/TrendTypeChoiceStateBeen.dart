/**
 * 状态选中 传值
 */
///
class TrendTypeChoiceStateBeen {
  String indexPage = "1";
  bool isLineConnection = false;//是否包含先的连接
  bool isSingleDouble = false;// 是否是单双走势
  bool isMaxMin = false;//是否是大小走势
  bool isFiveNum = false;// 是否是五星和值
  bool isVariousSum = false;// 是否是各类和值
  bool isVariousSpan = false;// 是否是各类跨度
  bool isDragonTiger = true;// 是否是龙虎和
  int dragonTigerPage = 1;/// 龙虎和下标1（万千 万百）2（万十 万个） 3（千百 千十） 4（千个  百十） 5 （百个 十个）
  String trendTitleStr ;
  int trendTypeId; // 赛选的 类型 ID

  TrendTypeChoiceStateBeen();
}