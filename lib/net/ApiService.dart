
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/agent/net/AgencyBonusHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/MemberManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/OrdinaryOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamAccountChangeHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamBettingHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamOverviewHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamRechargeRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/TeamReportFormHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/GameHallHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/PlayMode11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/CalculationBettingNumHandler.dart';
import 'package:flutter_lisheng_entertainment/game_hall/net/game_gd_11_5/LotteryNum11Choice5Handler.dart';
import 'package:flutter_lisheng_entertainment/home/net/ActivePageHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/LotteryCenterHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/SystemNoticeHandler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/GetBettingRecordListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/DelLinkAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/LinkOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/MemberManagerHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/OrdinaryOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/RechargeListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamAccountChangeHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamBettingListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/TeamReportFormHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/UserFhHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/bank/BindBankHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/game/OpenLotteryListHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CalculationBettingNumHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/gd_11_5/CpOpenLotteryInfoHttp.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/ModifyPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/SetPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_info_center/UserInfoCenterHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_record/UserAccountChangeRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/withdraw/UserWithdrawHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/withdraw/record/UserWithdrawRecordHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:flutter_lisheng_entertainment/model/json/account_change_record/AccountChangeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/active_page/ActivePageListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/LinkOpenAccountBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/OrdinaryOpenAccountBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/TeamOverviewBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/agency_bonus/AgencyBonusBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/agency_bonus/AgencyBonusHistoryBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/link_list/LinkAccountListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_account_change/TeamAccountChangeBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_betting/TeamBettingBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_member/MemberManagerBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_recharge/TeamRechargeRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/team_report_form/TeamReportFormBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/BankListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/type/GetBankTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/cash_password/PayPasswordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/game_hall/LotteryTypeDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CalculationBettingNumBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryDataInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryInfoBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/CpOpenLotteryInfoDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/gd_11_5/OpenLotteryListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/home_json/GetBannerListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_center/LotteryCenterBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/recharge/RechargeTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/set/SetLoginOutBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/system_notice/SystemNoticeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/WithdrawListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/withdraw/user_record/UserWithdrawRecordBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/user/bank/BindBankController.dart';
import 'package:flutter_lisheng_entertainment/user/net/BankListHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/BindBankHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/LoginHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/ModifyLoginPasswordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/RechargeHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/SetCashPasswordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/SetHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/UserWithdrawRecordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/WithdrawHandler.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';

import 'AccountChangeRecordHandler.dart';
import 'GetBettingRecordListHandler.dart';

@RestApi(baseUrl: UrlUtil.BaseUrl)
abstract class ApiService<T> {

  factory ApiService(Dio dio, {String baseUrl}) = _ApiService<T>;

  setHandler(T _baseHandler);

  @POST(UrlUtil.login)
  void login(@Body() LoginHttpBeen task);

  /// 退出登录
  @POST(UrlUtil.loginOut)
  void loginOut(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// banner列表
  @POST(UrlUtil.getBannerList)
  void getBannerList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  ///获取网站公告
  @POST(UrlUtil.getNoticeList)
  void getNoticeList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 网站活动列表
  @POST(UrlUtil.getActivityList)
  void getActivityList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  @POST(UrlUtil.editLoginPwd)
  void editLoginPwd(@Body() UserInfoCenterHttpBeen tokenHttpBeen);

  /// 设置资金密码
  @POST(UrlUtil.setPaypwd)
  void setPaypwd(@Body() SetPaypwdHttpBeen tokenHttpBeen);

  /// 修改资金密码
  @POST(UrlUtil.setPaypwd)
  void modifyPaypwd(@Body() ModifyPaypwdHttpBeen tokenHttpBeen);

  /// 获取银行卡列表
  @POST(UrlUtil.getBankList)
  void getBankList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 银行卡绑定
  @POST(UrlUtil.bindBank)
  void bindBank(@Body() BindBankHttpBeen tokenHttpBeen);

  /// 获取银行卡列表
  @POST(UrlUtil.getBanktypeList)
  void getBanktypeList();

  /// 获取充值方式
  @POST(UrlUtil.getPaytypeList)
  void getPaytypeList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 提现时查询今日提现次数 提现中总金额
  @POST(UrlUtil.withdrawList)
  void withdrawList(@Body() BaseTokenHttpBeen tokenHttpBeen);

  /// 提现时查询今日提现次数 提现中总金额
  @POST(UrlUtil.userWithdraw)
  void userWithdraw(@Body() UserWithdrawHttpBeen userWithdrawHttpBeen);

  /// 代理 开户
  @POST(UrlUtil.addAccount)
  void postOrdinaryOpenAccount(@Body() OrdinaryOpenAccountHttpBeen openAccountHttpBeen);

  /// 创建开户链接
  @POST(UrlUtil.addAccountLink)
  void postLinkOpenAccount(@Body() LinkOpenAccountHttpBeen openAccountHttpBeen);

  /// 获取链接开户地址列表
  @POST(UrlUtil.getLinkAccountList)
  void getLinkAccountList(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 删除链接开户地址
  @POST(UrlUtil.delLinkAccount)
  void delLinkAccount(@Body() DelLinkAccountHttpBeen openAccountHttpBeen);

  /// 团队投注
  @POST(UrlUtil.teamBettingList)
  void teamBettingList(@Body() TeamBettingListHttpBeen teamBettingListHttpBeen);

  /// 团队账变
  @POST(UrlUtil.teamMoneyLog)
  void teamMoneyLog(@Body() TeamAccountChangeHttpBeen teamBettingListHttpBeen);

  /// 团队充值记录
  @POST(UrlUtil.rechargeList)
  void rechargeList(@Body() RechargeListHttpBeen rechargeListHttpBeen);

  /// 团队会员列表
  @POST(UrlUtil.userlist)
  void userlist(@Body() MemberManagerHttpBeen managerHttpBeen);

  /// 团队总览
  @POST(UrlUtil.teamAll)
  void teamAll(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 团队列表
  @POST(UrlUtil.teamList)
  void teamList(@Body() TeamReportFormHttpBeen reportFormHttpBeen);

  /// 我的分红
  @POST(UrlUtil.myFh)
  void myFh(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  /// 历史分红
  @POST(UrlUtil.userFh)
  void userFh(@Body() UserFhHttpBeen openAccountHttpBeen);

  /**
   * 广东11 选 5
   */

  /// 删除链接开户地址
  @POST(UrlUtil.getPlay)
  void getPlay(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  @POST(UrlUtil.gdBets)
  void gdBets(@Body() CalculationBettingNumHttpBeen openAccountHttpBeen);

  /// 广东11 选 5
  @POST(UrlUtil.orderAdd)
  void orderAdd(@Body() CalculationBettingNumHttpBeen openAccountHttpBeen);

  /// 彩票种类
  @POST(UrlUtil.lotteryList)
  void lotteryList(@Body() BaseTokenHttpBeen openAccountHttpBeen);

  ///开奖记录
  @POST(UrlUtil.kjlogList)
  void kjlogList(@Body() OpenLotteryListHttpBeen openLotteryListHttpBeen);

  ///开奖记录 (下期时间)
  @POST(UrlUtil.getApi)
  void getApi(@Body() CpOpenLotteryInfoHttp openLotteryListHttpBeen);

  @POST(UrlUtil.getApi)
  void getApiHome(@Body() CpOpenLotteryInfoHttp openLotteryListHttpBeen);

  /**
   * 个人中心
   */
  /// 个人投注记录
  @POST(UrlUtil.bettingList)
  void bettingList(@Body() GetBettingRecordListHttpBeen openLotteryListHttpBeen);

  @POST(UrlUtil.moneyLog)
  void moneyLog(@Body() UserAccountChangeRecordHttpBeen openLotteryListHttpBeen);

  /// 获取提现记录
  @POST(UrlUtil.withdraw)
  void withdraw(@Body() UserWithdrawRecordHttpBeen withdrawRecordHttpBeen);

}

class _ApiService<T> implements ApiService<T> {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= UrlUtil.BaseUrl;
  }

  final Dio _dio;

  T _baseHandler;
  String baseUrl;

  _getHeaders () {
    return {
      'Accept':'application/json, text/plain, */*',
      'Content-Type':'application/json',
    };
  }

  @override
  setHandler(T _baseHandler) {
    this._baseHandler = _baseHandler;
  }

  /**
   * 发送Post 网络请求
   * jsonData 传入的 json 数据
   */
  @override
  Future<Map<String, dynamic>> responseResult(Map<String, dynamic> jsonData, String path) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(jsonData ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(path,
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: _getHeaders (),
            extra: _extra,
            baseUrl: UrlUtil.BaseUrl),
        data: _data);

//    .catchError((error) {
//    switch (error.runtimeType) {
//    case DioError:
//    // Here's the sample to get the failed response error code and message
//    final res = (error as DioError).response;
//    //print("Got error : ${res.statusCode} -> ${res.statusMessage}");
//    break;
//    default:
//    }
//    })

    if (_result.data != null) {
      print(_result.data);
    }

    return _result.data;
  }

  @override
  void login(LoginHttpBeen task) {
    ArgumentError.checkNotNull(task, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(task.toJson(), UrlUtil.login).then((onValue) {
      var loginDataBeen = LoginBeen.fromJson(onValue);

      var loginH = _baseHandler as LoginHandler;
      if (loginDataBeen.code == 1) {
        print("token = ${loginDataBeen.toString()}");
        print("loginDataBeen = ${loginDataBeen.data.token}");
        SpUtil.putString(Constant.TOKEN, "${loginDataBeen.data.token}");
        SpUtil.putString(Constant.ALL_MONEY, "${loginDataBeen.data.userInfo.all_money}");
        SpUtil.putString(Constant.USER_RATIO, "${loginDataBeen.data.userInfo.ratio}");
        SpUtil.putString(Constant.USER_HEAD_IMG, "${loginDataBeen.data.userInfo.avatar}");
        SpUtil.putString(Constant.USER_NAME, "${loginDataBeen.data.userInfo.username}");
        var pay_pwd = loginDataBeen.data.userInfo.pay_pwd;
        if(pay_pwd != null) {
          if (!TextUtil.isEmpty(pay_pwd)) {
            SpUtil.putBool(Constant.PAY_SET, true);
          } else {
            SpUtil.putBool(Constant.PAY_SET, false);
          }
        } else {
          SpUtil.putBool(Constant.PAY_SET, false);
        }

        print("SpUtil GetToekn = ${SpUtil.getString(Constant.TOKEN)}");
        if (loginH != null) {
          loginH.loginSuccess(true, loginDataBeen);
        }
      } else {
        if (loginH != null) {
          loginH.loginFail(false);
          loginH.showToast(loginDataBeen.msg);
        }
      }

      return loginDataBeen;
    });
  }

  /// 退出登录
  @override
  void loginOut(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.loginOut).then((onValue) {
      var bannerList = SetLoginOutBeen.fromJson(onValue);
      var setHandler = _baseHandler as SetHandler;
      if (bannerList.code == 1) {
        if (setHandler != null) {
          setHandler.loginOutResult(true);
        }
      } else {
        setHandler.showToast(bannerList.msg);
      }
    });
  }

  @override
  void getBannerList(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getBannerList).then((onValue) {
      var bannerList = GetBannerListDataBeen.fromJson(onValue);
      var homeHandler = _baseHandler as HomeHandler;
      if (bannerList.code == 1) {
        if (homeHandler != null) {
          homeHandler.getBannerListBeen(bannerList);
        }
      }
    });
  }

  @override
  void getNoticeList(@Body() BaseTokenHttpBeen tokenHttpBeen){
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getNoticeList).then((onValue) {
      var systemNoticeList = SystemNoticeListBeen.fromJson(onValue);
      var systemNoticeHandler = _baseHandler as SystemNoticeHandler;
      if (systemNoticeList.code == 1) {
        systemNoticeHandler.setSystemListData(systemNoticeList.data);
      }

    });
  }

  @override
  void getActivityList(@Body() BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getActivityList).then((onValue) {
      var activePageListBeen = ActivePageListBeen.fromJson(onValue);
      var activePageHandler = _baseHandler as ActivePageHandler;
      if (activePageListBeen.code == 1) {
        activePageHandler.setActivePageListBeen(activePageListBeen.data);
      }

    });
  }

  @override
  void editLoginPwd(@Body() UserInfoCenterHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.editLoginPwd).then((onValue) {

    });
  }

  /// 修改、设置 支付密码
  @override
  void setPaypwd(@Body() SetPaypwdHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.setPaypwd).then((onValue) {
      var payPasswordBeen = PayPasswordBeen.fromJson(onValue);
      SetCashPasswordHandler cashPasswordHandler = _baseHandler as SetCashPasswordHandler;
      if (payPasswordBeen.code == 1) {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.setPayPasswordResult(true);
        }
      } else {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.showToast(payPasswordBeen.msg);
        }
      }
    });
  }

  @override
  void modifyPaypwd(@Body() ModifyPaypwdHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.setPaypwd).then((onValue) {
      var payPasswordBeen = PayPasswordBeen.fromJson(onValue);
      ModifyLoginPasswordHandler cashPasswordHandler = _baseHandler as ModifyLoginPasswordHandler;
      if (payPasswordBeen.code == 1) {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.setPayPasswordResult(true);
        }
      } else {
        if (cashPasswordHandler != null) {
          cashPasswordHandler.showToast(payPasswordBeen.msg);
        }
      }
    });
  }

  /**
   * 获取银行卡列表
   */
  @override
  void getBankList(@Body() BaseTokenHttpBeen tokenHttpBeen){
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getBankList).then((onValue) {
      var bankListBeen = BankListBeen.fromJson(onValue);
      BankListHandler bankListHandler = _baseHandler as BankListHandler;
      if (bankListBeen.code == 1) {
        if (bankListHandler != null) {
          bankListHandler.setBankListDataBeen(bankListBeen.data);
        }
      } else {
      }

    });
  }

  /**
   * 获取银行卡类别列表
   */
  @override
  void getBanktypeList() {
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(null, UrlUtil.getBanktypeList).then((onValue) {
      var getBankTypeList = GetBankTypeListBeen.fromJson(onValue);
      BindBankHandler bindBankHandler = _baseHandler as BindBankHandler;

      if (getBankTypeList.code == 1) {
        bindBankHandler.setBankTypeList(getBankTypeList.data);
      } else {
        bindBankHandler.showToast(getBankTypeList.msg);
      }

    });
  }

  @override
  void bindBank(@Body() BindBankHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(tokenHttpBeen.toJson(), UrlUtil.bindBank).then((onValue) {
      var getBankTypeList = GetBankTypeListBeen.fromJson(onValue);
      BindBankHandler bindBankHandler = _baseHandler as BindBankHandler;

      if (getBankTypeList.code == 1) {
        bindBankHandler.setBindBankResult(true, getBankTypeList.msg);
      } else {
        bindBankHandler.showToast(getBankTypeList.msg);
      }

    });
  }

  @override
  void getPaytypeList(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.getPaytypeList).then((onValue) {
      var rechargeTypeBeen = RechargeTypeListBeen.fromJson(onValue);
      RechargeHandler rechargeHandler = _baseHandler as RechargeHandler;

      if (rechargeTypeBeen.code == 1) {
        rechargeHandler.setRechargeTypeList(rechargeTypeBeen);
      } else {
        rechargeHandler.showToast(rechargeTypeBeen.msg);
      }

    });
  }

  /**
   * 提现时查询今日提现次数 提现中总金额
   */
  ///
  @override
  void withdrawList(BaseTokenHttpBeen tokenHttpBeen) {
    ArgumentError.checkNotNull(tokenHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(tokenHttpBeen.toJson(), UrlUtil.withdrawList).then((onValue) {
      var rechargeTypeBeen = WithdrawListDataBeen.fromJson(onValue);
      WithdrawHandler rechargeHandler = _baseHandler as WithdrawHandler;

      if (rechargeTypeBeen.code == 1) {
        rechargeHandler.setWithdrawListData(rechargeTypeBeen);
      } else {
        rechargeHandler.showToast(rechargeTypeBeen.msg);
      }

    });
  }
  /**
   * 提现申请
   */
  ///
  @override
  void userWithdraw(UserWithdrawHttpBeen userWithdrawHttpBeen) {
    ArgumentError.checkNotNull(userWithdrawHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(userWithdrawHttpBeen.toJson(), UrlUtil.userWithdraw).then((onValue) {
      var rechargeTypeBeen = WithdrawListDataBeen.fromJson(onValue);
      WithdrawHandler rechargeHandler = _baseHandler as WithdrawHandler;
      rechargeHandler.showToast(rechargeTypeBeen.msg);
      if (rechargeTypeBeen.code == 1) {
        rechargeHandler.userWithdrawResult(true);
      }

    });
  }

  /**
   * 代理 开户
   */
  @override
  void postOrdinaryOpenAccount(OrdinaryOpenAccountHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.addAccount).then((onValue) {
      var openAccountBeen = OrdinaryOpenAccountBeen.fromJson(onValue);
      OrdinaryOpenAccountHandler rechargeHandler = _baseHandler as OrdinaryOpenAccountHandler;

      if (openAccountBeen.code == 1) {
        rechargeHandler.showToast(openAccountBeen.msg);
        rechargeHandler.setOrdinaryOpenAccountResult(true);
      } else {
        rechargeHandler.showToast(openAccountBeen.msg);
      }

    });
  }

  /**
   * 创建开户链接
   */
  @override
  void postLinkOpenAccount(LinkOpenAccountHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.addAccountLink).then((onValue) {
      var openAccountBeen = LinkOpenAccountBeen.fromJson(onValue);
      LinkOpenAccountHandler rechargeHandler = _baseHandler as LinkOpenAccountHandler;

      if (openAccountBeen.code == 1) {
        rechargeHandler.showToast(openAccountBeen.msg);
        rechargeHandler.setLinkOpenAccountResult(true);
      } else {
        rechargeHandler.showToast(openAccountBeen.msg);
      }

    });
  }

  /**
   * 获取链接开户地址列表
   */
  @override
  void getLinkAccountList(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.getLinkAccountList).then((onValue) {
      var linkListBeen = LinkAccountListDataBeen.fromJson(onValue);
      LinkManagerHandler linkManagerHandler = _baseHandler as LinkManagerHandler;

      if (linkListBeen.code == 1) {
        linkManagerHandler.setLinkAccountList(linkListBeen.data);
      } else {
        linkManagerHandler.showToast(linkListBeen.msg);
      }

    });
  }

  /// 删除链接开户地址
  @override
  void delLinkAccount(DelLinkAccountHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.delLinkAccount).then((onValue) {
      var linkListBeen = LinkAccountListDataBeen.fromJson(onValue);
      LinkManagerHandler linkManagerHandler = _baseHandler as LinkManagerHandler;
      linkManagerHandler.showToast(linkListBeen.msg);
      if (linkListBeen.code == 1) {
        linkManagerHandler.setDelLinkAccount(true);
      }

    });
  }

  /// 团队投注
  @override
  void teamBettingList(TeamBettingListHttpBeen teamBettingListHttpBeen) {
    ArgumentError.checkNotNull(teamBettingListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(teamBettingListHttpBeen.toJson(), UrlUtil.teamBettingList).then((onValue) {
      var teamBettingBeen = TeamBettingBeen.fromJson(onValue);
      TeamBettingHandler teamBettingHandler = _baseHandler as TeamBettingHandler;

      if (teamBettingBeen.code == 1) {
        teamBettingHandler.setTeamBettingBeen(teamBettingBeen);
      } else {
        teamBettingHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队账变
  @override
  void teamMoneyLog(TeamAccountChangeHttpBeen teamBettingListHttpBeen) {
    ArgumentError.checkNotNull(teamBettingListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(teamBettingListHttpBeen.toJson(), UrlUtil.teamMoneyLog).then((onValue) {
      var teamBettingBeen = TeamAccountChangeBeen.fromJson(onValue);
      TeamAccountChangeHandler teamBettingHandler = _baseHandler as TeamAccountChangeHandler;

      if (teamBettingBeen.code == 1) {
        teamBettingHandler.setTeamAccountChangeBeen(teamBettingBeen);
      } else {
        teamBettingHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队充值记录
  @override
  void rechargeList(RechargeListHttpBeen rechargeListHttpBeen) {
    ArgumentError.checkNotNull(rechargeListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(rechargeListHttpBeen.toJson(), UrlUtil.rechargeList).then((onValue) {
      var teamBettingBeen = TeamRechargeRecordBeen.fromJson(onValue);
      TeamRechargeRecordHandler teamRechargeRecordHandler = _baseHandler as TeamRechargeRecordHandler;

      if (teamBettingBeen.code == 1) {
        teamRechargeRecordHandler.setTeamRechargeRecordBeen(teamBettingBeen);
      } else {
        teamRechargeRecordHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队会员列表
  @override
  void userlist(MemberManagerHttpBeen managerHttpBeen) {
    ArgumentError.checkNotNull(managerHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(managerHttpBeen.toJson(), UrlUtil.userlist).then((onValue) {
      var teamBettingBeen = MemberManagerBeen.fromJson(onValue);
      MemberManagerHandler teamRechargeRecordHandler = _baseHandler as MemberManagerHandler;

      if (teamBettingBeen.code == 1) {
        teamRechargeRecordHandler.setMemberManagerBeen(teamBettingBeen);
      } else {
        teamRechargeRecordHandler.showToast(teamBettingBeen.msg);
      }

    });
  }

  /// 团队总览
  @override
  void teamAll(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.teamAll).then((onValue) {
      var teamOverviewBeen = TeamOverviewBeen.fromJson(onValue);
      TeamOverviewHandler teamOverviewHandler = _baseHandler as TeamOverviewHandler;

      if (teamOverviewBeen.code == 1) {
        teamOverviewHandler.setTeamOverviewBeen(teamOverviewBeen);
      } else {
        teamOverviewHandler.showToast(teamOverviewBeen.msg);
      }

    });
  }

  /// 团队列表
  @override
  void teamList(TeamReportFormHttpBeen reportFormHttpBeen) {
    ArgumentError.checkNotNull(reportFormHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(reportFormHttpBeen.toJson(), UrlUtil.teamList).then((onValue) {
      var teamReportBeen = TeamReportFormBeen.fromJson(onValue);
      TeamReportFormHandler teamOverviewHandler = _baseHandler as TeamReportFormHandler;

      if (teamReportBeen.code == 1) {
        teamOverviewHandler.setTeamReportFormBeen(teamReportBeen);
      } else {
        teamOverviewHandler.showToast(teamReportBeen.msg);
      }

    });
  }

  /// 我的分红
  @override
  void myFh(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.myFh).then((onValue) {
      var teamOverviewBeen = AgencyBonusBeen.fromJson(onValue);
      AgencyBonusHandler teamOverviewHandler = _baseHandler as AgencyBonusHandler;

      if (teamOverviewBeen.code == 1) {
        teamOverviewHandler.setAgencyBonusBeen(teamOverviewBeen);
      } else {
        teamOverviewHandler.showToast(teamOverviewBeen.msg);
      }

    });
  }

  /// 历史分红
  @override
  void userFh(UserFhHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');

    responseResult(openAccountHttpBeen.toJson(), UrlUtil.userFh).then((onValue) {
      var teamOverviewBeen = AgencyBonusHistoryBeen.fromJson(onValue);
      AgencyBonusHandler teamOverviewHandler = _baseHandler as AgencyBonusHandler;

      if (teamOverviewBeen.code == 1) {
        teamOverviewHandler.setAgencyBonusHistoryBeen(teamOverviewBeen);
      } else {
        teamOverviewHandler.showToast(teamOverviewBeen.msg);
      }

    });
  }

  /// 广东11 选 5

  /**
   * 玩法获取
   */
  @override
  void getPlay(BaseTokenHttpBeen playMode) {
    ArgumentError.checkNotNull(playMode, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(playMode.toJson(), UrlUtil.getPlay).then((onValue) {
      PlayMode11Choice5Handler linkManagerHandler = _baseHandler as PlayMode11Choice5Handler;
      linkManagerHandler.playModeMapValue(onValue);

    });
  }

  @override
  void gdBets(CalculationBettingNumHttpBeen bettingNumHttpBeen) {
    ArgumentError.checkNotNull(bettingNumHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(bettingNumHttpBeen.toJson(), UrlUtil.gdBets).then((onValue) {
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      CalculationBettingNumHandler linkManagerHandler = _baseHandler as CalculationBettingNumHandler;
      if (bettingNum.code == 1) {
        linkManagerHandler.getCalculationBettingNumData(bettingNum.data);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 下注
  @override
  void orderAdd(CalculationBettingNumHttpBeen bettingNumHttpBeen) {
    ArgumentError.checkNotNull(bettingNumHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(bettingNumHttpBeen.toJson(), UrlUtil.orderAdd).then((onValue) {
      var bettingNum = CalculationBettingNumBeen.fromJson(onValue);
      CalculationBettingNumHandler linkManagerHandler = _baseHandler as CalculationBettingNumHandler;
      linkManagerHandler.showToast(bettingNum.msg);
      if (bettingNum.code == 1) {
        linkManagerHandler.multipleSuccess(true);
      }
    });
  }

  /// 彩票种类
  @override
  void lotteryList(BaseTokenHttpBeen openAccountHttpBeen) {
    ArgumentError.checkNotNull(openAccountHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openAccountHttpBeen.toJson(), UrlUtil.lotteryList).then((onValue) {
      var bettingNum = LotteryTypeDataBeen.fromJson(onValue);
      GameHallHandler linkManagerHandler = _baseHandler as GameHallHandler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setLotteryTypeData(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }
    });
  }

  /// 开奖列表
  @override
  void kjlogList(OpenLotteryListHttpBeen openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.kjlogList).then((onValue) {
      var bettingNum = OpenLotteryListDataBeen.fromJson(onValue);
      LotteryNum11Choice5Handler linkManagerHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setOpenLotteryListData(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 彩票开奖信息（下期时间）
  @override
  void getApi(CpOpenLotteryInfoHttp openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.getApi).then((onValue) {
      var bettingNum = CpOpenLotteryDataInfoBeen.fromJson(onValue);
      LotteryNum11Choice5Handler linkManagerHandler = _baseHandler as LotteryNum11Choice5Handler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setOpenLotteryListInfoData(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }

    });
  }

  /// 彩票开奖信息
  @override
  void getApiHome(CpOpenLotteryInfoHttp openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.getApi).then((onValue) {
      var bettingNum = LotteryCenterBeen.fromJson(onValue);
      LotteryCenterHandler linkManagerHandler = _baseHandler as LotteryCenterHandler;

      if (bettingNum.code == 1) {
        linkManagerHandler.setLotteryCenterBeen(bettingNum);
      } else {
        linkManagerHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 个人投注记录
   */
  ///
  @override
  void bettingList(GetBettingRecordListHttpBeen openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.bettingList).then((onValue) {
      var bettingNum = GetBettingRecordBeen.fromJson(onValue);
      GetBettingRecordListHandler bettingRecordListHandler = _baseHandler as GetBettingRecordListHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setGetBettingRecordData(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 个人账变记录
   */
  ///
  void moneyLog(UserAccountChangeRecordHttpBeen openLotteryListHttpBeen) {
    ArgumentError.checkNotNull(openLotteryListHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(openLotteryListHttpBeen.toJson(), UrlUtil.moneyLog).then((onValue) {
      var bettingNum = AccountChangeRecordBeen.fromJson(onValue);
      AccountChangeRecordHandler bettingRecordListHandler = _baseHandler as AccountChangeRecordHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setAccountChangeRecord(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

  /**
   * 获取提现记录
   */
  ///
  @override
  void withdraw(UserWithdrawRecordHttpBeen withdrawRecordHttpBeen) {
    ArgumentError.checkNotNull(withdrawRecordHttpBeen, '参数为空');
    ArgumentError.checkNotNull(_baseHandler, '_baseHandler为空');
    responseResult(withdrawRecordHttpBeen.toJson(), UrlUtil.moneyLog).then((onValue) {
      var bettingNum = UserWithdrawRecordBeen.fromJson(onValue);
      UserWithdrawRecordHandler bettingRecordListHandler = _baseHandler as UserWithdrawRecordHandler;

      if (bettingNum.code == 1) {
        bettingRecordListHandler.setUserWithdrawRecordBeen(bettingNum);
      } else {
        bettingRecordListHandler.showToast(bettingNum.msg);
      }

    });
  }

}
