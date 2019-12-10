import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseRefreshController.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';

///代理分红
class AgencyBonusController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AgencyBonusController();
  }

}

class _AgencyBonusController extends BaseRefreshController<AgencyBonusController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: CommonView().commonAppBar(context, "代理分红"),
      body: new Container(
        child: smartRefreshBase(_listBankItem()),

      ),
    );
  }

  @override
  bool isCanRefresh() {
    return false;
  }

  Widget _listBankItem () {

    return ListView.builder(
      itemBuilder: (c, i) => Container(
        //height: 223.0,
        child: new GestureDetector(
          onTap: () {
            //
          },
          child: new Column(
            children: <Widget>[
              _listBankAllView(i),
            ],
          ),
        ),
      ),
      //itemExtent: 200.0,
      itemCount: items.length,
    );
  }

  Widget _listBankAllView(int index) {
    if (index == 0) {
      return _agentBonusRule();
    } else if (index == 1) {
      return new Container(

        child: new Column(
          children: <Widget>[
            _typeTitle("我的分红"),
            _meAgencyBouns(),
            CommonView().commonLine_NoMarginChange(context,10.0),
            _typeTitle("历史分红"),
          ],
        ),
      );
    } else {
      return _agencyBonusList();
    }
  }

  /// 类型标题
  Widget _typeTitle(var title) {

    return new Container(
      height: 40.0,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Row(
        children: <Widget>[
          new Container(
            color: Color(ColorUtil.butColor),
            height: 15.0,
            width: 2.0,
          ),
          SpaceViewUtil.pading_Left(10.0),
          new Text(
            title,
            style: new TextStyle(
              color: Color(ColorUtil.butColor),
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  /// 代理分红规则
  Widget _agentBonusRuleContent(String ruleTitle) {

    return new Container(
      padding: EdgeInsets.only(bottom: 20.0),
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Text(
        ruleTitle,
        style: new TextStyle(
          fontSize: 12.0,
          color: Color(ColorUtil.butColor),
        ),
      ),
    );
  }

  Widget _agentBonusRule() {

    return new Container(
      child: new Column(
        children: <Widget>[
          _typeTitle("分红规则"),
          _agentBonusRuleContent("分红规则分红规则分红规则分红规则"
              "分红规则分红规则分红规则分红规则分红规则分红规则分红规"
              "则分红规则分红规则分红规则分红规则分红规则分红规则分红规则"),
          CommonView().commonLine_NoMarginChange(context,10.0),

        ],
      ),
    );
  }

  /**
   * 我的分红
   */
  Widget _meAgencyBouns() {
    return new Align(
      alignment: Alignment.center,
      child: new Container(
        height: 188.0  ,
        margin: EdgeInsets.only(left: 15.0, right: 15.0,bottom: 15.0),
        child: _recordBottom(),
          decoration: new BoxDecoration(
            border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
            borderRadius: new BorderRadius.circular((2.0)), // 圆角度
          )
      ),
    );
  }


  Widget _recordBottom() {

    return new Offstage(
      /// 控制列表数据是否显示
      offstage: false,
      child: new GestureDetector(
        onTap: () {
          // 数据显示
        },
        child: new Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0,),
          child: new Column(
            children: <Widget>[
              CommonView().commonLine_NoMargin(context),
              _recordBottomList("团队盈亏金额：", "11111"),
              _recordBottomList("有效会员人数：", "11111"),
              _recordBottomList("应得分红：", "11111"),
              _recordBottomList("已收到分红：", "11111"),
              _recordBottomList("应派发分红金额：", "11111"),
              _recordBottomList("已派发分红金额：", "11111"),
              _recordBottomList("分红时间：", "11111"),
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

  Widget _agencyBonusList() {

    return new Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0,bottom: 15.0),
        child: new Column(
          children: <Widget>[
            _agencyBonusListTop(),
            _agencyBonusListBottom(),

          ],
        ),
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(ColorUtil.butColor), width: 1), // 边色与边宽度
          borderRadius: new BorderRadius.circular((2.0)), // 圆角度
        )
    );
  }

  Widget _agencyBonusListTop() {

    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 40.0,
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: new Text(
              "2019-11-01",
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ),

          new Text(
            "查看详情",
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_888888),
            ),
          ),
          SpaceViewUtil.pading_Left(8.0),
          new Image.asset(ImageUtil.imgRightArrow, width: 15.0, height: 15.0,),

        ],
      ),
    );
  }

  Widget _agencyBonusListBottom() {

    return new Container(
      padding: EdgeInsets.only(bottom: 15.0,left: 10.0, right: 10.0),
      child: new Column(
        children: <Widget>[

          CommonView().commonLine_NoMargin(context),
          _agencyBonusListBottomDetail("分红比例：", "团队盈亏："),
          _agencyBonusListBottomDetail("分红金额：", "状态："),

        ],
      ),
    );
  }

  Widget _agencyBonusListBottomDetail(String titleOne, String titleTwo) {

    return new Container(
      child: new Row(
        children: <Widget>[

          new Expanded(child: _recordBottomList(titleOne, "11111"),),
          new Expanded(child: _recordBottomList(titleTwo, "11111"),),

        ],
      ),
    );
  }

}