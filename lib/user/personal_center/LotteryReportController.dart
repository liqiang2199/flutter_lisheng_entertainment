import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/user_report/LotteryReportBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/user_report/UserReportDataBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/LotteryReportHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 彩票报表
class LotteryReportController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LotteryReportController();
  }

}

class _LotteryReportController extends BaseController<LotteryReportController> implements SelectionTimeCallBack, LotteryReportHandler {

  String _starTime;
  String _endTime;

  List<LotteryReportBeen> listReport = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _starTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    _endTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    UserService.instance.userReport(this, _starTime, _endTime);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.personalLotteryReport),
      body: new Column(
        children: <Widget>[
          SelectionTimeView(
              this,
          ),
          new Expanded(child: _listRecordItem (),),
        ],
      ),
    );
  }

  /// 彩票报表信息 列表
  Widget _listRecordItem () {

    return new Container(
      margin: EdgeInsets.all(15.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 2,
            //纵轴间距
            mainAxisSpacing: 0.0,
            //横轴间距
            crossAxisSpacing: 0.0,
            //子组件宽高长度比例
            childAspectRatio: 2.94),
        itemBuilder: (c, i) => Container(
          child:new GestureDetector(
            onTap: () {
              //个人投注记录
            },
            child: new Column(
              children: <Widget>[
                _gridReportItem(listReport[i]),

              ],
            ),
          ),
        ),
        itemCount: listReport.length,
      ),
    );
  }

  Widget _gridReportItem(LotteryReportBeen lotteryReportBeen) {

    return new Row(
      children: <Widget>[
        new Container(
          child: new Align(
            child:  new Text(
              lotteryReportBeen.name,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            alignment: Alignment.center,
          ),
          height: 55.0,
          width: 80.0,
          color: Color(ColorUtil.butColor),
          padding: EdgeInsets.only(left: 18.0, right: 18.0),
        ),

        new Expanded(
          child: new Container(
            child: new Align(
              alignment: Alignment.center,
              child: new Text(
                lotteryReportBeen.reportValue,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
              ),
            ),
            height: 55.0,
            color: Color(ColorUtil.bgColor_F1F1F1),
          ),
        )

      ],
    );
  }

  @override
  void selectionEndTime(String endTime) {
    _endTime = endTime;
    UserService.instance.userReport(this, _starTime, _endTime);
  }

  @override
  void selectionStartTime(String starTime) {
    _starTime = starTime;
  }

  @override
  void setUserReportDataBeen(UserReportDataBeen dataBeen) {
    listReport.clear();
    LotteryReportBeen lotteryReportTime = new LotteryReportBeen("时间","");
    LotteryReportBeen lotteryReportRecharge = new LotteryReportBeen("充值","${dataBeen.userCz}");
    LotteryReportBeen lotteryReportWithdrawal = new LotteryReportBeen("提现","${dataBeen.userTx}");
    LotteryReportBeen lotteryReportLottery = new LotteryReportBeen("投注","${dataBeen.userTz}");
    LotteryReportBeen lotteryReportJJ = new LotteryReportBeen("奖金","${dataBeen.userJg}");
    LotteryReportBeen lotteryReportFD = new LotteryReportBeen("返点","${dataBeen.userFd}");
    LotteryReportBeen lotteryReportActive = new LotteryReportBeen("活动","${dataBeen.userHd}");
    LotteryReportBeen lotteryReportFree = new LotteryReportBeen("手续费","");
    LotteryReportBeen lotteryReportTotal = new LotteryReportBeen("总盈亏","${dataBeen.userYk}");

    listReport.add(lotteryReportTime);
    listReport.add(lotteryReportRecharge);
    listReport.add(lotteryReportWithdrawal);
    listReport.add(lotteryReportLottery);
    listReport.add(lotteryReportJJ);
    listReport.add(lotteryReportFD);
    listReport.add(lotteryReportActive);
    listReport.add(lotteryReportFree);
    listReport.add(lotteryReportTotal);

    setState(() {

    });

  }



}