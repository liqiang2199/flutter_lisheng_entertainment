
import 'package:flutter_lisheng_entertainment/model/json/login/LoginBeen.dart';
import 'package:flutter_lisheng_entertainment/net/BaseHandler.dart';

abstract class LoginHandler extends BaseHandler {

  /**
   * 登录成功
   */
  void loginSuccess(bool result,LoginBeen loginBeen );

  /**
   * 登录失败
   */
  void loginFail(bool result);

}