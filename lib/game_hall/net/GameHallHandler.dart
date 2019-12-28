import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataBeen.dart';
/**
 * 彩票种类选择
 */
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

///
abstract class GameHallHandler extends BaseHandler{

  void setLotteryTypeData(LotteryTypeDataBeen dataBeen);

}