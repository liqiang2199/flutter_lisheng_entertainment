import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordBeen.dart';
/**
 * 账变记录
 */
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

///
abstract class AccountChangeRecordHandler extends BaseHandler{

  void setAccountChangeRecord(AccountChangeRecordBeen changeRecordBeen);

}