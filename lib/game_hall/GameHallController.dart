
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/**
 * 游戏大厅
 */
class GameHallController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameHallController();
  }

}

class _GameHallController extends State<GameHallController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, "游戏大厅"),
      body: new Column(
        children: <Widget>[

        ],
      ),
    );
  }

  Widget _gameTitle() {

    return new Container(
      child: new Stack(
        children: <Widget>[
          new Image.asset(ImageUtil.imgGameTitleIcon, width: 79.0, height: 28.0,),
          new Text(
            "11选5",
          ),
        ],
      ),
    );

  }

  Widget _gridList() {

    return new Container(
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        //padding: const EdgeInsets.all(8.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 1.5,
        children: _gridListItemView(),
        shrinkWrap: true,

      ),
    );
  }

  //操作 的 item
  Widget _gridClassificationItem(String icon, String title, int index) {

    return new Container(
      height: 60.0,
      child: new GestureDetector(
        onTap: () {
          //点击个人中心

        },
        child: new Column(
          children: <Widget>[

            new Image.asset(icon, width: 40.0, height: 40.0,),
            SpaceViewUtil.pading_Top_10(),

            new Text(title,
              style: new TextStyle(
                  fontSize: 14.0,
                  color: Color(ColorUtil.textColor_888888)
              ),
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> _gridListItemView() {
    List<Widget> gridListItem = new List();
    gridListItem.add(_gridClassificationItem("11选5", ImageUtil.imgLotteryCenterCqSSC, 1));
    return gridListItem;
  }


}