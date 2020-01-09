class UrlUtil {

  static const BaseUrl = "http://kwnng8.natappfree.cc/";

  static const login = "api/login/login";
  /// 退出登录
  static const loginOut = "api/user/loginOut";


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
  /// 提现时查询今日提现次数 提现中总金额
  static const withdrawList = "api/user/withdrawList";
  /// 提现申请
  static const userWithdraw = "api/user/userWithdraw";

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
  /// 团队投注
  static const teamBettingList = "api/betting/teamBettingList";
  /// 团队账变
  static const teamMoneyLog = "api/user/teamMoneyLog";
  /// 团队充值记录
  static const rechargeList = "api/user/rechargeList";
  /// 团队会员列表
  static const userlist = "api/user/userlist";
  /// 团队总览
  static const teamAll = "api/betting/teamAll";
  /// 团队列表
  static const teamList = "api/betting/teamList";
  /// 我的分红
  static const myFh = "api/user/myFh";
  /// 历史分红
  static const userFh = "api/user/userFh";

  /**
   * 个人中心
   */
  /// 个人投注记录
  static const bettingList = "api/betting/bettingList";
  /// 个人账变记录
  static const moneyLog = "api/user/moneyLog";
  /// 获取提现记录
  static const withdraw = "api/user/withdraw";
  /// 个人报表
  static const userReport = "api/user/userReport";

  /**
   * 彩票种类
   */
  ///
  static const lotteryList = "api/lottery/lotteryList";

  /**
   * 开奖记录
   */
  ///
  static const kjlogList = "api/Lottery/kjlogList";
  /// 彩票开奖信息（下期时间）
  static const getApi = "api/Lottery/getApi";

  /**
   * 广东11 选 5
   */
  /// 玩法获取
  static const getPlay = "api/guangdong/getPlay";
  static const gdBets = "api/guangdong/gdBets";
  /// 广东 11 选 5 下注
  static const orderAdd = "api/guangdong/orderAdd";

  /**
   * 越南 河内一分彩
   */
  ///
  static const hanoiOneGetPlay = "api/Ylhlyfc/getPlay";
  /// 计算注数
  static const hanoiOneGetGDBets = "api/Ylhlyfc/gdBets";



}