import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 提款记录
class LinkManagerController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LinkManagerController();
  }

}

class _LinkManagerController extends BaseRefreshController<LinkManagerController> with SelectionTimeCallBack{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new Expanded(child: smartRefreshBase(
          _listRecordItem(),
        ),),

      ],
    );
  }

  @override
  void selectionEndStartTime() {
    // TODO: implement selectionEndStartTime
  }

  @override
  void selectionTimeStartTime() {
    // TODO: implement selectionTimeStartTime
  }


  /// 链接管理 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        color: Colors.white,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: new GestureDetector(
          onTap: () {
            //
          },
          child: new Column(
            children: <Widget>[
              buildItemWidget(context,i),

            ],
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: items.length,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      return new Column(
        children: <Widget>[

          _recordBottomList(),
          CommonView().commonLine_NoMargin(),

        ],
      );
    }
  }

  ///  记录列表
  Widget _recordTopView() {

    return new Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 15.0),
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(

                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "链接",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,

                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "复制",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "删除",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),


        ],
      ),
    );
  }


  Widget _recordBottomList() {

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  "http://shop.bytravel.cn/produce/index538.html",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.lineColor),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new GestureDetector(
              onTap: () {
                ClipboardData data = new ClipboardData(text:"http://shop.bytravel.cn/produce/index538.html");
                Clipboard.setData(data);
                //复制成功
                print("复制成功");
              },
              child: new Align(
                alignment: Alignment.center,
                child: new Container(
                  width: ScreenUtil.screenWidth,
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    "复制",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(ColorUtil.textColor_333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.lineColor),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 2,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.screenWidth,
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  "删除",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}