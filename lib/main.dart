import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lisheng_entertainment/HomeController.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/RouteUtil.dart';
import 'package:flutter_lisheng_entertainment/user/bank/BankListController.dart';
import 'package:flutter_lisheng_entertainment/user/bank/BindBankController.dart';
import 'package:flutter_lisheng_entertainment/user/personal_center/AccountChangeRecordController.dart';
import 'package:flutter_lisheng_entertainment/user/personal_center/BettingRecordController.dart';
import 'package:flutter_lisheng_entertainment/user/LoginActivity.dart';
import 'package:flutter_lisheng_entertainment/SplashController.dart';
import 'package:flutter_lisheng_entertainment/user/personal_center/BettingRecordDetailController.dart';
import 'package:flutter_lisheng_entertainment/user/personal_center/LotteryReportController.dart';
import 'package:flutter_lisheng_entertainment/user/personal_center/ModifyCapitalPasswordController.dart';
import 'package:flutter_lisheng_entertainment/user/PersonalController.dart';
import 'package:flutter_lisheng_entertainment/user/RechargeController.dart';
import 'package:flutter_lisheng_entertainment/user/SetController.dart';
import 'package:flutter_lisheng_entertainment/user/TransferAccountsController.dart';
import 'package:flutter_lisheng_entertainment/user/WithdrawalController.dart';
import 'package:flutter_lisheng_entertainment/user/personal_center/ModifyLoginPasswordController.dart';

import 'agent/AgencyBonusController.dart';
import 'agent/AgentCenterController.dart';
import 'agent/OpenAccountCenterController.dart';
import 'agent/RechargeRecordController.dart';
import 'agent/WithdrawalRecordController.dart';
import 'agent/member/MemberManagerController.dart';
import 'agent/team_controller/TeamAccountChangeController.dart';
import 'agent/team_controller/TeamBettingController.dart';
import 'agent/team_controller/TeamOverviewController.dart';
import 'agent/team_controller/TeamReportFormController.dart';
import 'home/ActivePageController.dart';
import 'home/LotteryCenterController.dart';
import 'home/SystemNoticeController.dart';
import 'home/SystemNoticeDetailController.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
//        primarySwatch: Color(mainColor[""]),
      primaryColor: Color(ColorUtil.butColor)
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: LoginActivity(),
      home: SplashController(),
      routes: <String, WidgetBuilder> {
        RouteUtil.homeController: (BuildContext context) => HomeController(),
        RouteUtil.setController: (BuildContext context) => SetController(),
        RouteUtil.rechargeController: (BuildContext context) => RechargeController(),
        RouteUtil.withdrawalController: (BuildContext context) => WithdrawalController(),
        RouteUtil.transferAccountsController: (BuildContext context) => TransferAccountsController(),
        RouteUtil.personalController: (BuildContext context) => PersonalController(),
        RouteUtil.agentCenterController: (BuildContext context) => AgentCenterController(),
        RouteUtil.modifyLoginPasswordController: (BuildContext context) => ModifyLoginPasswordController(),
        RouteUtil.modifyCapitalPasswordController: (BuildContext context) => ModifyCapitalPasswordController(),
        RouteUtil.activePageController: (BuildContext context) => ActivePageController(),
        RouteUtil.systemNoticeController: (BuildContext context) => SystemNoticeController(),
        RouteUtil.systemNoticeDetailController: (BuildContext context) => SystemNoticeDetailController(),
        RouteUtil.bettingRecordController: (BuildContext context) => BettingRecordController(),
        RouteUtil.lotteryReportController: (BuildContext context) => LotteryReportController(),
        RouteUtil.accountChangeRecordController: (BuildContext context) => AccountChangeRecordController(),
        RouteUtil.teamOverviewController: (BuildContext context) => TeamOverviewController(),
        RouteUtil.teamReportFormController: (BuildContext context) => TeamReportFormController(),
        RouteUtil.teamAccountChangeController: (BuildContext context) => TeamAccountChangeController(),
        RouteUtil.teamBettingController: (BuildContext context) => TeamBettingController(),
        RouteUtil.memberManagerController: (BuildContext context) => MemberManagerController(),
        RouteUtil.rechargeRecordController: (BuildContext context) => RechargeRecordController(),
        RouteUtil.withdrawalRecordController: (BuildContext context) => WithdrawalRecordController(),
        RouteUtil.lotteryCenterController: (BuildContext context) => LotteryCenterController(),
        RouteUtil.bettingRecordDetailController: (BuildContext context) => BettingRecordDetailController(),
        RouteUtil.openAccountCenterController: (BuildContext context) => OpenAccountCenterController(),
        RouteUtil.bankListController: (BuildContext context) => BankListController(),
        RouteUtil.bindBankController: (BuildContext context) => BindBankController(),
        RouteUtil.agencyBonusController: (BuildContext context) => AgencyBonusController(),
      },
    );
  }
}

