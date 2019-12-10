
import 'package:flutter_lisheng_entertainment/model/json/bank/BankDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class BankListHandler extends BaseHandler{

  void setBankListDataBeen(List<BankDataBeen> data);

}