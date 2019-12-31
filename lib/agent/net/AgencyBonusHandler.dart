
import 'package:flutter_lisheng_entertainment/model/json/agent/agency_bonus/AgencyBonusBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/agency_bonus/AgencyBonusHistoryBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class AgencyBonusHandler extends BaseHandler{

  /**
   * 我的分红
   */
  ///
  void setAgencyBonusBeen(AgencyBonusBeen dataBeen);

  /**
   * 历史分红
   */
  ///
  void setAgencyBonusHistoryBeen(AgencyBonusHistoryBeen dataBeen);

}