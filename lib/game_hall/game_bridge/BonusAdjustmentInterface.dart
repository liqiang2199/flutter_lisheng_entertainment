/**
 * 奖金调节
 */
abstract class BonusAdjustmentInterface {

  /**
   * 投注注数 加减
   */
  void bettingMultipleAddAndSub(bool isAdd, int num);

  /**
   * 下标设置
   */
  void setSegmentedIndex(int index);

  /**
   * 滑块改动数字大小
   */
  void sliderChangeNum(double sliderValue);


}