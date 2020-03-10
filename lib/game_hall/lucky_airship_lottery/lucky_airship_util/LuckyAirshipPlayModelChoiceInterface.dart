
abstract class LuckyAirshipPlayModelChoiceInterface {

  /**
   * isSingle 是否是单式
   * sumValue 是否是和值
   * cpChoiceNum 需要彩票 行数
   * cpChoiceTitle 如果 cpChoiceNum == 1 时 就需要 这个标题
   * groupTitleList 彩票分组标题
   *
   */
  ///
  void setLuckyAirshipPlayChoiceValue(bool isSingle, int cpChoiceNum,
      String cpChoiceTitle, bool isGroupSumNum, bool isDragonTiger,
       List<String> groupTitleList);
}