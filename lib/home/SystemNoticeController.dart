import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeService.dart';
import 'package:flutter_lisheng_entertainment/home/net/SystemNoticeHandler.dart';
import 'package:flutter_lisheng_entertainment/model/json/system_notice/SystemNoticeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 公告页面
class SystemNoticeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SystemNoticeController();
  }

}

class _SystemNoticeController extends BaseRefreshController<SystemNoticeController> implements SystemNoticeHandler{

  List<SystemNoticeDataBeen> systemData = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeService.instance.getSystemNoticeList(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.systemNotice),
      body: smartRefreshBase(
          ListView.builder(
            itemBuilder: (c, i) => Container(
              //height: 223.0,
              margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,),
              child: Card(
                child: new GestureDetector(
                  onTap: () {
                    //公告详情
                    //Navigator.pushNamed(context, RouteUtil.systemNoticeDetailController);
                    Navigator.pushNamed(context, RouteUtil.systemNoticeDetailController, arguments: <String, String> {
                      "title" : systemData[i].title,
                      "content" : systemData[i].content,
                      "creatTime" : systemData[i].createtime,
                    });
                  },
                  child: Center(child: _activePageItem(i)),
                ),
              ),
            ),
            //itemExtent: 200.0,
            itemCount: items.length,
          ),
      ),
    );
  }

  Widget _activePageItem(int index) {

    return new Column(
      children: <Widget>[
        _noticeOne(systemData[index].title, systemData[index].createtime),
        _noticeTwo(systemData[index].content),
        CommonView().commonLine_L_R_10(context),
        _noticeLookDetail(),

      ],
    );
  }

  Widget _noticeOne(String title, String time) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0,),
      child: new Row(
        children: <Widget>[

          new Expanded(child: new Container(
            padding: EdgeInsets.only(right: 10.0),
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),),

          new Text(
            time,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

        ],
      ),
    );
  }

  Widget _noticeTwo(String content) {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 15.0,),
      child: new Align(
        child: new Text(
          content,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(ColorUtil.textColor_888888),
          ),
        ),
      ),
    );
  }

  Widget _noticeLookDetail() {

    return new Container(
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                "查看详情",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(ColorUtil.textColor_888888),
                ),
              ),
            ),
          ),),

          Image.asset(ImageUtil.imgRightArrow, width: 16.0, height: 16.0,),
          SpaceViewUtil.pading_Right_10(),

        ],
      ),
    );
  }

  @override
  void setSystemListData(List<SystemNoticeDataBeen> data) {
    systemData.clear();
    items.clear();
    systemData = data;
    setState(() {
      items = systemData;
    });
  }

}