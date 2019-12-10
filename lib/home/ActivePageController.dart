import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/home/net/ActivePageHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeService.dart';
import 'package:flutter_lisheng_entertainment/model/json/active_page/ActivePageDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/active_page/ActivePageListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 活动页面
class ActivePageController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivePageController();
  }

}

class _ActivePageController extends BaseRefreshController<ActivePageController> implements ActivePageHandler{

  List<ActivePageDataBeen> dataPage = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeService.instance.getActivityList(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.activePage),
      body: smartRefreshBase(ListView.builder(
        itemBuilder: (c, i) => Container(
          //height: 223.0,
          margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0,),
          child: Card(
            child: Center(child: _activePageItem(i)),
          ),
        ),
        //itemExtent: 200.0,
        itemCount: items.length,
      )),
    );
  }

  Widget _activePageItem(int index) {

    return new Column(
      children: <Widget>[
//        new Image.network(
//          UrlUtil.BaseUrl + dataPage[index].image,
//          height: 170.0,
//          width: ScreenUtil.getScreenW(context),
//          fit: BoxFit.fill,
//        ),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          child: FadeInImage.assetNetwork(
            height: 170.0,
            width: ScreenUtil.getScreenW(context),
            placeholder: ImageUtil.activePageBanner,
            image: UrlUtil.BaseUrl + dataPage[index].image,
            fit: BoxFit.fill,
          ),
        ),
        SpaceViewUtil.pading_Top_10(),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Align(
            alignment: Alignment.centerLeft,
            child: new Text(
              dataPage[index].title,
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

  @override
  void setActivePageListBeen(List<ActivePageDataBeen> data) {
    dataPage.clear();
    items.clear();
    dataPage = data;
    setState(() {
      items = dataPage;
    });
  }

}