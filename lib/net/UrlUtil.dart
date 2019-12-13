class UrlUtil {

  static const BaseUrl = "http://zijqum9pqu.52http.net/";

  static const login = "api/login/login";
  /// 修改登录密码
  static const editLoginPwd = "api/user/editLoginPwd";
  /// 修改、设置 支付密码
  static const setPaypwd = "api/user/setPaypwd";
  /// 获取用户银行卡
  static const getBankList = "api/user/getBankList";
  /// 获取银行卡类别列表
  static const getBanktypeList = "api/common/getBanktypeList";
  /// 银行卡绑定
  static const bindBank = "api/user/bindBank";


  ///banner列表
  static const getBannerList = "api/banner/getBannerList";
  /// 获取网站公告
  static const getNoticeList = "api/Article/getNoticeList";
  /// 网站活动列表
  static const getActivityList = "api/Article/getActivityList";

  /// 获取充值方式
  static const getPaytypeList = "api/pay/getPaytypeList";

  /**
   * 代理中心
   */
  /// 代理 开户
  static const addAccount = "api/user/addAcount";
  /// 创建开户链接
  static const addAccountLink = "api/user/khLink";
  /// 获取链接开户地址列表
  static const getLinkAccountList = "api/user/getLinkAcountList";
  /// 删除链接开户地址
  static const delLinkAccount = "api/user/delLinkAcount";

  /**
   * 广东11 选 5
   */
  /// 玩法获取
  static const getPlay = "api/guangdong/getPlay";
  static const gdBets = "api/guangdong/gdBets";
  /// 广东 11 选 5 下注
  static const orderAdd = "api/guangdong/orderAdd";

}