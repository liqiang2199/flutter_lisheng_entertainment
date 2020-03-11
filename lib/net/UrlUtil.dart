class UrlUtil {

  static const BaseUrl = "http://7csdv2.natappfree.cc/";
//  static const BaseUrl = "http://128.1.61.216:82/";

  static const login = "api/login/login";
  /// 退出登录
  static const loginOut = "api/user/loginOut";
  /// 图片上传
  static const commonUpload = "api/common/upload";
  /// 修改用户头像
  static const editAvatar = "api/user/editAvatar";


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
  /// 开户页面获取最大返点值
  static const openAccount = "api/user/openAccount";
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
  /// 添加常用彩种
  static const addUserLottery = "api/user/addUserLottery";
  /// 获取常用彩种
  static const getUserLottery = "api/user/getUserLottery";
  /// 删除常用彩种
  static const delUserLottery = "api/user/delUserLottery";

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
  /// 订单撤销
  static const delOrder = "api/order/delOrder";
  /// 再来一单
  static const orderOnce = "api/order/orderOnce";

  /**
   * 广东11 选 5
   */
  /// 玩法获取
  static const getPlay = "api/guangdong/getPlay";
  static const gdBets = "api/guangdong/gdBets";
  /// 广东 11 选 5 下注
  static const orderAdd = "api/guangdong/orderAdd";

  /**
   * 越南河内一分彩
   */
  /// 玩法获取
  static const hanoiOneGetPlay = "api/Ylhlyfc/getPlay";
  ///计算注数
  static const hanoiOneGetGDBets = "api/Ylhlyfc/gdBets";
  /// 下注
  static const hanoiOneGetOrderAdd = "api/Ylhlyfc/orderAdd";
  /// 下期开奖时间
  static const hanoiOneGetKjTime = "api/Ylhlyfc/getKjtime";
  /// 越南河内1分彩 开奖记录
  static const hanoiOneKjLog = "api/Ylhlyfc/kjLog";
  /// 单号走势
  static const hanoiOneOddNumber = "api/Ylhlyfc/oddNumber";
  /// 多号走势
  static const hanoiOneMultipleNumbers = "api/Ylhlyfc/multipleNumbers";
  /// 单双走势
  static const hanoiOneSingleDouble = "api/Ylhlyfc/singleDouble";
  /// 五星和值
  static const hanoiOneFiveValue = "api/Ylhlyfc/fiveValue";
  /// 各类和值
  static const hanoiOneVariousSum = "api/Ylhlyfc/hzSum";
  /// 各类跨度
  static const hanoiOneVariousSpan = "api/Ylhlyfc/kd";
  /// 龙虎和
  static const hanoiOneDragonTiger = "api/Ylhlyfc/lhh";
  /// 大小走势
  static const hanoiOneMaxMin = "api/Ylhlyfc/maxMin";

  /**
   * 河内5分彩
   */
  /// 玩法获取
  static const hanoi5GetPlay = "api/Ylhlwfc/getPlay";
  ///计算注数
  static const hanoi5GetGDBets = "api/Ylhlwfc/gdBets";
  /// 下注
  static const hanoi5GetOrderAdd = "api/Ylhlwfc/orderAdd";
  /// 下期开奖时间
  static const hanoi5GetKjTime = "api/Ylhlwfc/getKjtime";
  /// 越南河内1分彩 开奖记录
  static const hanoi5KjLog = "api/Ylhlwfc/kjLog";


  /**
   * 腾讯 分分彩
   */
  /// 开奖记录
  static const tencentKjLog = "api/Txffc/kjLog";
  /// 玩法获取
  static const tencentGetPlay = "api/Txffc/getPlay";
  /// 开奖时间
  static const tencentGetKjtime = "api/Txffc/getKjtime";
  /// 计算注数
  static const tencentGdBets = "api/Txffc/gdBets";
  /// 下注接口
  static const tencentOrderAdd = "api/Txffc/orderAdd";

  /**
   * 腾讯 5分彩
   */
  /// 开奖记录
  static const tencent5KjLog = "api/Txwfc/kjLog";
  /// 玩法获取
  static const tencent5GetPlay = "api/Txwfc/getPlay";
  /// 开奖时间
  static const tencent5GetKjtime = "api/Txwfc/getKjtime";
  /// 计算注数
  static const tencent5GdBets = "api/Txwfc/gdBets";
  /// 下注接口
  static const tencent5OrderAdd = "api/Txwfc/orderAdd";

  /**
   * 腾讯 10分彩
   */
  /// 开奖记录
  static const tencent10KjLog = "api/Txsfc/kjLog";
  /// 玩法获取
  static const tencent10GetPlay = "api/Txsfc/getPlay";
  /// 开奖时间
  static const tencent10GetKjtime = "api/Txsfc/getKjtime";
  /// 计算注数
  static const tencent10GdBets = "api/Txsfc/gdBets";
  /// 下注接口
  static const tencent10OrderAdd = "api/Txsfc/orderAdd";

  /**
   * 奇趣一分彩
   */
  /// 开奖记录
  static const oddInterestKjLog = "api/Qqyfc/kjLog";
  /// 玩法获取
  static const oddInterestGetPlay = "api/Qqyfc/getPlay";
  /// 开奖时间
  static const oddInterestGetKjtime = "api/Qqyfc/getKjtime";
  /// 计算注数
  static const oddInterestGdBets = "api/Qqyfc/gdBets";
  /// 下注接口
  static const oddInterestOrderAdd = "api/Qqyfc/orderAdd";

   /**
   * 奇趣5分彩
   */
  /// 开奖记录
  static const oddInterest5KjLog = "api/Qqwfc/kjLog";
  /// 玩法获取
  static const oddInterest5GetPlay = "api/Qqwfc/getPlay";
  /// 开奖时间
  static const oddInterest5GetKjtime = "api/Qqwfc/getKjtime";
  /// 计算注数
  static const oddInterest5GdBets = "api/Qqwfc/gdBets";
  /// 下注接口
  static const oddInterest5OrderAdd = "api/Qqwfc/orderAdd";

  /**
   * 奇趣10分彩
   */
  /// 开奖记录
  static const oddInterest10KjLog = "api/Qqsfc/kjLog";
  /// 玩法获取
  static const oddInterest10GetPlay = "api/Qqsfc/getPlay";
  /// 开奖时间
  static const oddInterest10GetKjtime = "api/Qqsfc/getKjtime";
  /// 计算注数
  static const oddInterest10GdBets = "api/Qqsfc/gdBets";
  /// 下注接口
  static const oddInterest10OrderAdd = "api/Qqsfc/orderAdd";

  /**
   * 幸运飞艇
   */
  /// 开奖记录
  static const luckyAirshipKjLog = "api/Xyft/kjLog";
  /// 玩法获取
  static const luckyAirshipGetPlay = "api/Xyft/getPlay";
  /// 开奖时间
  static const luckyAirshipGetKjtime = "api/Xyft/getKjtime";
  /// 计算注数
  static const luckyAirshipGdBets = "api/Xyft/gdBets";
  /// 下注接口
  static const luckyAirshipOrderAdd = "api/Xyft/orderAdd";


}