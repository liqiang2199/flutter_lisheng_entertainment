import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/recharge/RechargeTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserService.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_picker/Picker.dart';

import 'net/RechargeHandler.dart';

/// 充值界面
class RechargeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RechargeController();
  }

}

class _RechargeController extends BaseController<RechargeController> implements RechargeHandler{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    UserService.instance.getPaytypeList(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
      appBar: CommonView().commonAppBar(context, StringUtil.rechargeTitle),
      body: new Column(
        children: <Widget>[
          
          _changeRechargeType("请选择支付方式"),
          CommonView().commonLine(context),
          _rechargeEditMoney(StringUtil.rechargeMoneyHint),
          CommonView().commonLine(context),
          _rechargeTipText(),
          _butSubmitRecharge(),

        ],
      ),
    );
  }

  /// 选择充值类型
  Widget _changeRechargeType(String hintText) {

    return new Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 53.0,
      child: new GestureDetector(
      onTap: () {
        //选择方式
        UserService.instance.getPaytypeList(this);
      },
        child: new Row(
          children: <Widget>[

            new Text(
              StringUtil.rechargeType,
              style: new TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_888888),
              ),
            ),

            SpaceViewUtil.pading_Left(10.0),
            new Expanded(
                child: new Text(
                  hintText,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color(ColorUtil.textColor_333333)
                  ),
                )
            ),
            SpaceViewUtil.pading_Right_10(),
            new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),

          ],
        ),
      ),
    );
  }

  /// 充值金额
  Widget _rechargeEditMoney(String hintText) {

    return new Container(
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      height: 53.0,
      child: new Row(
        children: <Widget>[

          new Text(
            StringUtil.rechargeMoney,
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_888888)),
              ),
            ),
          ),

        ],
      ),
    );
  }

  /// 充值金额提示
  Widget _rechargeTipText() {
    
    return new Container(
      width: ScreenUtil.getScreenW(context),
      padding: EdgeInsets.only(left: 15.0,top: 15.0),
      child: new Text(
        "充值金额最少为100元",
        style: new TextStyle(
          fontSize: 12.0,
          color: Color(ColorUtil.textColor_333333),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  /// 提交充值
  Widget _butSubmitRecharge() {
    return new Container(
      width: 300.0,
      height: 45.0  ,
      margin: EdgeInsets.only(top: 35.0),
      child: new RaisedButton(onPressed: (){
        //退出登录

      },color: Color(ColorUtil.butColor),
        child: new Text(StringUtil.rechargeSubmit
          , style: TextStyle(fontSize: 16.0,color: Color(ColorUtil.whiteColor)),),
        //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        shape: new StadiumBorder(side: new BorderSide(
          //设置 界面效果
          color: Color(ColorUtil.butColor),
          style: BorderStyle.none,
        ),),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 选择支付方式
  showPickerIcons(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(data: pickerItemList),
      selectedTextStyle: TextStyle(color: Color(ColorUtil.textColor_333333)),
      textStyle: new TextStyle(
        fontSize: 14.0,
        color: Color(ColorUtil.textColor_333333),
      ),
      cancelText: "取消",
      cancelTextStyle: new TextStyle(
        fontSize: 16.0,
        color: Color(ColorUtil.textColor_333333),
      ),
      confirmText: "确定",
      confirmTextStyle: new TextStyle(
        fontSize: 16.0,
        color: Color(ColorUtil.textColor_333333),
      ),
      backgroundColor: Color(ColorUtil.lineColor),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
      },
//    ).show(_scaffoldKey.currentState);
    ).showModal(context);
//    ).showDialog(context);
  }

  List<PickerItem> pickerItemList = new List();

  @override
  void setRechargeTypeList(RechargeTypeListBeen data) {
    pickerItemList.clear();
    if (data.data != null && data.data.length > 0) {
      data.data.forEach((rechargeTypeData) {
        pickerItemList.add( PickerItem(text: new Text(rechargeTypeData.name, style: new TextStyle(fontSize: 16.0),), value: rechargeTypeData.id));
      });
    }
    showPickerIcons(context);
  }

}