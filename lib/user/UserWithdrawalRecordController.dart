import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/user_record/UserWithdrawRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/user_record/UserWithdrawRecordDataListBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/sreen_view/SelectionTimeView.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SelectionTimeCallBack.dart';

import 'net/UserWithdrawRecordHandler.dart';


/// 提款记录
class UserWithdrawalRecordController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserWithdrawalRecordController();
  }

}

class _UserWithdrawalRecordController extends BaseRefreshController<UserWithdrawalRecordController> with SelectionTimeCallBack implements UserWithdrawRecordHandler{

  String _startTime;
  String _endTime;
  int _page= 1;

  List<UserWithdrawRecordDataListBeen> dataUserWithdrawRecord = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserService.instance.withdraw(this, "0", _startTime, _endTime);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new  Scaffold(
      appBar: CommonView().commonAppBar(context, StringUtil.agentWithdrawalRecord),
      body: new Column(
        children: <Widget>[

          SelectionTimeView(this),
          new Expanded(child: smartRefreshBase(
            _listRecordItem(),
          ),),

        ],
      ),
    );
  }

  @override
  void onRefreshData() {

    _page = 1;
    UserService.instance.withdraw(this, "0", _startTime, _endTime);
  }

  /// 个人投注信息 列表
  Widget _listRecordItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        color: Colors.white,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: new GestureDetector(
          onTap: () {
            //
          },
          child: new Column(
            children: <Widget>[
              buildItemWidget(context,i),

            ],
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: dataUserWithdrawRecord.length,
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index == 0) {
      return _recordTopView();
    } else {
      return new Column(
        children: <Widget>[

          _recordBottomList(dataUserWithdrawRecord[index]),
          CommonView().commonLine_NoMargin(context),

        ],
      );
    }
  }

  ///  记录列表
  Widget _recordTopView() {

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(

                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "提款时间",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,

                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.bgColor_DFDFDF),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 4,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "金额（元）",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.whiteColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Color(ColorUtil.butColor),
              ),
            ),
          ),


        ],
      ),
    );
  }


  Widget _recordBottomList(UserWithdrawRecordDataListBeen dataListBeen) {

    return new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            flex: 6,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  dataListBeen.createtime,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          new Expanded(child: new Container(color: Color(ColorUtil.lineColor),
            width: 1.0, height: 50.0,), flex: 0,),

          new Expanded(
            flex: 4,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                width: ScreenUtil.getScreenW(context),
                padding: EdgeInsets.all(5.0),
                child: new Text(
                  dataListBeen.money,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(ColorUtil.textColor_333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void selectionEndTime(String endTime) {
    _endTime = endTime;
    onRefreshData();
  }

  @override
  void selectionStartTime(String starTime) {
    _startTime = starTime;
  }

  @override
  void setUserWithdrawRecordBeen(UserWithdrawRecordBeen dataBeen) {
    dataUserWithdrawRecord.clear();
    dataUserWithdrawRecord.addAll(dataBeen.data.data);

    setState(() {

    });
  }


}