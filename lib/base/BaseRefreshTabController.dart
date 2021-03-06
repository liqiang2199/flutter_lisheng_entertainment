import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 公用的 Tab
abstract class BaseRefreshTabController<T extends StatefulWidget, B>
    extends BaseRefreshController<T> with SingleTickerProviderStateMixin {

  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  List<B> tabList;
  var currentPage = 0;
  var isPageCanChanged = true;

  /// 初始化 TabPageController
  initTabPageController() {
    mTabController = TabController(
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {//TabBar的监听
      if (!isUserTabPage()) {
        print(mTabController.index);
        changeTabIndex(mTabController.index);
      } else {
        if (mTabController.indexIsChanging) {//判断TabBar是否切换
          print(mTabController.index);
          changeTabIndex(mTabController.index);
          if (isUserTabPage()) {
            onPageChange(mTabController.index, p: mPageController);
          }
        }
      }

    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if(mPageController == null) {
      return;
    }
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      //等待pageview切换完毕,再释放pageivew监听
      await mPageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index);//切换Tabbar
    }
  }

  /// 是否使用了PageView
  bool isUserTabPage() {

    return true;
  }

  /// 改变tab 下标
  void changeTabIndex(int pos){}

  @override
  void dispose() {
    mTabController.dispose();
    super.dispose();

  }

}