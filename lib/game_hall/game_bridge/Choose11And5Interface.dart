/**
 * 11 选 5 选号接口
 */
abstract class Choose11And5Interface {

  /**
   * 类型选中状态
   */
  void cpTypeChoiceState(int index, int viewOnClickIndex);

  /**
   * 号码选中状态
   */
  void cpNumChoiceState(int index, int viewOnClickIndex);

  /**
   * 清空所有选中状态
   */
  void cleanAllState(int viewOnClickIndex);

  /**
   * 选中 号码后请求网络
   */
  void choiceNumAfter();

}