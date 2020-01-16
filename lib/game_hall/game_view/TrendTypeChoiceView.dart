
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/TrendTypeChoiceDataUtils.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/TrendTypeChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendTypeChoiceDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendTypeChoiceStateBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 走势类型选择 弹窗
 */
///
class TrendTypeChoiceView extends StatefulWidget {

  final String lotteryID;
  final String indexPage;
  final int trendTypeId;
  final TrendTypeChoiceInterface choiceInterface;

  const TrendTypeChoiceView(
      {Key key,
        this.lotteryID,
        this.choiceInterface,
        this.indexPage,
        this.trendTypeId
      }
        ) : super(key: key);



  @override
  State<StatefulWidget> createState() {

    return TrendTypeChoiceStateView(this.lotteryID, this.choiceInterface, this.indexPage, this.trendTypeId);
  }

}

class TrendTypeChoiceStateView extends BaseController<TrendTypeChoiceView> {

  Map<String, List<TrendTypeChoiceDataBeen>> mapTrendType = new Map();

  String lotteryID;
  TrendTypeChoiceInterface choiceInterface;
  String indexPage;
  int trendTypeId;

  TrendTypeChoiceStateView(this.lotteryID, this.choiceInterface, this.indexPage, this.trendTypeId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TrendTypeChoiceDataUtils.vietnamHanoiMapData(mapTrendType);
    mapTrendType?.forEach((modeK, modeV) {
      List<TrendTypeChoiceDataBeen> typeName = modeV;
      //bool isFlag = false;
      for (int i = 0; i < typeName.length; i++) {
        if ("${typeName[i].indexTrend}" == indexPage && typeName[i].type == trendTypeId) {
          typeName[i].isChoice = true;
          //isFlag = true;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Center(
      child: new Container(
        width: ScreenUtil.getScreenW(context) - 40,
        height: ScreenUtil.getScreenH(context) - 130 ,
        decoration: ShapeDecoration(
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        child: new Column(
          children: _itemModeList(context),
        ),
      ),
    );
  }



  List<Widget> _itemModeList(BuildContext context) {
    List<Widget> modeWidget = new List();
    mapTrendType?.forEach((modeK, modeV) {
      modeWidget.add(_playModeItem(context,modeK, modeV));

    });
    return modeWidget;
  }

  /**
   * 走势的选择列表
   */
  ///
  Widget _playModeItem(BuildContext context,String title, List<TrendTypeChoiceDataBeen> trendTypeBeen) {

    return new Column(
      children: <Widget>[

        new Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: new Row(
            children: <Widget>[

              new Container(
                child: new Text(
                  title,
                  style: TextStyle(
                    color: Color(ColorUtil.textColor_888888),
                    fontSize: 12.0,
                    decoration: TextDecoration.none
                  ),
                ),
                width: 55.0,
              ),

              new Expanded(
                child: _gridList(title,trendTypeBeen),
              ),
            ],
          ),
        ),
        SpaceViewUtil.pading_Top_10(),


      ],
    );
  }

  Widget _gridList(String typeNam, List<TrendTypeChoiceDataBeen> playModeBeen) {

    return new Container(
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        //padding: const EdgeInsets.all(8.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 1.9,
        children: _gridListItemView(typeNam, playModeBeen),
        shrinkWrap: true,

      ),
    );
  }

  List<Widget> _gridListItemView(String typeNam, List<TrendTypeChoiceDataBeen> typeName) {
    List<Widget> gridListItem = new List();

    for (int i = 0; i < typeName.length; i++) {
      gridListItem.add(_playTypeItem(typeName[i].trendStr,
          typeName[i].isChoice ? ColorUtil.textColor_FF8814 : ColorUtil.textColor_888888, typeName[i]));
    }
    return gridListItem;
  }

  // 走势 类型
  Widget _playTypeItem(String name, int colorId, TrendTypeChoiceDataBeen typeName) {
    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        height: 28.0  ,
        margin: EdgeInsets.only( right: 8.0,),
        child: new RaisedButton(onPressed: (){
          // 选中
          mapTrendType?.forEach((modeK, modeV) {
            List<TrendTypeChoiceDataBeen> typeName = modeV;

            for (int i = 0; i < typeName.length; i++) {
              typeName[i].isChoice = false;
            }

          });
          typeName.isChoice = true;
          if (choiceInterface != null) {
            TrendTypeChoiceStateBeen stateBeen = new TrendTypeChoiceStateBeen();
            stateBeen.isLineConnection = false;
            stateBeen.isSingleDouble = false;
            stateBeen.isFiveNum = false;
            stateBeen.isVariousSum = false;
            stateBeen.isVariousSpan = false;
            stateBeen.isDragonTiger = false;
            stateBeen.isMaxMin = false;
            stateBeen.dragonTigerPage = 1;
            stateBeen.indexPage = "0";
            stateBeen.trendTitleStr = typeName.trendTitleStr;
            stateBeen.trendTypeId = typeName.type;
            stateBeen.indexPage = "${typeName.indexTrend}";
            switch (typeName.type) {
              case 1:
                //单号走势
                stateBeen.isLineConnection = true;
                //stateBeen.indexPage = "${typeName.indexTrend}";
                break;
              case 2:
                //多号走势
                //stateBeen.indexPage = "${typeName.indexTrend}";
                break;
              case 3:
                //大小走势
                stateBeen.isMaxMin = true;
                //stateBeen.indexPage = "${typeName.indexTrend}";
                break;
              case 4:
                //单双走势
                stateBeen.isSingleDouble = true;
                //stateBeen.indexPage = "${typeName.indexTrend}";
                break;
              case 5:
                //五星和值走势
                stateBeen.isFiveNum = true;

                break;
              case 6:
                //各类和值走势
                stateBeen.isVariousSum = true;
                break;
              case 7:
                //各类跨度走势
                stateBeen.isVariousSpan = true;
                break;
              case 8:
                //龙虎和走势
                stateBeen.isDragonTiger = true;
                stateBeen.dragonTigerPage = typeName.indexTrend;
                break;
            }

            choiceInterface.setTrendTypeChoiceStateBeen(stateBeen);
          }

          Navigator.pop(context);
        },color: Color(ColorUtil.whiteColor),
          child: new Text(name
            , style: TextStyle(
                fontSize: 9.0,
                color: Color(colorId),
                decoration: TextDecoration.none
            ),
          ),
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(colorId),
            style: BorderStyle.solid,

          ),
            borderRadius: BorderRadius.circular(2.0),
          ),
          padding: EdgeInsets.only(left: 5.0, right: 5.0,),
        ),
      ),
    );
  }

}