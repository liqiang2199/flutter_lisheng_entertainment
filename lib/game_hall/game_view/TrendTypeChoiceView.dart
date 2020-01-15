
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/TrendTypeChoiceDataUtils.dart';
import 'package:flutter_lisheng_entertainment/model/been/TrendTypeChoiceDataBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 走势类型选择 弹窗
 */
///
class TrendTypeChoiceView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return TrendTypeChoiceStateView();
  }

}

class TrendTypeChoiceStateView extends BaseController<TrendTypeChoiceView> {

  Map<String, List<TrendTypeChoiceDataBeen>> mapTrendType = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TrendTypeChoiceDataUtils.vietnamHanoiMapData(mapTrendType);
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
//      if (playModeBeen[i].isChoice == null) {
//        playModeBeen[i].isChoice = false;
//      }
      gridListItem.add(_playTypeItem(typeName[i].trendStr,
          typeName[i].isChoice ? ColorUtil.textColor_FF8814 : ColorUtil.textColor_888888));
    }
    return gridListItem;
  }

  // 走势 类型
  Widget _playTypeItem(String name, int colorId) {
    return new Align(
      alignment: Alignment.centerLeft,
      child: new Container(
        height: 28.0  ,
        margin: EdgeInsets.only( right: 8.0,),
        child: new RaisedButton(onPressed: (){
          // 选中

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