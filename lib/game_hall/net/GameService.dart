
import 'package:flustars/flustars.dart';
import 'package:flutter_lisheng_entertainment/Util/Constant.dart';
import 'package:flutter_lisheng_entertainment/model/http/BaseTokenHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/RetrofitManager.dart';

import 'PlayMode11Choice5Handler.dart';

class GameService {

  static GameService get instance => _getInstance();
  static GameService _instance;

  // 私有构造函数
  GameService._internal() {
    // 初始化
  }

  static GameService _getInstance() {
    if(_instance == null) {
      _instance = new GameService._internal();
    }
    return _instance;
  }


  /**
   * 玩法获取
   */
  void getPlay(PlayMode11Choice5Handler playMode11Choice5Handler) {

    ApiService apiService = RetrofitManager.instance.createApiService();
    BaseTokenHttpBeen baseTokenHttpBeen = new BaseTokenHttpBeen(SpUtil.getString(Constant.TOKEN));
    apiService.setHandler(playMode11Choice5Handler);
    apiService.getPlay(baseTokenHttpBeen);
  }

}