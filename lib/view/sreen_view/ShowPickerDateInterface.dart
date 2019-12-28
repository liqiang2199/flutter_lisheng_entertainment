
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_picker/Picker.dart';

import 'ChoiceTimeResultInterface.dart';

abstract class ShowPickerDateInterface {

  static int StartTimeType = 0;
  static int EndTimeType = 1;

  /// choiceTimeType == 0 开始时间， 1 结束时间
  showPickerDateTime(BuildContext context, ChoiceTimeResultInterface timeResultInterface, int choiceTimeType) {
    new Picker(
        adapter: new DateTimePickerAdapter(
          type: PickerDateTimeType.kYMD,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日",
          //minValue: DateTime.now(),
          // twoDigitYear: true,
        ),
        //title: new Text("Select DateTime"),
        textAlign: TextAlign.right,
        selectedTextStyle: TextStyle(color: Color(ColorUtil.textColor_333333)),
//        delimiter: [
//          PickerDelimiter(column: 3, child: Container(
//            width: 16.0,
//            alignment: Alignment.center,
//            //child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
//            color: Colors.white,
//          ))
//        ],
//        footer: Container(
//          height: 50.0,
//          alignment: Alignment.center,
//          child: Text('Footer'),
//        ),
        onConfirm: (Picker picker, List value) {
          print(picker.adapter.text);
          if (timeResultInterface != null) {
            var dateStr = DateUtil.formatDateStr(picker.adapter.toString(), format: DataFormats.y_mo_d);
            timeResultInterface?.choiceTime(dateStr, choiceTimeType);
          }
        },
        textStyle: TextStyle(color: Color(ColorUtil.textColor_888888)),
        cancelText: "取消",
        cancelTextStyle: new TextStyle(
          fontSize: 16.0,
          color: Color(ColorUtil.textColor_333333),
        ),
        confirmText: "确定",
        confirmTextStyle: new TextStyle(
          fontSize: 16.0,
          color: Color(ColorUtil.textColor_333333),
        ),
        onSelect: (Picker picker, int index, List<int> selecteds) {
          print("picker.adapter.toString() ${picker.adapter.toString()}");
          if (timeResultInterface != null) {
            var dateStr = DateUtil.formatDateStr(picker.adapter.toString(), format: DataFormats.y_mo_d);
            timeResultInterface?.choiceTime(dateStr, choiceTimeType);
          }
//          this.setState(() {
//            stateText = picker.adapter.toString();
//          });

        }
    ).showModal(context);
  }
}