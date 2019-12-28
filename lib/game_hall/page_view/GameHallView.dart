
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameHallHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

import 'LotteryTicketsTypeGridItemView.dart';

class GameHallView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameHallView();
  }

}

class _GameHallView extends BaseRefreshController<GameHallView> implements GameHallHandler {

  List<LotteryTypeDataListBeen> dataLotteryType = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GameService.instance.lotteryList(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return smartRefreshBase(new Column(
      children: <Widget>[
//       smartRefreshBase( _listRecordItem()),
        new Expanded(child: _listRecordItem(),),
      ],
    ));
  }

  @override
  void onRefreshData() {

  }

  /// 游戏大厅 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        color: Colors.white,
        child:  new Column(
          children: <Widget>[
            LotteryTicketsTypeGridItemView(dataLotteryType[i]),

          ],
        ),
      ),
      //itemExtent: 200.0,
      itemCount: dataLotteryType.length,
    );
  }

  @override
  void setLotteryTypeData(LotteryTypeDataBeen dataBeen) {
    var data = dataBeen.data;
    setState(() {
      dataLotteryType = data;
    });
  }

//  Widget _gameItem() {
//    return new Container(
//      color: Colors.white,
//      child: new Column(
//        children: <Widget>[
//          CommonView().commonLine_NoMarginChange(context,10),
//          _gameTitle(),
//          _gridList(),
//        ],
//      ),
//    );
//  }
//
//  Widget _gameTitle() {
//
//    return new Align(
//      alignment: Alignment.centerLeft,
//      child: new Container(
//        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//        child: new Stack(
//          children: <Widget>[
//            new Image.asset(ImageUtil.imgGameTitleIcon, width: 79.0, height: 28.0,),
//            new Text(
//              "11选5",
//              style: new TextStyle(
//                color: Colors.white,
//                fontSize: 16.0,
//              ),
//              textAlign: TextAlign.center,
//            ),
//          ],
//        ),
//      ),
//    );
//
//  }
//
//  Widget _gridList() {
//
//    return new Container(
//      child: new GridView.count(
//        physics: new NeverScrollableScrollPhysics(),
//        crossAxisCount: 4,
//        //padding: const EdgeInsets.all(8.0),
//        primary: false,
//        mainAxisSpacing: 0.0,//竖向间距
//        crossAxisSpacing: 0.0,//横向间距
//        childAspectRatio: 1.3,
//        children: _gridListItemView(),
//        shrinkWrap: true,
//
//      ),
//    );
//  }
//
//  //操作 的 item
//  Widget _gridClassificationItem(String icon, String title, int index) {
//
//    return new Container(
//      color: Colors.white,
//      height: 60.0,
//      child: new GestureDetector(
//        onTap: () {
//          //点击 投注
//          Navigator.pushNamed(context, RouteUtil.bettingController);
//        },
//        child: new Column(
//          children: <Widget>[
//
//            new Image.asset(icon, width: 40.0, height: 40.0,),
//            SpaceViewUtil.pading_Top_10(),
//
//            new Text(title,
//              style: new TextStyle(
//                  fontSize: 14.0,
//                  color: Color(ColorUtil.textColor_888888)
//              ),
//            ),
//
//          ],
//        ),
//      ),
//    );
//  }
//
//  List<Widget> _gridListItemView() {
//    List<Widget> gridListItem = new List();
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    gridListItem.add(_gridClassificationItem( ImageUtil.imgLotteryCenterCqSSC,"11选5", 1));
//    return gridListItem;
//  }

}