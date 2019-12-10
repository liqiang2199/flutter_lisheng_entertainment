import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 投注记录详情
class BettingRecordDetailController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BettingRecordDetailController();
  }

}

class _BettingRecordDetailController extends BaseController<BettingRecordDetailController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.personalBettingRecord),
      body: new ListView(
        children: <Widget>[
          _recordBottomList("账户：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("订单编号：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("玩法：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("彩种：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("期号：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("投注时间：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("投注内容：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("投注金额：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("中奖金额：","dddd"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("状态：","dddd"),
          CommonView().commonLine_NoMargin(context),
        ],
      ),
    );
  }


  Widget _recordBottomList(String name, String content) {

    return new Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Row(
        children: <Widget>[
          new Text(
            name,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          SpaceViewUtil.pading_Left(5.0),

          new Text(
            content,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

        ],
      ),
    );
  }

}