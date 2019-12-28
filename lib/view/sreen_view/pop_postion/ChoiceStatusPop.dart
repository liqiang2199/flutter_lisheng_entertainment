/**
 * 选择状态
 */
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:popup_windows/popup_windows.dart';

import '../../PopupWindowButton.dart';

///
class ChoiceStatusPop {

//  Widget popWindowChoiceStatus() {
//
//    return Container(
//      alignment: Alignment.topLeft,
//      child:  PopupWindowButton(
//        offset: Offset(0, 20),
//        child: Image(image: AssetImage(ImageUtil.imgGame)),
//        window: Container(
//          padding: EdgeInsets.all(50),
//          alignment: Alignment.center,
//          color: Colors.greenAccent,
//          height: 200,
//          child: Container(
//            color: Colors.white,
//            height: 50,
//          ),
//        ),
//      ),
//    );
//  }

  Widget popWindowChoiceStatus() {

    return Container(
      alignment: Alignment.topLeft,
      child:  PopupWindowWidget(
        //offset: Offset(40.0, 0.0),
        intelligentConversion: true,
        direction: Direction.Top,
        child: Container(
          color: Colors.deepOrange,
          padding: EdgeInsets.all(20.0),
          //margin: EdgeInsets.only(left: 40.0),
          child: Text(
            'left',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
        showChild: Container(
          height: 200.0,
          alignment: Alignment.bottomCenter,
          color: Colors.blueAccent,
          child: Container(
            height: 100.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

}