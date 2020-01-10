
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';

class LoadingDialog extends Dialog {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              )
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                CircularProgressIndicator(
                  backgroundColor: Color(ColorUtil.bgColor_F1F1F1),
                ),

                SpaceViewUtil.pading_Top_10(),

                Text(
                    "加载中",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}