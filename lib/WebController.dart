

import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'view/common/CommonView.dart';

/**
 * 网页
 */
///
class WebController extends StatefulWidget {

  final String webUrl;

  const WebController({
    Key key,
    this.webUrl
  }) : super(key: key);

  @override
  createState() {
    // TODO: implement createState
    return WebStateController(this.webUrl);
  }
}

class WebStateController extends BaseController<WebController> {

  String webUrl;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  WebStateController(this.webUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: CommonView().commonAppBar(context, "与客服聊天"),
      body: WebView(
        initialUrl: TextUtil.isEmpty(webUrl) ? "${UrlUtil.BaseUrl}serviceindex/index/index" : "https://www.baidu.com",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest request) {
          // 判断URL
//          if (request.url.startsWith('https://www.baidu.com')) {
//            // 做一些事情
//            // 阻止进入登录页面
//            return NavigationDecision.prevent;
//          }
          return NavigationDecision.navigate;
        },
        javascriptChannels: <JavascriptChannel>[
          _toasterJavascriptChannel(context),
        ].toSet(),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}