import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgentService.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/link_list/LinkAccountListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/// 提款记录
class LinkManagerController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LinkManagerController();
  }

}

class _LinkManagerController extends BaseRefreshController<LinkManagerController> with SelectionTimeCallBack implements LinkManagerHandler{

  int _listIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AgentService.instance.getLinkAccountList(this);
  }

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

  }

  @override
  void selectionTimeStartTime() {

  }

  @override
  bool isCanLoadMore() {
    return false;
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

          _recordBottomList(linkListData[index], index),
          CommonView().commonLine_NoMargin(context),

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

                width: ScreenUtil.getScreenW(context),
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
                width: ScreenUtil.getScreenW(context),
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
                width: ScreenUtil.getScreenW(context),
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


  Widget _recordBottomList(LinkAccountListBeen listBeen, int index) {

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  listBeen.url,
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
                ClipboardData data = new ClipboardData(text: UrlUtil.BaseUrl + listBeen.url);
                Clipboard.setData(data);
                //复制成功
                showToast("复制成功");
              },
              child: new Align(
                alignment: Alignment.center,
                child: new Container(
                  width: ScreenUtil.getScreenW(context),
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
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new GestureDetector(
                  onTap: () {
                    //点击删除
                    _listIndex = index;
                    AgentService.instance.delLinkAccount(this, "${listBeen.id}");
                  },
                  child:  new Text(
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
          ),

        ],
      ),
    );
  }

  List<LinkAccountListBeen> linkListData = new List();

  @override
  void setLinkAccountList(List<LinkAccountListBeen> data) {
    LinkAccountListBeen listBeen = new LinkAccountListBeen(1, "", "", 1, "", "", "", "");
    linkListData.add(listBeen);
    linkListData.addAll(data);
    setState(() {
      items = linkListData;
    });
  }

  @override
  void setDelLinkAccount(bool result) {
    if (result) {
//      print("linkListData size 前 ${linkListData.length}");
      linkListData.removeAt(_listIndex);
//      print("linkListData size 中 ${linkListData.length}");
//      items.removeAt(_listIndex);
//      print("linkListData size 后 ${linkListData.length}");
      setState(() {
      });
    }
  }

}