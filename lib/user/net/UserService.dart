import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/Util/bridge/ToastUtilBridge.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/GetBettingRecordListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/bank/BindBankHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/ModifyPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/SetPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_info_center/UserInfoCenterHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_record/UserAccountChangeRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/withdraw/UserWithdrawHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/withdraw/record/UserWithdrawRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/net/AccountChangeRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/GetBettingRecordListHandler.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';
import 'package:flutter_lisheng_entertainment/user/net/BankListHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/BindBankHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/RechargeHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/SetHandler.dart';

import 'LoginHandler.dart';
import 'ModifyLoginPasswordHandler.dart';
import 'SetCashPasswordHandler.dart';
import 'UserWithdrawRecordHandler.dart';
import 'WithdrawHandler.dart';

class UserService extends ToastUtilBridge{

  static UserService get instance => _getInstance();
  static UserService _instance;

  // 私有构造函数
  UserService._internal() {
    // 初始化
  }

  static UserService _getInstance() {
    if(_instance == null) {
      _instance = new UserService._internal();
    }
    return _instance;
  }

  /**
   * 登录
   */
  void login(String account, String pwd, LoginHandler loginHandler) {
    if (TextUtil.isEmpty(account)) {
      showToast("请输入账号");
      return;
    }
    if (TextUtil.isEmpty(pwd)) {
      showToast("请输入密码");
      return;
    }
    ApiService apiService = RetrofitManager.instance.createApiService();
    LoginHttpBeen loginHttpBeen = new LoginHttpBeen(account: account, pwd: pwd);
    apiService.setHandler(loginHandler);
    apiService.login(loginHttpBeen);
  }

  /**
   * 退出登录
   */
  ///
  void loginOut(SetHandler setHandler) {
    BaseTokenHttpBeen tokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(setHandler);
    apiService.loginOut(tokenHttpBeen);

  }

  /**
   * 修改登录密码
   */
  void modifyLoginPassword(String newPass, String reNewPass, String oldPass, ModifyLoginPasswordHandler loginHandler) {
    if (TextUtil.isEmpty(oldPass)) {
      showToast("请输入原密码");
      return;
    }
    if (TextUtil.isEmpty(newPass)) {
      showToast("请输入新密码");
      return;
    }
    if (newPass != reNewPass) {
      showToast("两次新密码不一致");
      return;
    }
    ApiService apiService = RetrofitManager.instance.createApiService();
    UserInfoCenterHttpBeen loginHttpBeen = new UserInfoCenterHttpBeen(newPass, oldPass, SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(loginHandler);
    apiService.editLoginPwd(loginHttpBeen);
  }

  /**
   * 修改、设置 支付密码
   */
  void setPaypwd(String newPass,SetCashPasswordHandler setCashPasswordHandler) {

    ApiService apiService = RetrofitManager.instance.createApiService();
    SetPaypwdHttpBeen setPaypwdHttpBeen = new SetPaypwdHttpBeen(newPass, SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(setCashPasswordHandler);
    apiService.setPaypwd(setPaypwdHttpBeen);
  }

  void modifyPaypwd(String newPass, String reNewPass, String oldPass,ModifyLoginPasswordHandler setCashPasswordHandler) {
    if (TextUtil.isEmpty(oldPass)) {
      showToast("请输入原密码");
      return;
    }
    if (TextUtil.isEmpty(newPass)) {
      showToast("请输入新密码");
      return;
    }
    if (newPass != reNewPass) {
      showToast("两次新密码不一致");
      return;
    }
    ApiService apiService = RetrofitManager.instance.createApiService();
    ModifyPaypwdHttpBeen modifyPaypwdHttpBeen = new ModifyPaypwdHttpBeen(newPass, oldPass,SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(setCashPasswordHandler);
    apiService.modifyPaypwd(modifyPaypwdHttpBeen);
  }

  /**
   * 获取用户银行卡
   */
  void getBankList(BankListHandler bankListHandler) {
    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(bankListHandler);
    apiService.getBankList(baseTokenHttpBeen);
  }

  /**
   * 获取银行卡类别列表
   */
  void getBanktypeList(BindBankHandler bindBankHandler){
    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bindBankHandler);
    apiService.getBanktypeList();
  }

  /**
   * 银行卡绑定
   */
  void bindBank(int banktype_id,String realname,String card_number,String branch_name,String capital_pwd
      ,BindBankHandler bindBankHandler) {
    ApiService apiService = RetrofitManager.instance.createApiService();
    BindBankHttpBeen bindBankHttpBeen = new BindBankHttpBeen(SpUtil.getString(Constant.TOKEN)
      , "$banktype_id", realname, card_number, branch_name, capital_pwd);
    apiService.setHandler(bindBankHandler);
    apiService.bindBank(bindBankHttpBeen);
  }

  /**
   * 获取充值方式
   */
  void getPaytypeList(RechargeHandler rechargeHandler) {
    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(rechargeHandler);
    apiService.getPaytypeList(baseTokenHttpBeen);
  }

  /***
   * 提现时查询今日提现次数 提现中总金额
   */
  ///
  void withdrawList(WithdrawHandler withdrawHandler) {
    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(withdrawHandler);
    apiService.withdrawList(baseTokenHttpBeen);
  }

  /**
   * 提现申请
   */
  ///
  void userWithdraw(WithdrawHandler withdrawHandler, String money, String bankId, String pay_pwd) {

    if(TextUtil.isEmpty(money)) {
      showToast("请输入提现金额");
      return;
    }
    if(TextUtil.isEmpty(bankId)) {
      showToast("请选择提现银行");
      return;
    }
    if(TextUtil.isEmpty(pay_pwd)) {
      showToast("请输入资金密码");
      return;
    }
    ApiService apiService = RetrofitManager.instance.createApiService();
    UserWithdrawHttpBeen userWithdrawHttpBeen = new UserWithdrawHttpBeen(
        SpUtil.getString(Constant.TOKEN), money, bankId, pay_pwd);
    apiService.setHandler(withdrawHandler);
    apiService.userWithdraw(userWithdrawHttpBeen);
  }

  /**
   * 个人账变记录
   */
  ///
  void moneyLog(AccountChangeRecordHandler changeRecordHandler,String type, int page, String startTime, String endTime) {
    UserAccountChangeRecordHttpBeen openLotteryListHttpBeen =
    new UserAccountChangeRecordHttpBeen(SpUtil.getString(Constant.TOKEN), type, "20", startTime, endTime,page);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(changeRecordHandler);
    apiService.moneyLog(openLotteryListHttpBeen);
  }

  /// 个人投注记录
  void bettingList(GetBettingRecordListHandler bettingRecordListHandler, String lotteryId, String status, String startTime, String endTime) {
    GetBettingRecordListHttpBeen openLotteryListHttpBeen = new GetBettingRecordListHttpBeen();
    openLotteryListHttpBeen.token = SpUtil.getString(Constant.TOKEN);
    openLotteryListHttpBeen.limit = "20";
    openLotteryListHttpBeen.lottery_id = lotteryId;
    openLotteryListHttpBeen.status = status;
    openLotteryListHttpBeen.stare_time = startTime;
    openLotteryListHttpBeen.end_time = endTime;

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(bettingRecordListHandler);
    apiService.bettingList(openLotteryListHttpBeen);
  }

  /// 获取提现记录
  void withdraw(UserWithdrawRecordHandler userWithdrawRecordHandler, String status, String startTime, String endTime) {
    UserWithdrawRecordHttpBeen withdrawRecordHttpBeen = new UserWithdrawRecordHttpBeen(SpUtil.getString(Constant.TOKEN), "20", status, startTime, endTime);

    ApiService apiService = RetrofitManager.instance.createApiService();
    apiService.setHandler(userWithdrawRecordHandler);
    apiService.withdraw(withdrawRecordHttpBeen);
  }

}