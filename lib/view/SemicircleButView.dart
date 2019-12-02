import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/StringUtil.dart';
import 'package:flutter_lisheng_entertainment/view/view_interface/SemicircleButCallBack.dart';

class SemicircleButView extends StatelessWidget {

  final SemicircleButCallBack butCallBack;
  final String title;

  const SemicircleButView(
      this.butCallBack,
      {Key key, this.title}
      ) :assert(
      butCallBack != null,
  ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _butLoginView();
  }


  Widget _butLoginView() {
    return new Container(
      width: 300.0,
      height: 45.0  ,
      child: new RaisedButton(onPressed: (){
        if (butCallBack != null) {
          butCallBack.onPressedBut();
        }
      },color: Color(ColorUtil.butColor),
        child: new Text(this.title
          , style: TextStyle(fontSize: 16.0,color: Color(ColorUtil.whiteColor)),),
        //shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
        shape: new StadiumBorder(side: new BorderSide(
          //设置 界面效果
          color: Color(ColorUtil.butColor),
          style: BorderStyle.none,
        ),),
      ),
    );
  }

}