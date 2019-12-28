
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
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
 * 11 选 5 开奖列表
 */
class LotteryNum11Choice5Controller extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LotteryNum11Choice5Controller();
  }

}

class _LotteryNum11Choice5Controller extends BaseRefreshController<LotteryNum11Choice5Controller> with AutomaticKeepAliveClientMixin  implements LotteryNum11Choice5Handler{

  List<OpenLotteryListTwoDataListBeen> openLotteryListBeen = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GameService.instance.kjlogList("9","1", this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return smartRefreshBase(
      _cpList()
    );
  }

  void onRefreshData() {
    GameService.instance.kjlogList("9","1", this);
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
  Widget _num(String title) {
    var length = title.length;
    title = "${title.substring(length - 2, length)}期";
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
      height: 25.0,
      width: 25.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.0, top: 15.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Color(ColorUtil.bgColor_E7242C),
        border: new Border.all(color: Color(ColorUtil.bgColor_E7242C), width: 1), // 边色与边宽度
        //borderRadius: new BorderRadius.circular((24.0)), // 圆角度
      ),
      child: new Text(
        num,
        style: TextStyle(
          fontSize: 14.0,
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