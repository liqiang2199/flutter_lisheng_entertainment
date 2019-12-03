import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/view/ListStateItemView.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 线路选择
//class LineSwitchingDialog extends Dialog {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _LineSwitchin  gDialog();
//  }
//
//}

// ignore: must_be_immutable
class LineSwitchingDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        decoration: ShapeDecoration(
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      margin: EdgeInsets.all(15.0),
      child: new Stack(
        children: <Widget>[

          new Column(
            children: <Widget>[

              _title(),
              _currentLine(),
              _changeLine(),
              _listRecordItem (),
              _lineSet(),
              _lineStateSet(),

            ],
          ),

         new Container(
           child:  new Image.asset(ImageUtil.imgCloseDialog, width: 26, height: 26,),
         ),

        ],
      ),
    );
  }

  Widget _title() {

    return new Container(
      decoration: ShapeDecoration(
        color: Color(ColorUtil.butColor),
        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(
//            Radius.circular(8.0),
//          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
      ),
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
//      color: Color(ColorUtil.butColor),
      child: new Text(
        "线路选择",
        style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            decoration: TextDecoration.none
        ),
      ),
      alignment: Alignment.center,
    );
  }

  /// 当前线路
  Widget _currentLine() {

    return new Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
      color: Color(ColorUtil.whiteColor),
      child: new Text(
        "当前线路：",
        style: new TextStyle(
            fontSize: 14.0,
            color: Color(ColorUtil.textColor_333333),
            decoration: TextDecoration.none
        ),
      ),
      alignment: Alignment.center,
    );
  }

  Widget _changeLine() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Color(ColorUtil.whiteColor),
      child: new Text(
        "请选择需要切换的线路:",
        style: new TextStyle(
            fontSize: 14.0,
            color: Color(ColorUtil.textColor_333333),
            decoration: TextDecoration.none
        ),
        textAlign: TextAlign.left,
      ),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _lineSet() {

    return new Container(
      padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      color: Color(ColorUtil.whiteColor),
      child: new Text(
        "线路选择设置:",
        style: new TextStyle(
            fontSize: 14.0,
            color: Color(ColorUtil.textColor_333333),
            decoration: TextDecoration.none
        ),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  bool _lightsSuspension = false; //switch 开关亮起来
  bool _lights = false; //switch 开关亮起来

  Widget _lineStateSet() {

    return new Container(
      child: new Card(
        //z轴的高度，设置card的阴影
        elevation: 5.0,
        child: new Column(
          children: <Widget>[

            _autoLineChange("自动线路切换"),
            CommonView().commonLine(),
            _getSuspensionSwitchView("显示悬浮框（可在设置中修改）"),

          ],
        ),
      ),
    );
  }

  //自动线路切换
  _autoLineChange(String title) {

    return new ListStateItemView(
      title,
      isSwitch: true,
      isLeftIcon: false,
      isRightArrow: false,
      isCupertino: _lights,
      onChanged: (value){
        //value 是否开启
//        setState(() {
//          _lights = value;
//        });
      },
    );
  }

  //线路悬浮开关
  _getSuspensionSwitchView(String title) {

    return new ListStateItemView(
      title,
      isSwitch: true,
      isLeftIcon: false,
      isRightArrow: false,
      isCupertino: _lightsSuspension,
      onChanged: (value){
        //value 是否开启
//        setState(() {
//          _lightsSuspension = value;
//        });
      },
    );
  }

  Widget _listRecordItem () {

    return new Container(
      margin: EdgeInsets.all(15.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 2,
            //纵轴间距
            mainAxisSpacing: 5.0,
            //横轴间距
            //crossAxisSpacing: 0.0,
            //子组件宽高长度比例
            childAspectRatio: 2.94),
        itemBuilder: (c, i) => Container(
          child:new GestureDetector(
            onTap: () {
              //个人投注记录
            },
            child: new Column(
              children: <Widget>[
                _editAgentName("线路$i"),

              ],
            ),
          ),
        ),
        itemCount: 9,
      ),
    );
  }

  Widget _editAgentName(String hintText) {

    return new Container(
      height: 50.0,
      margin: EdgeInsets.only(left: 15.0, right: 5.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Align(
        alignment: Alignment.centerLeft,
        child: new Column(
          children: <Widget>[

            new Text(hintText,
              style: TextStyle(
                  fontSize: 12,
                  color: Color(ColorUtil.textColor_333333),
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),

            new Row(
              children: <Widget>[

                new Text(hintText,
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(ColorUtil.textColor_FF5B62)
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),

                new Text(hintText,
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(ColorUtil.textColor_FF8814),
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

}