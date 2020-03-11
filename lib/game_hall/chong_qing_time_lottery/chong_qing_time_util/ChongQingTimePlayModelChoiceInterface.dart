
abstract class ChongQingTimePlayModelChoiceInterface {

  /**
   * isSingle 是否是单式
   * sumValue 是否是和值
   * cpChoiceNum 需要彩票 行数
   * cpChoiceTitle 如果 cpChoiceNum == 1 时 就需要 这个标题
   * isGroupSumNum 是组选和值还是直选和值
   * isDragonTiger 是否是 新龙虎
   * groupTitleList 彩票分组标题
   *
   */
  ///
  void setChongQingTimePlayChoiceValue(bool isSingle, bool sumValue, int cpChoiceNum,
      String cpChoiceTitle, bool isGroupSumNum, bool isDragonTiger, bool isFiveStarsTotalNum, bool isContainsRepeat,  List<String> groupTitleList);
}