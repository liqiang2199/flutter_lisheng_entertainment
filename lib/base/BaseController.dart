import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/bridge/ToastUtilBridge.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseController<T extends StatefulWidget> extends State<T> with ToastUtilBridge {

//  /**
//   * 弹窗提示
//   */
//  showToast(String msg) {
//    if (TextUtil.isEmpty(msg)) {
//      return;
//    }
//    Fluttertoast.showToast(
//        msg: msg,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.black54,
//        textColor: Colors.white,
//        fontSize: 14.0
//    );
//
//  }


}