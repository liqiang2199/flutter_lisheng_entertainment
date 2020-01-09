import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseRefreshController<T extends StatefulWidget> extends BaseController<T> {

  List items = new List();
  RefreshController refreshController = RefreshController(initialRefresh: true);

  int count = 0;//每个列表总数量
  int limit = 4;//每页20 条数据
  int page = 1;// 页数

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    onRefreshData();
    refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    onLoadingData();
  }

  /// 下拉数据更新
  void onRefreshData() {
    page = 1;
//    refreshController.footerMode = ValueNotifier(LoadStatus.idle);
//    refreshController.footerMode = ValueNotifier(LoadStatus.canLoading);

  }

  /// 上拉数据更新
  void onLoadingData() {

    if (count >= limit*page) {
      page ++;
//      refreshController.footerMode = ValueNotifier(LoadStatus.idle);
//      refreshController.footerMode = ValueNotifier(LoadStatus.canLoading);
      onLoadingDataRefresh();

      refreshController.loadComplete();
    } else {
      //大于当前列表总和
//      refreshController.footerMode = ValueNotifier(LoadStatus.idle);
//      refreshController.footerMode = ValueNotifier(LoadStatus.noMore);
      refreshController.loadNoData();
    }

    if (mounted) {
      setState(() {
        //onLoadingData();
      });
    }

  }

  void onLoadingDataRefresh(){}

  Widget smartRefreshBase(Widget child) {
    return new SmartRefresher(
      enablePullDown: isCanRefresh(),
      enablePullUp: isCanLoadMore(),
      header: ClassicHeader(),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowAlways,
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
          else if(mode == LoadStatus.noMore){
            body = Text("没有更多数据了!");
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
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: child,

    );
  }

  bool isCanRefresh() {

    return true;
  }

  bool isCanLoadMore() {
    return true;
  }
}