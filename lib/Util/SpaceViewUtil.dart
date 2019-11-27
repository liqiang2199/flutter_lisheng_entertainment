
import 'package:flutter/material.dart';

class SpaceViewUtil {

  static Widget pading_Left(double leftD) {
    return new Container(
      padding: EdgeInsets.only(left: leftD),
    );
  }

  static Widget pading_Top_10() {
    return new Container(
      padding: EdgeInsets.only(top: 10.0),
    );
  }

  static Widget pading_Left_10() {
    return new Container(
      padding: EdgeInsets.only(left: 10.0),
    );
  }

  static Widget pading_Right_10() {
    return new Container(
      padding: EdgeInsets.only(right: 10.0),
    );
  }

  static Widget pading_Bottom_10() {
    return new Container(
      padding: EdgeInsets.only(bottom: 10.0),
    );
  }

}