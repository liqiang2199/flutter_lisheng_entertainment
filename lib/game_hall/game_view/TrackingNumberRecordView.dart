
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/**
 * 追号记录
 */
///
class TrackingNumberRecordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TrackingNumberRecordView();
  }

}

class _TrackingNumberRecordView extends BaseRefreshController<TrackingNumberRecordView> implements SelectionTimeCallBack{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new SelectionTimeView(this),
        new Expanded(child: smartRefreshBase(_cpList(),)),

      ],
    );
  }

  Widget _cpList() {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        color: Colors.white,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _listItem(),
          ],
        ),
      ),
      //itemExtent: 200.0,
      itemCount: 2,
    );
  }

  Widget _listItem() {

    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: new Card(
        color: Colors.white,
        elevation: 5.0,
        child: new Column(
          children: <Widget>[

            _cpTypeTitle("广东11选5","开奖期号：20191223-20期"),
            CommonView().commonLine_NoMargin(context),

            _itemContent(),

          ],
        ),
      ),
    );
  }

  /// 彩票种类
  Widget _cpTypeTitle(String title, String time) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ),


          new Text(
            time,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),
        ],
      ),
    );
  }

  /// 彩票 玩法 金额 状态
  Widget _itemContent() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: new Row(
        children: <Widget>[

          new Image.asset(ImageUtil.imgLotteryCenterGD11Choice5, width: 50.0, height: 50.0,),

          SpaceViewUtil.pading_Left(8.0),

          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                new Text(
                  "前三组合复式",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                ),

                new Text(
                  "金额：1.00",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_888888),
                  ),
                ),

              ],
            ),
          ),

          new Text(
            "已完成",
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_FF8814),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void selectionEndTime(String endTime) {
  }

  @override
  void selectionStartTime(String starTime) {
  }

}