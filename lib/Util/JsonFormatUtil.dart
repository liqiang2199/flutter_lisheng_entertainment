
import 'package:flutter_lisheng_entertainment/model/http/LoginHttpBeen.dart';

/**
 * 转化json
 */
LoginHttpBeen loginHttpJson(Map<String, dynamic> json) {
  return LoginHttpBeen(
    account: json['account'] as String,
    pwd: json['pwd'] as String,
  );
}


Map<String, dynamic> loginJson(LoginHttpBeen instance) => <String, dynamic>{
  'account': instance.account,
  'pwd': instance.pwd,
};