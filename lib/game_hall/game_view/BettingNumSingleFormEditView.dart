import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_bridge/Choose11And5EditContentHandle.dart';

/**
 * 投注 11 选 5 单式 输入框
 */
class BettingNumSingleFormEditView extends StatelessWidget{



  final int singleFormNum;//单式 判断输入多少加一个 分隔符号
  final String editContent;// 传入输入的内容
  final Choose11And5EditContentHandle contentHandle;

  BettingNumSingleFormEditView(
      {
        Key key,
        this.singleFormNum = 3,
        this.editContent = "",
        this.contentHandle
      }
  ) : super(key: key);

  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (!TextUtil.isEmpty(editContent)) {
      stringBuffer.write(editContent);
    }

    textEditingController.text = editContent;
    textEditingController.selection = new TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: editContent.length));

    return new Container(
      padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
      child: new Column(
        children: <Widget>[

          _bettingExplainTip(),
          _bettingNumEdit(),
        ],
      ),
    );
  }

  /// 投注说明
  Widget _bettingExplainTip() {

    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        _bettingExplainText(StringUtil.bettingExplainTitle),
        _bettingExplainText(StringUtil.bettingExplainOne),
        _bettingExplainText(StringUtil.bettingExplainTwo),
        _bettingExplainText(StringUtil.bettingExplainThree),

      ],
    );
  }

  Widget _bettingExplainText(String title) {

    return new Container(
      alignment: Alignment.centerLeft,
      child: new Text(
        title,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(ColorUtil.textColor_333333),
        ),
      ),
    );
  }

  /// 号码输入框
  Widget _bettingNumEdit() {

    return new Container(
      height: 145.0,
      margin: EdgeInsets.only(top: 15.0,),
      padding: EdgeInsets.only(right: 5.0,left: 5.0,),
      alignment: Alignment.topLeft,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(ColorUtil.lineColor), width: 1), // 边色与边宽度
        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 14, color: Color(ColorUtil.textColor_333333)),
              decoration: InputDecoration(
                hintText: "",
                contentPadding: const EdgeInsets.only(top: 0.0, bottom: 13.5),
                border: InputBorder.none,
                hoverColor: Color(ColorUtil.whiteColor),
                hintStyle: TextStyle(fontSize: 14.0, color: Color(ColorUtil.textColor_888888)),
                labelStyle: TextStyle(fontSize: 14.0, color: Color(ColorUtil.textColor_333333)),
              ),
              controller: textEditingController,
              onChanged: _editContentHandle,

            ),
          ),

        ],

      ),
    );
  }
  StringBuffer stringBuffer = new StringBuffer();
  /// 处理 数据
  _editContentHandle(String str) {

    if (TextUtil.isEmpty(str)) {
      //刷新界面
      textEditingController.clear();
      return;
    }

    if (str.startsWith("2")) {
      //刷新界面  不接收当前的输入内容
      textEditingController.clear();
      return;
    }

    var length = stringBuffer.toString().split(",").length;
//    int length = (editLength~/6);
    print("分割 长度 $length");
    int le = singleFormNum * 2 * length + (length -1);


    if(str.length == le) {
      StringBuffer stringBufferStr = new StringBuffer();

      stringBufferStr.write(str);
      stringBufferStr.write(",");
      print("截取输入数字 ${stringBufferStr.toString()}");

      List<String> numList = new List();
      bool isRepeat = false;

      /// 判断分割的号码是否存在相同 和里面数字 不合理的
      var split = stringBufferStr.toString().split(",");
      if (split.length >= 2) {
        var split2 = split[split.length -2];
        for (int i = 0; i < split2.length; i = i+2) {
          String subStr = split2.substring(i,i+2);
          if (double.parse(subStr) > 12) {
            isRepeat = true;
            break;
          }
          numList.add(subStr);
        }
      }

      if (!isRepeat) {
        /// 当前的 输入号码重复
        for (int n = 0; n < numList.length; n++) {
          for (int n1 = 0; n1 < numList.length; n1++) {
            if(n == n1){
              continue;
            }
            if (numList[n] == numList[n1]) {
              isRepeat = true;
              break;
            }
          }
        }

        /// 当前内容 和先前的有重复
        var splitAfter = stringBuffer.toString().split(",");

        for (int s = 0; s < splitAfter.length; s++) {
          for (int sp = (splitAfter.length - 1); sp < split.length; sp++) {
            if(TextUtil.isEmpty(splitAfter[s]) || TextUtil.isEmpty(split[sp])) {
              continue;
            }
            if (splitAfter[s] == split[sp]) {
              /// 当前输入的位数 前面有
              isRepeat = true;
              break;
            }
          }
        }
      }

      if(!isRepeat) {
        print("分割${stringBufferStr.toString().split(",")}");
        if (contentHandle != null) {
          contentHandle.editContent11Choose5Handle(stringBufferStr.toString());
        }
      } else {
        if (contentHandle != null) {
          contentHandle.editContent11Choose5Handle(stringBuffer.toString());
        }
      }

    } else {
      var strVal = str.replaceAll(",", "");
      var editLength = strVal.length;
      int b = editLength ~/ 6;
      int yushu = editLength % 6;
      if (yushu == 0) {
        b = (editLength / 3 - 1).toInt();
        yushu = 6;
      }
      String strAfter;
      for (int i = 0; i < b; i++) {
        strAfter = strAfter + str.substring(0, yushu) + "," + str.substring(yushu, 6);
        strVal = strVal.substring(6, strVal.length);
      }
      strAfter = strAfter + strVal;
//      if(editLength > 6 && editLength % 6 == 0) {
//        var strToSix = stringBuffer.toString()+",";
//        str = strToSix + str.substring(editLength - 1, editLength);
//
//      }
      if (contentHandle != null) {
//        contentHandle.editContent11Choose5Handle(str);
        contentHandle.editContent11Choose5Handle(strAfter);
      }
    }

  }

}