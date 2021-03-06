
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 每组的彩票种类
 */
///
class LotteryTicketsTypeGridItemView extends StatefulWidget {

  LotteryTypeDataListBeen  dataListBeen;


  LotteryTicketsTypeGridItemView(this.dataListBeen);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LotteryTicketsTypeGridItemView(dataListBeen);
  }

}

class _LotteryTicketsTypeGridItemView extends BaseController<LotteryTicketsTypeGridItemView> {

  LotteryTypeDataListBeen  dataListBeen;


  _LotteryTicketsTypeGridItemView(this.dataListBeen);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _gameItem() ;
  }

  Widget _gameItem() {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          CommonView().commonLine_NoMarginChange(context,10),
          _gameTitle(),
          _gridList(),
        ],
      ),
    );
  }

  Widget _gameTitle() {

    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        width: 80.0,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new Stack(
          children: <Widget>[
            new Image.asset(ImageUtil.imgGameTitleIcon, width: 79.0, height: 28.0,),
            new Align(
              alignment: Alignment.center,
              child: new Text(
                dataListBeen.name,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _gridList() {

    return new Container(
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        padding: const EdgeInsets.all(0.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 0.85,
        children: _gridListItemView(),
        shrinkWrap: true,

      ),
    );
  }

  //操作 的 item
  Widget _gridClassificationItem(String icon, String title, int index, bool isNetUrl) {

    return new Container(
      color: Colors.white,
      height: 70.0,
      child: new GestureDetector(
        onTap: () {
          //点击 投注
          switch(index) {
            case Constant.GAME_NUM_11_CHOICE_5_GD:
              //广东11 选 5
              Navigator.pushNamed(context, RouteUtil.bettingController, arguments: {"ColorVarietyID": index});
              break;
            case Constant.GAME_NUM_VIETNAME_HANOI://越南 河内1分彩
            case Constant.GAME_NUM_VIETNAME_HANOI_6://河内1分彩
            case Constant.GAME_NUM_VIETNAME_HANOI_8://河内5分彩

              Navigator.pushNamed(context, RouteUtil.vietnamHanoiOneLotteryController, arguments: {"ColorVarietyID": index});
              break;
            case Constant.GAME_NUM_TENCENT:
            case Constant.GAME_NUM_5_TENCENT:
            case Constant.GAME_NUM_10_TENCENT:
              //腾讯分分彩
              Navigator.pushNamed(context, RouteUtil.tencentCentLotteryController, arguments: {"ColorVarietyID": index});
              break;
            case Constant.GAME_NUM_ODD_INTEREST:
            //case Constant.GAME_NUM_ODD_INTEREST_3:
            case Constant.GAME_NUM_ODD_INTEREST_4:
            case Constant.GAME_NUM_ODD_INTEREST_5:
            //奇趣一分彩
              Navigator.pushNamed(context, RouteUtil.oddInterestLotteryController, arguments: {"ColorVarietyID": index});
              break;
            case Constant.GAME_NUM_LUCKY_AIRSHIP_13:
              //幸运飞艇
              Navigator.pushNamed(context, RouteUtil.luckyAirshipLotteryController, arguments: {"ColorVarietyID": index});
              break;
            case -1:
              // 添加常玩彩种
              Navigator.pushNamed(context, RouteUtil.addGameController);
              break;
          }

        },
        child: isNetUrl ? _imgNet(icon, title) : _imgAsset(icon, title),
      ),
    );
  }

  Widget _imgNet(String icon, String title) {

    return new Column(
      children: <Widget>[

        new Image.network(icon, width: 50.0, height: 50.0,),
        SpaceViewUtil.pading_Top_10(),

        new Text(title,
          style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_888888)
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }

  Widget _imgAsset(String icon, String title) {
    return new Column(
      children: <Widget>[

        new Image.asset(icon, width: 50.0, height: 50.0,),
        SpaceViewUtil.pading_Top_10(),

        new Text(title,
          style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_888888)
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }

  List<Widget> _gridListItemView() {

    List<Widget> gridListItem = new List();
    var lottery = dataListBeen.lottery;
    if (lottery.length > 0) {
      for (int i = 0; i < lottery.length; i++) {
        var lotteryData = lottery[i];
        String img;
        bool isNet = false;
        /// -1 添加彩种
        if (TextUtil.isEmpty(lotteryData.image) || lotteryData.id == -1) {
          if (lotteryData.id == -1) {
            //常玩彩种
            img = ImageUtil.imgOftenPlayColorVariety;
          } else {
            img = ImageUtil.imgCpType("${lotteryData.id}");
          }

          isNet = false;
        } else {
          img = UrlUtil.BaseUrl + lotteryData.image;
          isNet = true;
        }
        gridListItem.add(_gridClassificationItem(
            img ,lotteryData.name, lotteryData.id, isNet));
      }
    }

    return gridListItem;
  }

}