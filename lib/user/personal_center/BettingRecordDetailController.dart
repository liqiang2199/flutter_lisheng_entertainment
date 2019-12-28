import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 投注记录详情
class BettingRecordDetailController extends StatefulWidget {

  GetBettingRecordDataListBeen recordDataListBeen;

  BettingRecordDetailController(this.recordDataListBeen,{Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BettingRecordDetailController(recordDataListBeen);
  }

}

class _BettingRecordDetailController extends BaseController<BettingRecordDetailController> {

  GetBettingRecordDataListBeen recordDataListBeen;
  _BettingRecordDetailController(this.recordDataListBeen);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    String qs = recordDataListBeen.pre_draw_issue;
    if (!TextUtil.isEmpty(qs) && qs.length >= 4) {
      var startQs = qs.substring(0, qs.length -4);
      var endQs = qs.substring(qs.length -4, qs.length);
      qs = "$startQs-$endQs";
    }

    StringBuffer bettingNumList = new StringBuffer();
    if (recordDataListBeen != null && recordDataListBeen.param != null) {
      var param = recordDataListBeen.param;
      bettingNumList.write("${param.one_num}");
      bettingNumList.write(",");
      if(!TextUtil.isEmpty(param.two_num)) {
        bettingNumList.write("${param.two_num}");
      }
      bettingNumList.write(",");
      if(!TextUtil.isEmpty(param.three_num)) {
        bettingNumList.write("${param.three_num}");
      }
      bettingNumList.write(",");
      if(!TextUtil.isEmpty(param.data_num)) {
        bettingNumList.write("${param.data_num}");
      }
    }

    int colorText = ColorUtil.textColor_333333;
    String textContent = "";
    if (recordDataListBeen != null) {
      switch(recordDataListBeen.status) {
        case "1":
        //待开奖
          textContent = "待开奖";
          colorText = ColorUtil.butColor;
          break;
        case "2":
        //待开奖
          textContent = "中奖";
          colorText = ColorUtil.bgColor_E7242C;
          break;
        case "3":
        //待开奖
          textContent = "未中奖";
          colorText = ColorUtil.textColor_888888;
          break;
      }
    }


    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.personalBettingRecord),
      body: new ListView(
        children: <Widget>[
          _recordBottomList("账户：",SpUtil.getString(Constant.USER_NAME)),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("订单编号：","${recordDataListBeen.ordercode}"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("玩法：","${!TextUtil.isEmpty(recordDataListBeen.play) ? recordDataListBeen.play : ""}"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("彩种：","${recordDataListBeen.lottery_name}"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("期号：","$qs"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("投注时间：","${!TextUtil.isEmpty(recordDataListBeen.createtime) ? recordDataListBeen.createtime : ""}"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("投注内容：","${bettingNumList.toString()}"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("投注金额：","${!TextUtil.isEmpty(recordDataListBeen.xz_money) ? recordDataListBeen.xz_money  : ""}元"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("中奖金额：","${!TextUtil.isEmpty(recordDataListBeen.jg_money) ? recordDataListBeen.jg_money : ""}元"),
          CommonView().commonLine_NoMargin(context),
          _recordBottomList("状态：","$textContent"),
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