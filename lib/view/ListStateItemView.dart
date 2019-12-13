
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/ImageUtil.dart';
import 'package:flutter_lisheng_entertainment/Util/SpaceViewUtil.dart';

/// 公用的向右 界面 (带有向右的箭头  和 右的状态选择)
class ListStateItemView extends StatelessWidget {

  final bool isSwitch;// switch 开关
  final bool isRightArrow;//向右的箭头
  final bool isRightText;//右侧的文本提示
  final bool isLeftIcon;//是否有左侧图标

  final String leftIcon;//左侧图标
  final String rightIcon;//右侧图标 （当isRightArrow = true）一定不为空
  final String title;//左侧图标
  final String rightText;//右侧文字说明
  final double imgW;
  final double imgH;

  final bool isCupertino;//是否打开
  final bool isSetImgWh ;//是否设置左边图片宽高

  final ValueChanged<bool> onChanged;


  const ListStateItemView(this.title,{
    Key key,
    this.isSwitch = false,
    this.isRightArrow = false,
    this.isRightText = false,
    this.leftIcon,
    this.isLeftIcon = false,
    this.rightIcon,
    this.onChanged,
    this.isCupertino,
    this.rightText,
    this.isSetImgWh = false,
    this.imgW,
    this.imgH,
  }
    )
      : assert(
  title != null,
  isRightArrow? rightIcon != null: rightIcon == null
  ), super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _stateView();
  }

  Widget _stateView() {

    if (this.isSwitch && !this.isRightArrow && !this.isRightText && this.isLeftIcon) {
      //含有switch 开关
      return _haveSwitch();

    } else if (!this.isSwitch && this.isRightArrow && !this.isRightText && !this.isSetImgWh) {

      return _haveRightArrow();
    } else if (!this.isSwitch && !this.isRightArrow && this.isRightText && !this.isSetImgWh) {

    } else if (!this.isSwitch && this.isRightArrow && this.isRightText && !this.isSetImgWh) {
      return _haveRightArrowAndRightText();
    } else if (this.isSwitch && !this.isRightArrow && !this.isRightText && !this.isLeftIcon && !this.isSetImgWh) {
      //含有switch 开关
      return _haveSwitchNoLeft();

    }else if (!this.isSwitch && this.isRightArrow && !this.isRightText && this.isSetImgWh) {
      // 能设置图片宽高
      return _haveRightArrowImgWHText();
    }

    if (this.isLeftIcon) {

    } else {

    }
  }

  /// 含有 Switch 开关
  Widget _haveSwitch() {

    return new Container(
      height: 53.0,
      child: new Row(
        children: <Widget>[
          SpaceViewUtil.pading_Left(10.0),
          Image.asset(this.leftIcon, width: 20.0, height: 20.0,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new Text(
              this.title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ),

          new CupertinoSwitch(
              value: this.isCupertino,
              //setState(() { _lights = value; });
              onChanged: (bool value) {
                onChanged(value);
              }
          ),
          SpaceViewUtil.pading_Right_10(),

        ],
      ),
    );
  }

  Widget _haveSwitchNoLeft() {

    return new Container(
      height: 53.0,
      child: new Row(
        children: <Widget>[
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new Text(
              this.title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ),

          new CupertinoSwitch(
              value: this.isCupertino,
              //setState(() { _lights = value; });
              onChanged: (bool value) {
                onChanged(value);
              }
          ),
          SpaceViewUtil.pading_Right_10(),

        ],
      ),
    );
  }

  /// 含有 向右 的箭头
  Widget _haveRightArrow() {

    return new Container(
      height: 53.0,
      child: new Row(
        children: <Widget>[
          SpaceViewUtil.pading_Left(10.0),
          Image.asset(this.leftIcon, width: 20.0, height: 20.0,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new Text(
              this.title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),
              ),
            ),
          ),
          //向右图标
          new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),
          SpaceViewUtil.pading_Right_10(),

        ],
      ),
    );
  }

  /// 含有 向右 的箭头 和 右边 文字说明
  Widget _haveRightArrowAndRightText() {

    return new Container(
      height: 53.0,
      child: new Row(
        children: <Widget>[
          SpaceViewUtil.pading_Left(10.0),
          Image.asset(this.leftIcon, width: 20.0, height: 20.0,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new Text(
              this.title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),

              ),
            ),
          ),
          new Text(
            this.rightText,
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(ColorUtil.textColor_333333),
            ),
          ),
          SpaceViewUtil.pading_Right_10(),
          //向右图标
          new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),
          SpaceViewUtil.pading_Right_10(),

        ],
      ),
    );
  }

  /**
   * 能设置图片宽高
   */
  Widget _haveRightArrowImgWHText() {

    return new Container(
      height: 53.0,
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          SpaceViewUtil.pading_Left(10.0),
          Image.asset(this.leftIcon, width: this.imgW, height: this.imgH,),
          SpaceViewUtil.pading_Left(10.0),
          new Expanded(
            child: new Text(
              this.title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(ColorUtil.textColor_333333),

              ),
            ),
          ),
          SpaceViewUtil.pading_Right_10(),
          //向右图标
          new Image.asset(ImageUtil.imgRightArrow, width: 18.0, height: 18.0,),
          SpaceViewUtil.pading_Right_10(),

        ],
      ),
    );
  }
}
