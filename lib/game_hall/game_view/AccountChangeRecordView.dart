
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameService.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/AccountChangeRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/GameSelectionTimeAndAccountRecordView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/bridge/AccountChoiceInterface.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

/**
 * 账变记录
 */
///
class AccountChangeRecordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountChangeRecordView();
  }

}

class _AccountChangeRecordView extends BaseController<AccountChangeRecordView> implements SelectionTimeCallBack,AccountChangeRecordHandler,AccountChoiceInterface{

  List<String> listTitle = ["用户名","订单号","时间","操作类型","业务类型","变动金额","余额","备注",];

  List<AccountChangeRecordDataListBeen> recordListData = new List();

  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: false,
  );

  ScrollController scrollControllerHead = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: false,
  );

  double scrollY;

  String type = "0";
  String startTime = "0";
  String endTime = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    endTime = DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.YEAR_MONTH_DAY);
    GameService.instance.moneyLog(this, "0", 1, startTime, endTime);

    scrollControllerHead.addListener(() {
//      print("scrollControllerHead.offset = ${scrollControllerHead.offset}");
//      scrollY = scrollControllerHead.offset;
//      if (scrollController != null) {
//        scrollController.animateTo( scrollY ,
//            duration: Duration(milliseconds: 1),
//            curve: Curves.ease
//        );
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[

        new GameSelectionTimeAndAccountRecordView(this, choiceInterface: this,),
        new Expanded(child: _listViewWidgetV(), flex: 1,),
        new Expanded(child: _listBuilder(), flex: 11,),

      ],
    );
  }

  Widget _listViewWidgetV() {

    return new ListView(
      shrinkWrap: true,
      controller: scrollControllerHead,
      scrollDirection: Axis.horizontal,
      children: _listHeadItem(),
    );
  }

  /// 账变 头部
  List<Widget> _listHeadItem() {
    List<Widget> listW = new List();
    listTitle.forEach((value) {
      listW.add(_listItemTitle(value));

    });
    return listW;
  }

  Widget _listItemTitle(String title) {

    return new Container(
      height: 40.0,
      width: 90.0,
      alignment: Alignment.center,
      color: Color(ColorUtil.bgColor_F1F1F1),
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 12.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listBuilder() {

    return new ListView.builder(
        itemCount: recordListData.length,
        itemBuilder: (BuildContext context, int index) {

          ScrollController scrollController = ScrollController(
            initialScrollOffset: 0.0,
            keepScrollOffset: false,
          );

          scrollController.addListener(() {
            print("scrollController.offset = ${scrollController.offset}");
            scrollY = scrollController.offset;
            scrollControllerHead.animateTo( scrollY ,
                duration: Duration(milliseconds: 1),
                curve: Curves.ease
            );
          });

          return  new SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: new Row(
              children: _listContentItem(),
            ),
          );
        });
  }

  /// 账变 内容
  List<Widget> _listContentItem() {
    List<Widget> listW = new List();
    recordListData.forEach((accountData) {
      for (int i = 0; i < listTitle.length; i++) {
        switch (i) {
          case 0:
            //_listItemContent
            listW.add(_listItemContent(SpUtil.getString(Constant.USER_NAME)));
            break;
          case 1:
            listW.add(_listItemContent(accountData.relation));
            break;
          case 2:
            listW.add(_listItemContent(accountData.createtime));
            break;
          case 3:
            var type = accountData.type;
            var accountRecordData = AccountRecordPopData.getAccountRecordData();
            accountRecordData.forEach((acData) {
              if (acData.id == type) {
                listW.add(_listItemContent(acData.content));
              }
            });

            break;
          case 4:
            listW.add(_listItemContent(accountData.t));
            break;
          case 5:
            listW.add(_listItemContent(accountData.money));
            break;
          case 6:
            listW.add(_listItemContent(accountData.all_money));
            break;
          case 7:
            listW.add(_listItemContent(accountData.remark));
            break;
        }

      }

    });
    return listW;
  }

  Widget _listItemContent(String title) {

    return new Container(
      height: 40.0,
      width: 90.0,
      color: Colors.white,
      alignment: Alignment.center,
      child: new Text(
        title,
        style: new TextStyle(
          color: Color(ColorUtil.textColor_333333),
          fontSize: 12.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }



  @override
  void selectionEndTime(String endTime) {
    this.endTime = endTime;
    GameService.instance.moneyLog(this, type, 1, startTime, endTime);
  }

  @override
  void selectionStartTime(String starTime) {
    this.startTime = starTime;
  }

  @override
  void setAccountChangeRecord(AccountChangeRecordBeen changeRecordBeen) {
    recordListData = changeRecordBeen.data.data;
    setState(() {

    });
  }

  @override
  void accountStatusChoice(String statusId) {
    this.type = statusId;
  }

}