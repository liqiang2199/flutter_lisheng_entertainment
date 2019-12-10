
import 'package:flutter_lisheng_entertainment/model/json/agent/link_list/LinkAccountListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class LinkManagerHandler extends BaseHandler {

  void setLinkAccountList(List<LinkAccountListBeen> data);

  /**
   * 删除开户链接 结果
   */
  void setDelLinkAccount(bool result);
}