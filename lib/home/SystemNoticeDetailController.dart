import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 活动页面
class SystemNoticeDetailController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SystemNoticeDetailController();
  }

}

class _SystemNoticeDetailController extends State<SystemNoticeDetailController> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Map args = ModalRoute.of(context).settings.arguments;
    print("arg= $args");
    String title = "";
    String time = "";
    String content = "";
    if (args.containsKey("title")) {

      args.forEach((k,v){
        if (k.toString() == "title") {
          title = v as String;
        }
        if (k.toString() == "content") {
          content = v as String;
        }
        if (k.toString() == "creatTime") {
          time = v as String;
        }
      });
    }

    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.systemNoticeDetail),
      body: new ListView(
        children: <Widget>[
          _activePageItem(title, content, time),
        ],
      ),
    );
  }

  Widget _activePageItem(String title, String content, String time) {

    return new Column(
      children: <Widget>[
        _noticeOne(title, time),
        _noticeContent(content),

      ],
    );
  }

  Widget _noticeOne(String title, String time) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0,),
      child: new Column(
        children: <Widget>[

          new Container(
            padding: EdgeInsets.only(right: 10.0),
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
              ),
            ),
          ),

          new Container(
            padding: EdgeInsets.only(top: 13.0,),
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                time,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(ColorUtil.textColor_888888),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _noticeContent(String content) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 15.0,),
      child: new Align(
        child: new Text(
          content,
          style: TextStyle(
            fontSize: 14.0,
            color: Color(ColorUtil.textColor_333333),
          ),
        ),
      ),
    );
  }

}