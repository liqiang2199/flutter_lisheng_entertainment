
import 'dart:math';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/EventBusUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/page_view/LotteryTicketsTypeGridItemView.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeService.dart';
import 'package:flutter_lisheng_entertainment/model/bus/AddLotteryListBusBeen.dart';
import 'package:flutter_lisheng_entertainment/model/bus/LoginOutBusBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataListLotteryBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/home_json/GetBannerListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginUserInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

class HomeControllerView extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeControllerView();
  }

}

class _HomeControllerView extends BaseController<HomeControllerView> implements HomeHandler{

  LoginUserInfoBeen userInfoBeen;
  LotteryTypeDataListBeen typeDataListBeen;

  @override
  void initState() {
    super.initState();
    /// 获取banner
//    HomeService.instance.getBannerList(SpUtil.getString(Constant.TOKEN), this);

    List<LotteryTypeDataListLotteryBeen> lottery = new List();
    typeDataListBeen = new LotteryTypeDataListBeen(9, "常玩彩种",lottery);
    typeDataListBeen.id = 9;
    typeDataListBeen.name = "常玩彩种";
    typeDataListBeen.lottery = lottery;
    /// 读取保存 的顶部内容
    List<Map<dynamic, dynamic>> lotteryTypeList = SpUtil.getObjectList("LotteryTypeList");
    if(lotteryTypeList != null && lotteryTypeList.length > 0) {
      lotteryTypeList.forEach((beenValue){
        var listLotteryBeen = LotteryTypeDataListLotteryBeen.fromJson(beenValue);
        lottery.add(listLotteryBeen);
      });
    } else {
      _addNormolCp(lottery);
    }

    /// 响应 EventBus
    eventBus.on<AddLotteryListBusBeen>().listen((event) {

      if (event != null && event.addLotteryList.length > 0) {

        List<LotteryTypeDataListLotteryBeen> lotteryNew = new List();



        event.addLotteryList?.forEach((lotteryBeen){
          bool isAddLotteryList = true;
          typeDataListBeen.lottery?.forEach((typeListBeen){
            if(lotteryBeen.id == typeListBeen.id) {
              isAddLotteryList = false;
            }
          });
          if (isAddLotteryList) {
            lotteryNew.add(lotteryBeen);
          }

        });

        typeDataListBeen.lottery.insertAll(0, lotteryNew);

//        typeDataListBeen.lottery?.forEach((lotteryJson){
//          print("String lotteryList =${lotteryJson.toJson()}");
//        });
        SpUtil.putObjectList("LotteryTypeList", typeDataListBeen.lottery);
      }
      if(event != null && event.addLotteryList.length > 0) {
        setState(() {

        });
      }

    });

    /// 退出登录时退出首页
    eventBus.on<LoginOutBusBeen>().listen((event){
      if (event != null && event.isLoginOut) {
        Navigator.pop(context);
      }
    });

  }

  _addNormolCp(List<LotteryTypeDataListLotteryBeen> lottery) {
    //广东11选5
    LotteryTypeDataListLotteryBeen typeDataListLotteryBeen = new LotteryTypeDataListLotteryBeen
      (9,"11选5","");
    //imgOftenPlayColorVariety
    LotteryTypeDataListLotteryBeen oftenPlayColor = new LotteryTypeDataListLotteryBeen
      (-1,"","");
    lottery.add(typeDataListLotteryBeen);
    lottery.add(oftenPlayColor);
    /// 保存数据
//    StringBuffer stringBuffer = new StringBuffer();
//    lottery?.forEach((lotteryJson){
//
//    });
    SpUtil.putObjectList("LotteryTypeList", lottery);

  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Map args = ModalRoute.of(context).settings.arguments;
    print("arg= $args");
    if (args.containsKey(Constant.INTENT_VALUE_USER_INFO)) {

      args.forEach((k,v){
        if (k.toString() == Constant.INTENT_VALUE_USER_INFO) {
          userInfoBeen = v as LoginUserInfoBeen;
        }

      });
    }

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

              LotteryTicketsTypeGridItemView(typeDataListBeen),

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
//        alignment: AlignmentDirectional.center,
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

    return new Align(
      alignment: Alignment.topCenter,
      child: new Text(
        StringUtil.appName,
        style: new TextStyle(
          fontSize: 18.0,
          color: Color(ColorUtil.whiteColor),
        ),
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
    //ImageUtil.imgHead
    return CommonView().clipHeadImg();
//    return new Image.network(UrlUtil.BaseUrl + userInfoBeen.avatar, width: 70.0, height: 70.0,);
  }

  // 用户姓名
  Widget _topUserName() {

    return new Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SpaceViewUtil.pading_Top_10(),
        new Text(userInfoBeen.account,
          style: const TextStyle(
            fontSize: 16.0,
            color: Color(ColorUtil.whiteColor),
          ),
        ),

        SpaceViewUtil.pading_Top_10(),

        new Text("返点：${userInfoBeen.ratio}",
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

          new Text("￥${userInfoBeen.all_money}",
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(ColorUtil.whiteColor),
            ),
          ),


          new Text(StringUtil.all_money,
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


  //操作 的 item
  Widget _gridClassificationItem(String icon, String title, int index) {

    return new Container(
      height: 60.0,
      child: new GestureDetector(
        onTap: () {
          //点击个人中心
          switch(index) {
            case 0:
              //游戏大厅
              Navigator.pushNamed(context, RouteUtil.gameHallController);
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
  /// /**
  //_getImageList(imgListStr)
  Widget _bannerHome() {
    return new SizedBox(
      height: 180.0,
      child: new Carousel(
        images: [
          new NetworkImage('http://img02.tooopen.com/images/20150928/tooopen_sy_143912755726.jpg'),
          new NetworkImage('http://img02.tooopen.com/images/20150928/tooopen_sy_143912755726.jpg'),
          new NetworkImage('http://img02.tooopen.com/images/20150928/tooopen_sy_143912755726.jpg'),
        ].map((netImage)=> new Image(
          image: netImage,fit: BoxFit.fitWidth,height: 180.0,width: ScreenUtil.getScreenW(context),
        )).toList(),

        animationDuration: new Duration(
          seconds: 5000,
        ),
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.white,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        //borderRadius: true,
      ),
    );
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

//    return new FutureBuilder(
//      future: HomeService.instance.getBannerList(SpUtil.getString(Constant.TOKEN), this),
//        // ignore: missing_return
//        builder:   (BuildContext context, AsyncSnapshot<List> snapshot){
//          switch (snapshot.connectionState) {
//            case ConnectionState.none:
//              return new Text('Input a URL to start');
//            case ConnectionState.waiting:
//              return new Center(child: new CircularProgressIndicator());
//            case ConnectionState.active:
//              return new Text('');
//            case ConnectionState.done:
//              if (snapshot.hasError) {
////                return new Text(
////                  '${snapshot.error}',
////                  style: TextStyle(color: Colors.red),
////                );
//              } else {
//                return _initBanner();
//              }
//          }
//        }
//    );
  }

  Widget _initBanner() {
    return new SizedBox(
      height: 180.0,
      child: new Carousel(
        images: _getImageList(imgListStr).map((netImage)=> new Image(
          image: netImage,fit: BoxFit.fitWidth,height: 180.0,width: ScreenUtil.getScreenW(context),
        )).toList(),

        animationDuration: new Duration(
          seconds: 5000,
        ),
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.white,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        //borderRadius: true,
      ),
    );
  }

  List imgList = new List();
  List _getImageList( List<String> imgListStr) {

    for (int i = 0; i < imgListStr.length; i++) {
      imgList.add(new NetworkImage(imgListStr[i]));
    }
    return imgList;
  }

  /// 图片路径
  List<String> imgListStr = new List();
  @override
  void getBannerListBeen(GetBannerListDataBeen bannerListDataBeen) {
    var dataList = bannerListDataBeen.data;

    dataList.forEach((dataBeen) {
      imgListStr.add(UrlUtil.BaseUrl+dataBeen.image);
    });


  }

}