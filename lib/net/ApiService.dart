
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkManagerHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/LinkOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/agent/net/OrdinaryOpenAccountHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/ActivePageHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/HomeHandler.dart';
import 'package:flutter_lisheng_entertainment/home/net/SystemNoticeHandler.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/DelLinkAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/LinkOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/agent/OrdinaryOpenAccountHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/bank/BindBankHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/ModifyPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/set_cash_pass/SetPaypwdHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/http/user_info_center/UserInfoCenterHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:flutter_lisheng_entertainment/model/json/active_page/ActivePageListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/LinkOpenAccountBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/OrdinaryOpenAccountBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/agent/link_list/LinkAccountListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/BankListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/bank/type/GetBankTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/cash_password/PayPasswordBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/home_json/GetBannerListDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/recharge/RechargeTypeListBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/system_notice/SystemNoticeListBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/user/bank/BindBankController.dart';
import 'package:flutter_lisheng_entertainment/user/net/BankListHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/BindBankHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/LoginHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/ModifyLoginPasswordHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/RechargeHandler.dart';
import 'package:flutter_lisheng_entertainment/user/net/SetCashPasswordHandler.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';

@RestApi(baseUrl: UrlUtil.BaseUrl)
abstract class ApiService<T> {

  factory ApiService(Dio dio, {String baseUrl}) = _ApiService<T>;

  setHandler(T _baseHandler);

  @POST(UrlUtil.login)
  void login(@Body() LoginHttpBeen task);

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
    print(_result.data);

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

}
