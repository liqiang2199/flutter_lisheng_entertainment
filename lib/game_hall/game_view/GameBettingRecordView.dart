
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/GetBettingRecordListHandler.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/GameSelectionTimeAndBettingStateView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/bridge/ChoiceBettingStatusInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/**
 * 游戏里面 -》 投注记录
 */
class GameBettingRecordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameBettingRecordView();
  }

}

class _GameBettingRecordView extends BaseRefreshController<GameBettingRecordView>
    implements SelectionTimeCallBack,GetBettingRecordListHandler,ChoiceBettingStatusInterface {

  String startTime = "";
  String endTime = "";
  String statusId = "0";

  List<GetBettingRecordDataListBeen> recordDataList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    endTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    GameService.instance.bettingList(this, "9", "0", startTime, endTime);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new GameSelectionTimeAndBettingStateView(this),
        new Expanded(child: smartRefreshBase(_cpList(),)),

      ],
    );
  }

  Widget _cpList() {

    //如果列表没有数据
    if (recordDataList.length <= 0) {

      return new Container(
        child: new Text(""),
      );
    }

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        color: Colors.white,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _recordListItem(recordDataList[i], i),

          ],
        ),
      ),
      //itemExtent: 200.0,
      itemCount: recordDataList.length,
    );
  }

  Widget _recordListItem(GetBettingRecordDataListBeen dataListBeen, int i) {

    print("_recordListItem = i = $i");

    StringBuffer bettingNumList = new StringBuffer();
    if (dataListBeen != null && dataListBeen.param != null) {
      var param = dataListBeen.param;
      bettingNumList.write("${param.one_num}");
      if(!TextUtil.isEmpty(param.two_num)) {
        bettingNumList.write("${param.two_num}");
      }
      if(!TextUtil.isEmpty(param.three_num)) {
        bettingNumList.write("${param.three_num}");
      }
      if(!TextUtil.isEmpty(param.data_num)) {
        bettingNumList.write("${param.data_num}");
      }
    }

    return new Container(
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      child: new Column(
        children: <Widget>[

          _itemTopCpFind("广东11选5","${!TextUtil.isEmpty(dataListBeen.pre_draw_issue) ? dataListBeen.pre_draw_issue : ""}"),
          _recordBottomList("玩法：", "${!TextUtil.isEmpty(dataListBeen.play) ? dataListBeen.play : ""}"),
          _recordBottomList("开奖号码：", "${!TextUtil.isEmpty(dataListBeen.kj_num) ? dataListBeen.kj_num : ""}"),
          _recordBottomList("订单编号：", "${!TextUtil.isEmpty(dataListBeen.ordercode) ? dataListBeen.ordercode : ""}"),
          _recordBottomList("订单时间：", "${!TextUtil.isEmpty(dataListBeen.createtime) ? dataListBeen.createtime : ""}"),
          _recordBottomList("投注内容：", bettingNumList.toString()),
          _recordBottomList("投注状态：", "${!TextUtil.isEmpty(dataListBeen.remark) ? dataListBeen.remark : ""}"),
          _recordBottomList("投注金额：", "${!TextUtil.isEmpty(dataListBeen.xz_money) ? dataListBeen.xz_money  : ""}"),
          _recordBottomList("中奖金额：", "${!TextUtil.isEmpty(dataListBeen.jg_money) ? dataListBeen.jg_money : ""}"),
          SpaceViewUtil.pading_Top_10(),
          CommonView().commonLine_NoMargin(context),
          SpaceViewUtil.pading_Top_10(),
        ],
      ),
    );
  }

  Widget _itemTopCpFind(String name, String qs) {
    if (!TextUtil.isEmpty(qs) && qs.length >= 2) {
      var startQs = qs.substring(0, qs.length -2);
      var endQs = qs.substring(qs.length -2, qs.length);
      qs = "$startQs-$endQs";
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        new Text(
          name,
          style: TextStyle(
            fontSize: 16.0,
            color: Color(ColorUtil.textColor_333333),
          ),
        ),

        SpaceViewUtil.pading_Left(5.0),

        new Text(
          "$qs期",
          style: TextStyle(
            fontSize: 16.0,
            color: Color(ColorUtil.textColor_333333),
          ),
        ),

        _butCopy(qs),

      ],
    );
  }

  /**
   * 复制期号
   */
  ///
  Widget _butCopy(String qs) {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 70.0,
        height: 26.0  ,
        margin: EdgeInsets.only(left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //
          ClipboardData data = new ClipboardData(text: qs);
          Clipboard.setData(data);
          //复制成功
          showToast("复制成功");

        },color: Color(ColorUtil.whiteColor),
          child: new Text("复制期号"
            , style: TextStyle(fontSize: 12.0,color: Color(ColorUtil.butColor)),),
          //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(ColorUtil.butColor),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
        ),
      ),
    );
  }

  Widget _recordBottomList(String name, String content) {

    return new Container(
      padding: EdgeInsets.only(top: 5.0),
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
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

        ],
      ),
    );
  }


  @override
  void selectionEndTime(String endTime) {
    this.endTime = endTime;
  }

  @override
  void selectionStartTime(String starTime) {
    this.startTime = starTime;
    GameService.instance.bettingList(this, "9", statusId, startTime, endTime);
  }

  @override
  void setGetBettingRecordData(GetBettingRecordBeen recordDataBeen) {
//    recordDataList.clear();
    this.recordDataList = recordDataBeen.data.data;
    setState(() {

    });
  }

  @override
  void bettingStatusChoice(String statusId) {
    this.statusId = statusId;
  }

}