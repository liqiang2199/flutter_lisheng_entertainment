
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 购物车
 */
class GameShoppingCartController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameShoppingCartController();
  }

}

class _GameShoppingCartController extends BaseController<GameShoppingCartController> {

  String title;//购物车的标题

  @override
  Widget build(BuildContext context) {

    var arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      title = arguments;

    }

    return new Scaffold(
      appBar: CommonView().commonAppBar(context, "广东11选5"),
      body: new Column(
        children: <Widget>[

          new Expanded(child: _shopCartList(),),

          _widgetTrackingNumberBet()

        ],
      ),
    );
  }

  Widget _shopCartList() {

    return new ListView.builder(
      // ignore: missing_return
      itemBuilder: (BuildContext context, int index) {
        _shopCartItem();
      },
     itemCount: 5,
    );
  }

  /// 追号  投注
  Widget _widgetTrackingNumberBet() {

    return new Container(
      height: 60.0,
      padding: EdgeInsets.only(left: 10.0,bottom: 8.0),
      color: Color(ColorUtil.bgColor_DFDFDF),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          _operationButItem("追号", 67.0, 0),

          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new Text(
                  "共11111.000元",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Color(ColorUtil.textColor_FF8814),
                  ),
                ),

                new Text(
                  "198注 5倍",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Color(ColorUtil.textColor_FF8814),
                  ),
                )

              ],
            ),
          ),

          _operationButItem("确认投注", 87.0, 1),


        ],

      ),
    );
  }

  /**
   * ListView 的 item
   */
  Widget _shopCartItem() {

    return new Container(
      child: new Row(

        children: <Widget>[

          _itemText("01020301201", 0),
          _itemText("", 0),
          _itemText("", 0),
          _itemText("", 0),

          _itemDelete(),

        ],

      ),
    );
  }

  Widget _itemText(String content, int index) {

    return new Expanded(
      child: new Text(
        content,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
          fontSize: 12.0,
          color: index == 0 ? Color(ColorUtil.textColor_FF8814) : Color(ColorUtil.textColor_888888),
        ),
      ),
    );
  }

  Widget _itemDelete() {

    return new Container(
      child: new Image.asset(ImageUtil.imgShopCartDelete,width: 18.0, height: 18.0,),
    );
  }


  /// 按钮
  Widget _operationButItem(String butTitle, double w, int index) {
    return new Container(
      width: w,
      height: 30.0  ,
      margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 15.0,),
      child: new RaisedButton(onPressed: (){
        //
        switch(index) {
        }

      },color: Color(ColorUtil.butColor),
        child: new Text(butTitle
          , style: TextStyle(fontSize: 13.0,color: Color(ColorUtil.whiteColor)),),
        //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        shape: new RoundedRectangleBorder(side: new BorderSide(
          //设置 界面效果
          color: Color(ColorUtil.butColor),
          style: BorderStyle.none,

        ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

}