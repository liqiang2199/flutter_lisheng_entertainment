import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
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

class _LotteryReportController extends BaseController<LotteryReportController> implements SelectionTimeCallBack {
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
                _gridReportItem(),

              ],
            ),
          ),
        ),
        itemCount: 9,
      ),
    );
  }

  Widget _gridReportItem() {

    return new Row(
      children: <Widget>[
        new Container(
          child: new Align(
            child:  new Text(
              "时间",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            alignment: Alignment.center,
          ),
          height: 48.0,
          color: Color(ColorUtil.butColor),
          padding: EdgeInsets.only(left: 18.0, right: 18.0),
        ),

        new Expanded(
          child: new Container(
            child: new Align(
              alignment: Alignment.center,
              child: new Text(
                "时间",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
              ),
            ),
            height: 48.0,
            color: Color(ColorUtil.bgColor_F1F1F1),
          ),
        )

      ],
    );
  }

  @override
  void selectionEndTime(String endTime) {
  }

  @override
  void selectionStartTime(String starTime) {
  }

}