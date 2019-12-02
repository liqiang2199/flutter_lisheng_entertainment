import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshTabController.dart';
import 'package:flutter_lisheng_entertainment/model/TabTitle.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

/// 个人投注记录
class BettingRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BettingRecordController();
  }

}

class _BettingRecordController extends BaseRefreshTabController<BettingRecordController, TabTitle> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    initTabPageController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.personalBettingRecord),
      body: new Column(
        children: <Widget>[
          _tabPage(),
          _screenFindAndAccount(),
          new Expanded(child: _pageView(),),
        ],
      ),
    );
  }

  initTabData() {
    tabList = [
      new TabTitle('全部状态', 10),
      new TabTitle('未开奖', 0),
      new TabTitle('已撤销', 1),
      new TabTitle('未中奖', 2),
      new TabTitle('已派奖', 3),
      new TabTitle('系统撤销', 4)
    ];
  }

  @override
  void onRefreshData() {

  }

  Widget _tabPage() {

    return TabBar(
      isScrollable: true,
      //是否可以滚动
      controller: mTabController,
      labelColor: Color(ColorUtil.butColor),
      indicatorColor: Color(ColorUtil.butColor),
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Color(ColorUtil.textColor_333333),
      labelStyle: TextStyle(fontSize: 16.0),
      tabs: tabList.map((item) {
        return Tab(
          text: item.title,
        );
      }).toList(),
    );
  }

  Widget _pageView() {

    return PageView.builder(
      itemCount: tabList.length,
      onPageChanged: (index) {
        if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
          onPageChange(index);
        }
      },
      controller: mPageController,
      itemBuilder: (BuildContext context, int index) {
        return smartRefreshBase(
          _listRecordItem(),
        );
      },
    );
  }

  /// 筛选 根据种类和账户
  Widget _screenFindAndAccount() {
    return new Container(
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          new Expanded(child: _findChoice()),
          new Expanded(child: _editAccount("请输入账户")),
          new Expanded(child: _butSearch(), flex: 0,),

        ],
      ),
    );
  }

  /// 账户 输入框
  Widget _editAccount(String hintText) {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0,),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 12, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 12.0, color: Color(ColorUtil.textColor_888888)),
              ),
              maxLines: 1,
            ),
          ),

        ],

      ),
    );
  }

  /// 选择彩种
  Widget _findChoice() {

    return new Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0,),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(

        children: <Widget>[

          new Expanded(
            child: new Text(
              "选择彩种",
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_888888),
              ),
              maxLines: 1,
            ),
          ),

          new Image.asset(ImageUtil.imgChoiceUp, width: 12.0, height: 12.0,),
          SpaceViewUtil.pading_Left(5.0),

        ],

      ),
    );
  }

  /// 搜索
  Widget _butSearch() {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        width: 67.0,
        height: 30.0  ,
        margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 15.0,),
        child: new RaisedButton(onPressed: (){
          //

        },color: Color(ColorUtil.butColor),
          child: new Text(StringUtil.searchButText
            , style: TextStyle(fontSize: 13.0,color: Color(ColorUtil.whiteColor)),),
          //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          shape: new RoundedRectangleBorder(side: new BorderSide(
            //设置 界面效果
            color: Color(ColorUtil.butColor),
            style: BorderStyle.none,

          ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  /// 个人投注信息 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,),
        child: Card(
          child: new GestureDetector(
            onTap: () {
              //个人投注记录
            },
            child: new Column(
              children: <Widget>[

                _recordTopView(),
                _recordBottom(),

              ],
            ),
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: items.length,
    );
  }

  Widget _recordTopView() {

    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        children: <Widget>[

          new Text(
            "jx5188",
            style: TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),

          new Expanded(
            child: new Align(
              alignment: Alignment.centerRight,
              child: new Text(
                "已派奖",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(ColorUtil.textColor_333333),
                ),
              ),
            ),
          ),

          Image.asset(ImageUtil.imgRightArrow, width: 16.0, height: 16.0,),

        ],
      ),
    );
  }

  Widget _recordBottom() {

    return new Offstage(
      /// 控制列表数据是否显示
      offstage: false,
      child: new GestureDetector(
        onTap: () {
          // 数据显示 投注记录详情
          Navigator.pushNamed(context, RouteUtil.bettingRecordDetailController);
        },
        child: new Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0,),
          child: new Column(
            children: <Widget>[
              CommonView().commonLine_NoMargin(),
              _recordBottomList("订单编号：", "11111"),
              _recordBottomList("彩种/玩法：", "11111"),
              _recordBottomList("期号：", "11111"),
              _recordBottomList("下单时间：", "11111"),
              _recordBottomList("注数/倍数：", "11111"),
              _recordBottomList("金额：", "11111"),
              _recordBottomList("奖金：", "11111"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recordBottomList(String name, String content) {

    return new Container(
      padding: EdgeInsets.only(top: 5.0),
      child: new Row(
        children: <Widget>[
          new Text(
            name,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

          SpaceViewUtil.pading_Left(5.0),

          new Text(
            content,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),

        ],
      ),
    );
  }

}