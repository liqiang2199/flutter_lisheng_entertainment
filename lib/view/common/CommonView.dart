import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';

class CommonView {

  ///  1.0  分割线
  Widget commonLine(BuildContext context) {

    return commonLineChange(context,1.0);
  }

  Widget commonLineChange(BuildContext context,double h) {

    return new Container(
      width: ScreenUtil.getScreenW(context),
      height: h,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      color: Color(ColorUtil.lineColor),
    );
  }

  Widget commonLine_L_R_10(BuildContext context) {

    return new Container(
      width: ScreenUtil.getScreenW(context),
      height: 1.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Color(ColorUtil.lineColor),
    );
  }

  Widget commonLine_NoMargin(BuildContext context) {

    return commonLine_NoMarginChange(context,1.0);
  }

  Widget commonLine_NoMarginChange(BuildContext context,double h) {

    return new Container(
      width: ScreenUtil.getScreenW(context),
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

  /**
   * 圆形图片（头像）
   */
  Widget clipImg(String headImgUrl) {
    return new Container(
      child: ClipOval(
        child: Image.network(UrlUtil.BaseUrl + headImgUrl,
          width: 70.0,
          height: 70.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /**
   * 头像
   */
  Widget clipHeadImg() {
    return clipImg(SpUtil.getString(Constant.USER_HEAD_IMG));
  }

}