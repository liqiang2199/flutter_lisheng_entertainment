import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 活动页面
class SystemNoticeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SystemNoticeController();
  }

}

class _SystemNoticeController extends State<SystemNoticeController> {

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
      appBar: CommonView().commonAppBar(context, StringUtil.systemNotice),
      body: new SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("加载失败！点击重试！");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("松手,加载更多!");
            }
            else{
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Container(
            //height: 223.0,
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,),
            child: Card(
                child: new GestureDetector(
                  onTap: () {
                    //公告详情
                    Navigator.pushNamed(context, RouteUtil.systemNoticeDetailController);
                  },
                  child: Center(child: _activePageItem()),
                ),
            ),
          ),
          //itemExtent: 200.0,
          itemCount: items.length,
        ),

      ),
    );
  }

  Widget _activePageItem() {

    return new Column(
      children: <Widget>[
        _noticeOne(),
        _noticeTwo(),
        CommonView().commonLine_L_R_10(),
        _noticeLookDetail(),

      ],
    );
  }

  Widget _noticeOne() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0,),
      child: new Row(
        children: <Widget>[

          new Expanded(child: new Container(
            padding: EdgeInsets.only(right: 10.0),
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                "平台最新网址平台最新网址平台最新网址平台最新网址",
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
            "2019-09-09 23:01:06",
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

        ],
      ),
    );
  }

  Widget _noticeTwo() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 15.0,),
      child: new Align(
        child: new Text(
          "尊敬的会员您好！以下为平台最新登陆网址，请各位会员及时保存并更换，谢谢...",
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

}