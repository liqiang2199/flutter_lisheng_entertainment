
import 'package:dio/dio.dart';
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/login/LoginBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';

@RestApi(baseUrl: UrlUtil.BaseUrl)
abstract class ApiService {

  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;



  @POST(UrlUtil.login)
  Future<LoginHttpBeen> login(@Body() LoginHttpBeen task);

}

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= UrlUtil.BaseUrl;
  }

  final Dio _dio;

  String baseUrl;

  _getHeaders () {
    return {
      'Accept':'application/json, text/plain, */*',
      'Content-Type':'application/json',
    };
  }

  /**
   * 发送Post 网络请求
   * jsonData 传入的 json 数据
   */
  Future<Map<String, dynamic>> responseResult(Map<String, dynamic> jsonData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(jsonData ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(UrlUtil.login,
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: _getHeaders (),
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    print(_result.data);

    return _result.data;
  }

  @override
  Future<LoginHttpBeen> login(LoginHttpBeen task) async {
    ArgumentError.checkNotNull(task, '参数为空');

    responseResult(task.toJson()).then((onValue) {
      var loginDataBeen = LoginBeen.fromJson(onValue);
      print("token = ${loginDataBeen.toString()}");
    });

    var value = LoginHttpBeen.fromJson(<String, dynamic>{});
    return Future.value(value);
  }

}
