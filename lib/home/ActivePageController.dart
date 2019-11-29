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
class ActivePageController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivePageController();
  }

}

class _ActivePageController extends State<ActivePageController> {

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
      appBar: CommonView().commonAppBar(context, StringUtil.activePage),
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
                child: Center(child: _activePageItem()),
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
        new Image.asset(
          ImageUtil.activePageBanner,
          height: 170.0,
          width: ScreenUtil.screenWidth,
          fit: BoxFit.fill,
        ),
        SpaceViewUtil.pading_Top_10(),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Align(
            alignment: Alignment.centerLeft,
            child: new Text(
              "玩家首次充值100以上 即可参与活动",
              style: TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ),
        ),
        SpaceViewUtil.pading_Bottom_10(),
      ],
    );
  }

}