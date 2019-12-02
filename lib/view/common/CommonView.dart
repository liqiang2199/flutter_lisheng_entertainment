import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonView {

  ///  1.0  分割线
  Widget commonLine() {

    return commonLineChange(1.0);
  }

  Widget commonLineChange(double h) {

    return new Container(
      width: ScreenUtil.screenWidth,
      height: h,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      color: Color(ColorUtil.lineColor),
    );
  }

  Widget commonLine_L_R_10() {

    return new Container(
      width: ScreenUtil.screenWidth,
      height: 1.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Color(ColorUtil.lineColor),
    );
  }

  Widget commonLine_NoMargin() {

    return commonLine_NoMarginChange(1.0);
  }

  Widget commonLine_NoMarginChange(double h) {

    return new Container(
      width: ScreenUtil.screenWidth,
      height: h,
      color: Color(ColorUtil.lineColor),
    );
  }

  ///  返回 统一 AppBar （设置 ）
  AppBar commonAppBar(BuildContext context, String title) {

    return new AppBar(
      centerTitle: true,
      title: new Text(
        title,
        style: new TextStyle(
            fontSize: 16.0,
            color: Colors.white
        ),
      ),
      leading: new GestureDetector(
        child: new Align(
          child: new Image.asset(ImageUtil.imgBack, height: 20.0,),
        ),
        onTap: () {
          //点击返回
          Navigator.pop(context);
        },
      ),
    );
  }

}