
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/EventBusUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameHallHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/bus/AddLotteryListBusBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataListLotteryBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 添加常玩彩种
 */
///
class AddGameController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddGameController();
  }

}

class _AddGameController extends BaseController<AddGameController> implements GameHallHandler{

  List<LotteryTypeDataListLotteryBeen> lotteryList = new List();
  /// 添加的彩种列表
  List<LotteryTypeDataListLotteryBeen> addLotteryList = new List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GameService.instance.lotteryList(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, "添加彩种"),
      body: new ListView.builder(
          itemBuilder: (context,i) {
            return new GestureDetector(
              onTap: () {

                lotteryList[i].isChoice = !lotteryList[i].isChoice;

                if (addLotteryList.contains(lotteryList[i])) {
                  if (!lotteryList[i].isChoice) {
                    addLotteryList.remove(lotteryList[i]);
                  }
                } else {
                  addLotteryList.add(lotteryList[i]);
                }
                setState(() {

                });
              },
              child: _itemView(lotteryList[i].image,lotteryList[i].name, lotteryList[i].isChoice),
            );
          },
        itemCount: lotteryList.length,
      ),
    );
  }

  Widget _itemView(String imageUrl,String title, bool isVisibility) {

    Widget imgWidger = _isEmptyUrl(imageUrl);

    return new Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
      height: 51.0,
      child: new Column(
        children: <Widget>[

          new Expanded(
              child: new Row(
                children: <Widget>[

                  imgWidger,

                  new Expanded(
                    child: new Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(ColorUtil.textColor_333333),
                      ),
                    ),
                  ),

                  new Visibility(
                    visible: isVisibility,
                    child: new Image.asset(ImageUtil.imgAddCpChoice, width: 20.0, height: 20.0,),
                  ),

                ],
              ),
          ),
          SpaceViewUtil.pading_Top_10(),
          CommonView().commonLine_NoMarginChange(context, 1.0),

        ],
      ),
    );
  }

  /**
   * 如果网络上图片不正确就显示 本地
   */
  ///
  Widget _isEmptyUrl(String imgUrl) {

    if (TextUtil.isEmpty(imgUrl)) {
      return new Image.asset(ImageUtil.imgLotteryCenterCqSSC, height: 60.0, width: 60.0,);
    }
    return new Image.network(UrlUtil.BaseUrl + imgUrl, height: 60.0, width: 60.0,);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    eventBus.fire(AddLotteryListBusBeen(addLotteryList));
    super.dispose();


  }

  @override
  void setLotteryTypeData(LotteryTypeDataBeen dataBeen) {
    lotteryList?.clear();

    var data = dataBeen?.data;
    data?.forEach((typeListBeen) {
      var lottery = typeListBeen?.lottery;
      lottery?.forEach((lotteryListBeen) {
        lotteryListBeen.isChoice = false;
        lotteryList.add(lotteryListBeen);
      });

    });

    setState(() {

    });
  }

}