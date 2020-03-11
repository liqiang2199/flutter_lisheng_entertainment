
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
///
class GameBettingRecordView extends StatefulWidget {

  String _colorVariety;
  GameBettingRecordView(this._colorVariety);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameBettingRecordView(this._colorVariety);
  }

}

class _GameBettingRecordView extends BaseRefreshController<GameBettingRecordView>
    implements SelectionTimeCallBack,GetBettingRecordListHandler,ChoiceBettingStatusInterface {

  String _colorVariety;
  _GameBettingRecordView(this._colorVariety);

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
    GameService.instance.bettingList(this, "$_colorVariety", "0", startTime, endTime, "$page");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new GameSelectionTimeAndBettingStateView(this, choiceBettingStatusInterface: this,),
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
      if (!TextUtil.isEmpty(param.one_num)) {
        bettingNumList.write("${param.one_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.two_num)) {
        bettingNumList.write("${param.two_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.three_num)) {
        bettingNumList.write("${param.three_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.four_num)) {
        bettingNumList.write("${param.four_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.five_num)) {
        bettingNumList.write("${param.five_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.six_num)) {
        bettingNumList.write("${param.six_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.seven_num)) {
        bettingNumList.write("${param.seven_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.eight_num)) {
        bettingNumList.write("${param.eight_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.nine_num)) {
        bettingNumList.write("${param.nine_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.ten_num)) {
        bettingNumList.write("${param.ten_num}");
        bettingNumList.write("/");
      }
      if(!TextUtil.isEmpty(param.data_num)) {
        bettingNumList.write("${param.data_num}");
        bettingNumList.write("");
      }
      if(!TextUtil.isEmpty(param.num_type)) {
        bettingNumList.write("${param.num_type}");
        bettingNumList.write("");
      }
    }

    String cpFindName = dataListBeen.lottery_name;
    if (TextUtil.isEmpty(cpFindName)) {
      if (_colorVariety == "9") {
        cpFindName = "广东11选5";
      } else {
        if (_colorVariety == "15") {
          cpFindName = "河内一分彩";
        }

      }
    }

    var status = dataListBeen.status;
    bool isCancelTheOrder = true;
    if (TextUtil.isEmpty(dataListBeen.remark)) {

      switch(status) {
        case "1":
          dataListBeen.remark = "待开奖";
          break;
        case "2":
          dataListBeen.remark = "中奖";
          break;
        case "3":
          dataListBeen.remark = "未中奖";
          break;
        case "5":
          //已撤单
          dataListBeen.remark = "已撤单";
          break;
      }
    }

    String zjMoney = "0.00";
    if (status == "2") {
      zjMoney = "${!TextUtil.isEmpty(dataListBeen.jg_money) ? dataListBeen.jg_money : ""}";
    }

    if (status == "5") {
      isCancelTheOrder = false;
    }

    return new Container(
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      child: new Column(
        children: <Widget>[

          _itemTopCpFind(cpFindName,"${!TextUtil.isEmpty(dataListBeen.pre_draw_issue) ? dataListBeen.pre_draw_issue : ""}"),
          _recordBottomList("玩法：", "${!TextUtil.isEmpty(dataListBeen.play) ? dataListBeen.play : ""}"),
          _recordBottomList("开奖号码：", "${!TextUtil.isEmpty(dataListBeen.kj_num) ? dataListBeen.kj_num : ""}"),
          _recordBottomList("订单编号：", "${!TextUtil.isEmpty(dataListBeen.ordercode) ? dataListBeen.ordercode : ""}"),
          _recordBottomList("订单时间：", "${!TextUtil.isEmpty(dataListBeen.createtime) ? dataListBeen.createtime : ""}"),
          _recordBottomList("投注内容：", bettingNumList.toString()),
          //  1=待开奖,2=中奖,3=未中奖,
          _recordBottomList("投注状态：", "${!TextUtil.isEmpty(dataListBeen.remark) ? dataListBeen.remark : ""}"),
          _recordBottomList("投注金额：", "${!TextUtil.isEmpty(dataListBeen.xz_money) ? dataListBeen.xz_money  : ""}"),
          _recordBottomList("中奖金额：", zjMoney),
          SpaceViewUtil.pading_Top_10(),
          _butRowOperation("${dataListBeen.id}", dataListBeen.paly_id, isCancelTheOrder),
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

        //_butCopy(qs),

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

  Widget _butRowOperation(String id, int paly_id, bool isCancelTheOrder) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Visibility(
            child: _butOperation("撤单", 1, id, paly_id),
          visible: isCancelTheOrder,
        ),
        _butOperation("再来一注", 2, id, paly_id),
      ],
    );
  }

  /**
   * 删除  再来一注
   */
  ///
  Widget _butOperation(String title, int index, String id, int paly_id) {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 70.0,
        height: 26.0  ,
        margin: EdgeInsets.only(left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //
          switch(index) {
            case 1:
              //撤单
              GameService.instance.delOrder(context, this, "$id");
              break;
            case 2:
              //再来一注
              GameService.instance.orderOnce(context, this, "$id");
//              Play11Choice5DataPlayBeen playBeen = new Play11Choice5DataPlayBeen(0, 0, paly_id, "", "", "", "", "", "");
//
//              HanoiPlayModelChoiceUtils.getInstance().getGameHttpBettingNum(context,playBeen,
//                  choiceCpNumList, groupBitsList, this, true, 1);
              break;
          }

        },color: Color(ColorUtil.whiteColor),
          child: new Text("$title"
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
  void onRefreshData() {
    // TODO: implement onRefreshData
    super.onRefreshData();
    GameService.instance.bettingList(this, "$_colorVariety", statusId, startTime, endTime, "$page");
  }

  @override
  void onLoadingDataRefresh() {
    GameService.instance.bettingList(this, "$_colorVariety", statusId, startTime, endTime, "$page");
  }


  @override
  void selectionEndTime(String endTime) {
    this.endTime = endTime;
  }

  @override
  void selectionStartTime(String starTime) {
    this.startTime = starTime;
    GameService.instance.bettingList(this, "$_colorVariety", statusId, startTime, endTime, "$page");
  }

  @override
  void setGetBettingRecordData(GetBettingRecordBeen recordDataBeen) {
//    recordDataList.clear();
    this.recordDataList = recordDataBeen.data.data;
    setState(() {

    });
  }

  @override
  void getOrderOnceResult(bool result) {
    if (result) {
      // 再来一注 结果
      onRefreshData();
    }
  }

  @override
  void bettingStatusChoice(String statusId) {
    this.statusId = statusId;
  }

}