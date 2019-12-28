import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/// 无刷新头
abstract class BaseRefreshNoHeadController<T extends StatefulWidget> extends BaseController<T> {

  List items = new List();
  RefreshController refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
//    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
    onRefreshData();

  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if(mounted)
      setState(() {
        //onLoadingData();
      });
    refreshController.loadComplete();
  }

  /// 下拉数据更新
  void onRefreshData() {}

  /// 上拉数据更新
  void onLoadingData() {}

  Widget smartRefreshBase(Widget child) {
    return new SmartRefresher(
      enablePullDown: isCanRefresh(),
      enablePullUp: isCanLoadMore(),

      header:CustomHeader(
          builder:buildHeader,
          onOffsetChange:(offset){
          //do some ani
          }
    ),
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
//            height: 55.0,
            height: 5.0,
            child: Center(child:Text("")),
          );
        },
      ),
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: child,

    );
  }

  Widget buildHeader(BuildContext context,RefreshStatus mode){
    return Center(
        child:Text("")
    );
//    return Center(
//        child:Text(mode==RefreshStatus.idle?"下拉刷新":mode==RefreshStatus.refreshing?"刷新中...":
//        mode==RefreshStatus.canRefresh?"可以松手了!":mode==RefreshStatus.completed?"刷新成功!":"刷新失败")
//    );
  }

  bool isCanRefresh() {

    return true;
  }

  bool isCanLoadMore() {
    return true;
  }
}