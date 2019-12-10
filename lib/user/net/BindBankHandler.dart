
import 'package:flutter_lisheng_entertainment/model/json/bank/type/GetBankTypeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class BindBankHandler extends BaseHandler{


  void setBankTypeList(List<GetBankTypeDataBeen> data);

  /**
   * 绑定银行卡结果
   */
  void setBindBankResult(bool result,String msg);
}