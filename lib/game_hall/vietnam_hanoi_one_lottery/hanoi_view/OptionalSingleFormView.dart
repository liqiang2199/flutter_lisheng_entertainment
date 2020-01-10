
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/game_hall/game_view/ThousandsOfBitsView.dart';

/**
 * 任选单式
 */
///
class OptionalSingleFormView extends StatefulWidget {

  OptionalSingleFormView(Key key): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OptionalSingleFormStateView();
  }

}

class OptionalSingleFormStateView extends BaseController<OptionalSingleFormView> {

  List<int> editNumList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,];
  Set<int> _randomSet = new Set();// 保存随机数

  TextEditingController textEditingController = new TextEditingController();

  int singleFormNum = 3;//单式 判断输入多少加一个 分隔符号
  String editContent = "";// 传入输入的内容
  int singleFormTotalNum = 3;// 当前输入总数
  int singleFormMaxNum = 9;// 当前彩种最大彩票数
  int singleFormBaseNum = 1;// 当前彩种基数 （11 选5 = 2， 河内一分彩  = 1）（根据彩种的最大数位数决定）
  StringBuffer stringBuffer = new StringBuffer();

  GlobalKey<ThousandsOfBitsStateView> _bitsStateViewKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    stringBuffer.clear();
    if (!TextUtil.isEmpty(editContent)) {
      stringBuffer.write(editContent);
    }
    textEditingController.text = editContent;
    textEditingController.selection = new TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: editContent.length));

    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Column(
        children: <Widget>[

          ThousandsOfBitsView(_bitsStateViewKey),
          _bettingNumEdit(),

        ],
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

  _editContentHandle(String str) {
    if (TextUtil.isEmpty(str)) {
      //刷新界面
      textEditingController.clear();
      return;
    }

    print("输入数字： $str");
    var length = stringBuffer.toString().split(",").length;
//    int length = (editLength~/6);
//    print("分割 长度 $length");
    int le = singleFormNum * singleFormBaseNum * length + (length -1);


    if(str.length == le) {
      StringBuffer stringBufferStr = new StringBuffer();

      stringBufferStr.write(str);
      stringBufferStr.write(",");
      print("截取输入数字 ${stringBufferStr.toString()}");

      List<String> numList = new List();
      bool isRepeat = false;

      /// 判断分割的号码是否存在相同 和里面数字 不合理的
      var split = stringBufferStr.toString().split(",");


      if (!isRepeat) {

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
          if (isRepeat) {
            break;
          }
        }

      }

      if(!isRepeat) {
        print("分割${stringBufferStr.toString().split(",")}");
        editContent = stringBufferStr.toString();
      } else {
        stringBuffer.clear();
        split.toSet().forEach((value){
          stringBuffer.write("$value");
          stringBuffer.write(",");
        });
        editContent = stringBuffer.toString();
      }

    } else {
      print("输入数字 长度不够： $str");
      var strVal = str.replaceAll(",", "");
      var editLength = strVal.length;
      int b = editLength ~/ singleFormTotalNum;
      if (editLength >= singleFormTotalNum) {
        int yushu = editLength % singleFormTotalNum;
        if (yushu == 0) {
          b = (editLength / singleFormTotalNum - 1).toInt();
          yushu = singleFormTotalNum;
        }
        print("editLength $editLength");
        String strAfter = "";
        String strBefore = strVal;
        if (str.length % (singleFormTotalNum + 1) == 0) {
          if (editLength > singleFormTotalNum) {
            for (int i = 1; i <= editLength; i++) {
              if (i != 0 && i % singleFormTotalNum == 0) {
                strAfter = strAfter + strVal.substring(i - singleFormTotalNum, i) + "," ;
              }
            }
            String strAfterReplaceAll = strAfter.replaceAll(",", "");

            if ((editLength - strAfterReplaceAll.length) > 0) {
              strAfter = strAfter + strVal.substring(strAfterReplaceAll.length, editLength);
            }

          } else {
            strAfter = strVal;
          }


          editContent = strAfter;

        } else {
          editContent = str;
        }

      } else {
        editContent = strVal;
      }

      var isRepeat = false;

      /// 当前内容
      var split = editContent.toString().split(",");
      /// 当前内容 和先前的有重复
      var splitAfter = stringBuffer.toString().split(",");

      print("splitAfter  = $splitAfter");

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


      if (!isRepeat) {

      } else {
        stringBuffer.clear();
        split.toSet().forEach((value){
          stringBuffer.write("$value");
        });
        editContent = stringBuffer.toString();
      }

    }
    if (mounted)
      setState(() {

      });
  }

  /**
   * id 彩票 玩法ID
   * randomNum 随机个数
   */
  ///
  randomEditAndCheckState(int id, int randomNum) {
    //editNumList
    singleFormNum = randomNum;
    singleFormTotalNum = randomNum;

    _randomSet.clear();
    while (_randomSet.length < randomNum) {
      var randomIndex = Random().nextInt(9);
      _randomSet.add(randomIndex);
    }

    StringBuffer stringBuffer = new StringBuffer();
    _randomSet?.toList()?.forEach((value){
      stringBuffer.write("${editNumList[value]}");
    });
    stringBuffer.write(",");
    this.stringBuffer = stringBuffer;
    editContent = "${stringBuffer.toString()}";
    _bitsStateViewKey.currentState.randomThousandsOfBitsStateRefresh(id);

//    if(mounted)
//      setState(() {
//
//      });
  }

}