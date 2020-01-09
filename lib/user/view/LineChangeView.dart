
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/dialog/LineSwitchingDialog.dart';

class LineChangeView extends StatefulWidget {
  double topDistance = 0.0;
  double leftDistance = 0.0;

  LineChangeView(Key key, {this.topDistance, this.leftDistance}):super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LineChangeStateView(topDistance: topDistance, leftDistance: leftDistance,);
  }

}

class LineChangeStateView extends BaseController<LineChangeView> {

  /// 移动的坐标
  double topDistance = 0.0;
  double leftDistance = 0.0;
  LineChangeStateView({this.topDistance, this.leftDistance});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Positioned(
      top: topDistance,
      left: leftDistance,
      child: new GestureDetector(
        onTap: () {
          //线路切换
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => new LineSwitchingDialog()
          );
        },
        onPanUpdate:(DragUpdateDetails e) {

          setState(() {
            leftDistance += e.delta.dx;
            topDistance += e.delta.dy;
          });

        },
        child: new Align(
          alignment: Alignment.topRight,
          child: new Container(
            margin: EdgeInsets.only(top: 200.0),
            child: new Image.asset(ImageUtil.imgLoginChangeGroup, width: 61.0, height: 68.0, ),
          ),
        ),
      ),
    );
  }



}