
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';

class HomeControllerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeControllerView();
  }

}

class _HomeControllerView extends State<HomeControllerView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return new Scaffold(
      body: new SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: new Center(
          child: new Column(
            children: <Widget>[
              _topView(),
              _gridOperationClassification(),
              //new Expanded(child: _gridOperationClassification(),),
              _bannerHome(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _topView() {

    return new Container(
      height: 220.0,
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _topBgImg(),
          _topTitleAndSet(),
          _topUserInfoView(),
          _topButView(),

        ],
      ),
    );
  }

  /// 顶部背景图片
  Widget _topBgImg() {
    return Image.asset(ImageUtil.imgHomeTopBg,
      height: 220.0,
      repeat: ImageRepeat.repeat,
    );
  }

  Widget _topTitleAndSet() {

    return new Padding(
        padding: EdgeInsets.only(top: 40.0),
      child: new Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          _topTitle(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _topImgSet(),
              _topImgCustom(),

            ],
          )
        ],
      ),
    );
  }

  //标题
  Widget _topTitle() {

    return new Text(
      StringUtil.appName,
      style: new TextStyle(
        fontSize: 16.0,
        color: Color(ColorUtil.whiteColor),
      ),
    );
  }

  //设置按钮
  Widget _topImgSet() {

    return new Container(
      padding: EdgeInsets.only(right: 26.0),
      child: new GestureDetector(
        onTap: (){
          //点击设置
          Navigator.pushNamed(context, RouteUtil.setController);
        },
        child: Image.asset(ImageUtil.imgHomeSet, width: 22, height: 22,),
      ),
    );
  }

  //客服按钮
  Widget _topImgCustom() {

    return new Padding(padding: EdgeInsets.only(right: 15.0),
      child: Image.asset(ImageUtil.imgHomeCustom, width: 22, height: 22,),
    );
  }

  /// 头像 用户名 返点 余额
  Widget _topUserInfoView() {

    return new Padding(
      padding: EdgeInsets.only(top: 85.0, right: 15.0, left: 15.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          _topUserHeadImg(),
          SpaceViewUtil.pading_Left_10(),
          new Expanded(child: _topUserName(),),
          _topUserMoney(),

        ],
      ),
    );
  }

  //用户头像
  Widget _topUserHeadImg() {

    return new Image.asset(ImageUtil.imgHead, width: 70.0, height: 70.0,);
  }

  // 用户姓名
  Widget _topUserName() {

    return new Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SpaceViewUtil.pading_Top_10(),
        new Text(StringUtil.appName,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color(ColorUtil.whiteColor),
          ),
        ),

        SpaceViewUtil.pading_Top_10(),

        new Text(StringUtil.appName,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(ColorUtil.whiteColor),
          ),
        ),

      ],
    );
  }

  // 用户金额
  Widget _topUserMoney() {

    return new Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(right: 10.0,left: 10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.whiteColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          new Text(StringUtil.appName,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.whiteColor),
            ),
          ),


          new Text(StringUtil.appName,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.whiteColor),
            ),
          ),

        ],
      ),
    );
  }

  /// 顶部 按钮 充值 取款 转账
  Widget _topButView() {
    return new Padding(padding: EdgeInsets.only(top: 169.0,),
      child: new Row(
        children: <Widget>[
          _topBut(ImageUtil.imgRecharge, "充值", ColorUtil.butColor_FF9728, 1),
          _topBut(ImageUtil.imgWithdrawMoney, "取款", ColorUtil.butColor_EB303B, 2),
          _topBut(ImageUtil.imgTransferAccounts, "转账", ColorUtil.butColor_12B686, 3),
        ],
      ),
    );
  }

  //按钮 充值 取款 转账
  Widget _topBut(String iconImg, String butStr, int color, var type) {

    return new Expanded(
        child: new Container(
          height: 35.0,
          margin: EdgeInsets.only(left: 10.0,right: 10.0),
          child: new RaisedButton(onPressed: (){
            switch(type) {
              case 1:
                //充值
                Navigator.pushNamed(context, RouteUtil.rechargeController);
                break;
              case 2:
                //取款
                Navigator.pushNamed(context, RouteUtil.withdrawalController);
                break;
              case 3:
                //转账
                Navigator.pushNamed(context, RouteUtil.transferAccountsController);
                break;
            }
          },color: Color(color),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new Image.asset(iconImg, width: 20, height: 20,),
                SpaceViewUtil.pading_Left(5.0),
                new Text(butStr
                  , style: TextStyle(fontSize: 14.0,color: Color(ColorUtil.whiteColor)),),
              ],
            ),
            shape:new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
            ) ,
          ),
        ),
    );
  }


  List<String> classificationTitle = ["游戏大厅", "开奖中心", "个人中心", "代理中心", "活动", "公告"];
  List<String> classificationIcon = [ImageUtil.imgGame, ImageUtil.imgLotteryCenter
    , ImageUtil.imgUseCenter, ImageUtil.imgAgentCenter, ImageUtil.imgActivity, ImageUtil.imgMsg];

  /// 操作
  Widget _gridOperationClassification() {

    return _gridClassification();
  }

  Widget _gridClassification() {
    return  new Container(
      child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        //padding: const EdgeInsets.all(8.0),
        primary: false,
        mainAxisSpacing: 0.0,//竖向间距
        crossAxisSpacing: 0.0,//横向间距
        childAspectRatio: 1.5,
        children: _gridListItemView(),
        shrinkWrap: true,

      ),
    );
  }

//  Widget _gridClassification() {
//    return new GridView.builder(
//        itemCount: classificationTitle.length,
////        shrinkWrap: true,
//        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          //横轴元素个数
//            crossAxisCount: 3,
//            //纵轴间距
//            mainAxisSpacing: 0.0,
//          //宽高比
////          childAspectRatio: 1.4,
//            //横轴间距
//            crossAxisSpacing: 0.0,),
//        itemBuilder: (BuildContext context, int index) {
//          //Widget Function(BuildContext context, int index)
//          return _gridClassificationItem(classificationIcon[index], classificationTitle[index]);
//        });
//  }

  //操作 的 item
  Widget _gridClassificationItem(String icon, String title, int index) {

    return new Container(
      height: 60.0,
      child: new GestureDetector(
        onTap: () {
          //点击个人中心
          switch(index) {
            case 0:
              break;
            case 1:
              //开奖中心
              Navigator.pushNamed(context, RouteUtil.lotteryCenterController);
              break;
            case 2:
              //个人中心
              Navigator.pushNamed(context, RouteUtil.personalController);
              break;
            case 3:
              //代理中心
              Navigator.pushNamed(context, RouteUtil.agentCenterController);
              break;
            case 4:
              //活动中心
              Navigator.pushNamed(context, RouteUtil.activePageController);
              break;
            case 5:
              //公告
              Navigator.pushNamed(context, RouteUtil.systemNoticeController);
              break;
          }
        },
        child: new Column(
          children: <Widget>[

            new Image.asset(icon, width: 40.0, height: 40.0,),
            SpaceViewUtil.pading_Top_10(),

            new Text(title,
              style: new TextStyle(
                  fontSize: 14.0,
                  color: Color(ColorUtil.textColor_888888)
              ),
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> _gridListItemView() {
    List<Widget> gridListItem = new List();
    for (int i = 0; i<classificationTitle.length; i++) {
      gridListItem.add(_gridClassificationItem(classificationIcon[i], classificationTitle[i], i));
    }
    return gridListItem;
  }

  List<String> bannerList = [ImageUtil.imgBanner, ImageUtil.imgBanner, ImageUtil.imgBanner];

  /// Banner 广告位
  Widget _bannerHome() {
//    return BannerSwiper(
//
//      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
//      height: 108,
//      width: 54,
//      //轮播图数目 必传
//      length: bannerList.length,
////      normalWidget: ,//自定义 未选中指示器
////      selectorWidget: ,//自定义 选中指示器
//      //轮播的item  widget 必传
//      getwidget: (index) {
//        return new GestureDetector(
//            //child:  Image.network(bannerList[index % bannerList.length].img,fit: BoxFit.cover,),
//            child:  Image.asset(bannerList[index % bannerList.length],fit: BoxFit.fill,),
//            onTap: () {
//              //点击后todo
//            });
//      },
//    );
    return new SizedBox(
      height: 180.0,
      child: new Carousel(
        images: [

          new NetworkImage('http://img02.tooopen.com/images/20150928/tooopen_sy_143912755726.jpg'),
          new NetworkImage('http://img02.tooopen.com/images/20150928/tooopen_sy_143912755726.jpg'),
          new NetworkImage('http://img02.tooopen.com/images/20150928/tooopen_sy_143912755726.jpg'),

        ].map((netImage)=> new Image(
          image: netImage,fit: BoxFit.fitWidth,height: 180.0,width: ScreenUtil.screenWidth,
        )).toList(),

//        animationDuration: new Duration(
//          seconds: 5000,
//        ),
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.white,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        //borderRadius: true,
      ),
    );
  }

  

}