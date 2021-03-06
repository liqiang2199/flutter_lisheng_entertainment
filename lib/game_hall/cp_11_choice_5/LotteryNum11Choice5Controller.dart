
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryDataInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryInfoDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListTwoDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 开奖记录
 */
///
class LotteryNum11Choice5Controller extends StatefulWidget {

  String colorVariety;
  LotteryNum11Choice5Controller(this.colorVariety);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LotteryNum11Choice5Controller(colorVariety);
  }

}

class _LotteryNum11Choice5Controller extends BaseRefreshController<LotteryNum11Choice5Controller> with AutomaticKeepAliveClientMixin  implements LotteryNum11Choice5Handler{

  String colorVariety;
  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen = new List();

  _LotteryNum11Choice5Controller(this.colorVariety);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //GameService.instance.kjlogList("9","1", this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return smartRefreshBase(
      _cpList()
    );
  }

  @override
  void onRefreshData() {
    page = 1;

    switch(colorVariety) {
      case "${Constant.GAME_NUM_VIETNAME_HANOI}":
      case "${Constant.GAME_NUM_VIETNAME_HANOI_8}":// 河内 5分彩
        /// 河内一分彩
        GameService.instance.hanoi_kjlogList("$page", this, colorVariety);
        break;
      case "${Constant.GAME_NUM_TENCENT}":// 腾讯分分彩
      case "${Constant.GAME_NUM_5_TENCENT}"://5分彩
      case "${Constant.GAME_NUM_10_TENCENT}"://10分彩
        GameService.instance.tencent_kjlogList("$page", this, colorVariety);
        break;
      case "${Constant.GAME_NUM_ODD_INTEREST}":// 奇趣一分彩
      case "${Constant.GAME_NUM_ODD_INTEREST_4}":// 奇趣5分彩
      case "${Constant.GAME_NUM_ODD_INTEREST_5}":// 奇趣10分彩

      case "${Constant.GAME_NUM_LUCKY_AIRSHIP_13}":// 幸运飞艇
      case "${Constant.GAME_NUM_CHONGQING_1}":// 重庆时时彩
        GameService.instance.oddInterest_kjlogList("$page", this, colorVariety);
        break;
      default:
        GameService.instance.kjlogList(colorVariety,"$page", this);
        break;
    }
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    super.onResumed();
    //onRefreshData();
  }

  @override
  bool isCanLoadMore(){

    return false;
  }

  @override
  bool isCanRefresh(){

    return true;
  }

  Widget _cpList() {

    return ListView.builder(
//      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) => Container(
        color: Colors.white,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _itemLine(openLotteryListBeen[i]),

          ],
        ),
      ),
      //itemExtent: 200.0,
      itemCount: openLotteryListBeen.length,
    );
  }

  Widget _itemLine(OpenLotteryListTwoDataListBeen dataListBeen) {

    return new Column(
      children: <Widget>[
        _gameItem(dataListBeen),
        CommonView().commonLine_NoMargin(context),
      ],
    );
  }

  Widget _gameItem(OpenLotteryListTwoDataListBeen dataListBeen) {

//    if(colorVariety == "15") {
//      return new Container(
//        margin: EdgeInsets.only(bottom: 15.0),
//        padding: EdgeInsets.only(left: 15.0,),
//        color: Colors.white,
//        child: new Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            _num(dataListBeen.pre_draw_issue),
//            _numStrList(dataListBeen),
//
//            new Expanded(child: _numHanoiOneLottery(dataListBeen.play),),
//
//          ],
//        ),
//      );
//    }

    return new Container(
      margin: EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.only(left: 15.0,),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _num(dataListBeen.pre_draw_issue),
          _numStrList(dataListBeen),

        ],
      ),
    );
  }

  Widget _numStrList(OpenLotteryListTwoDataListBeen dataListBeen) {
    List<Widget> numViewList = new List();
    var pre_draw_code = dataListBeen.pre_draw_code;
    var preListStr = pre_draw_code.split(",");
    preListStr.forEach((valueNum) {
      numViewList.add(_cqNumView(valueNum));

    });
    return new Row(
      children: numViewList,
    );
  }

  /**
   * 11 选 5 的下拉开奖号码列表
   */
  ///
  Widget _num(String title) {
    var length = title.length;
    if (colorVariety == "15" || colorVariety == "${Constant.GAME_NUM_TENCENT}"
        || colorVariety == "${Constant.GAME_NUM_5_TENCENT}"
        || colorVariety == "${Constant.GAME_NUM_10_TENCENT}") {
      /// 河内一分彩 腾讯 1 ，5 ，10 分彩
      title = "${title.substring(length - 4, length)}期";
    } else {
      /// 11 选 5
      title = "${title.substring(length - 2, length)}期";
    }

    return new Container(
      margin: EdgeInsets.only(right: 10.0, top: 15.0),
      alignment: Alignment.center,
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 14.0,
        ),
      ),
    );
  }

  /// 河内一分彩
  Widget _numHanoiOneLottery(String title) {
    return new Container(
      margin: EdgeInsets.only(right: 10.0, top: 15.0),
      alignment: Alignment.center,
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _cqNumView(String num) {

    return new Container(
      height: 22.0,
      width: 22.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 5.0, top: 15.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Color(ColorUtil.bgColor_E7242C),
        border: new Border.all(color: Color(ColorUtil.bgColor_E7242C), width: 1), // 边色与边宽度
        //borderRadius: new BorderRadius.circular((24.0)), // 圆角度
      ),
      child: new Text(
        num,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void setOpenLotteryListData(OpenLotteryListDataBeen data) {
    /// 开奖列表 List<OpenLotteryListTwoDataListBeen>
    var dataList = data.data;
    var dataListBeen = dataList.data;
    setState(() {
      this.openLotteryListBeen = dataListBeen;
    });
  }

  @override
  void setOpenLotteryListInfoData(CpOpenLotteryDataInfoBeen data) {
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}