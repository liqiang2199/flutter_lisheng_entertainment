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

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.systemNoticeDetail),
      body: new ListView(
        children: <Widget>[
          _activePageItem(),
        ],
      ),
    );
  }

  Widget _activePageItem() {

    return new Column(
      children: <Widget>[
        _noticeOne(),
        _noticeContent(),

      ],
    );
  }

  Widget _noticeOne() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0,),
      child: new Column(
        children: <Widget>[

          new Container(
            padding: EdgeInsets.only(right: 10.0),
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                "平台最新网址平台最新网址平台最新网址平台最新网址",
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
                "2019-09-09 23:01:06",
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

  Widget _noticeContent() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 15.0,),
      child: new Align(
        child: new Text(
          "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢..."
              "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...",
          style: TextStyle(
            fontSize: 14.0,
            color: Color(ColorUtil.textColor_333333),
          ),
        ),
      ),
    );
  }

}