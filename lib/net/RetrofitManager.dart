import 'package:dio/dio.dart';
import 'package:flutter_lisheng_entertainment/net/ApiService.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:retrofit/retrofit.dart';


/**
 * 网络请求工具
 */
@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
class RetrofitManager {

//  factory RetrofitManager(Dio dio, {String baseUrl}) =  _getInstance();
  static RetrofitManager get instance => _getInstance();
  static RetrofitManager _instance;

  // 私有构造函数
  RetrofitManager._internal() {
    // 初始化

    _httpOptions();
  }

  static RetrofitManager _getInstance() {
    if(_instance == null) {
      _instance = new RetrofitManager._internal();
    }
    return _instance;
  }
  Dio _clientDio;

  _httpOptions() {
    BaseOptions options = new BaseOptions();
    options.baseUrl = UrlUtil.BaseUrl;
    options.headers = _getHeaders();
    options.receiveTimeout = 1000 * 10;
    options.sendTimeout = 1000 * 5;
    _clientDio = new Dio();
    _clientDio.options = options;
  }

  _getHeaders () {
    return {
      'Accept':'application/json, text/plain, */*',
      'Content-Type':'application/json',
    };
  }

  /**
   * 创建 ApiService
   */
  ApiService createApiService() {
    if(_instance == null) {
      _instance = new RetrofitManager._internal();
    }
    if (_clientDio == null) {
      _httpOptions();
    }
    ApiService apiService = new ApiService(_clientDio);
    return apiService;
  }

}
