
import 'dart:math';

class GameConstant {
  /// 广东 11 选 5
  /**
   * gd 广东
   * 11  11 选 5
   * 5   11 选 5
   * 1 三码 2 二码
   * 3 直选  复式
   */
  static const gd11_5_1_3 = "GD11513";
  /// 直选 单式
  static const gd11_5_1_4 = "GD11514";
  /// 组选 复式
  static const gd11_5_1_6 = "GD11516";
  /// 组选 单式
  static const gd11_5_1_5 = "GD11515";

  /**
   * gd 广东
   * 11  11 选 5
   * 5   11 选 5
   * 2 二码
   * 10 直选  复式
   */
  static const gd11_5_2_10 = "GD115210";
  /// 直选 单式
  static const gd11_5_2_11 = "GD115211";
  /// 组选 单式
  static const gd11_5_2_36 = "GD115236";
  /// 组选 复式
  static const gd11_5_2_35 = "GD115235";

  /**
   * gd 广东
   * 11  11 选 5
   * 5   11 选 5
   * 3 不定胆
   * 13 前三位
   */
  static const gd11_5_3_13 = "GD115313";

  /**
   * gd 广东
   * 11  11 选 5
   * 5   11 选 5
   * 4 定位胆
   * 15 定位胆
   */
  static const gd11_5_4_15 = "GD115415";

  /**
   * gd 广东
   * 11  11 选 5
   * 5   11 选 5
   * 5 任选
   * 19 单式 一中一
   */
  static const gd11_5_5_19 = "GD115519";
  /// 20 单式 二中二
  static const gd11_5_5_20 = "GD115520";
  /// 21 单式 三中三
  static const gd11_5_5_21 = "GD115521";
  /// 22 单式 四中四
  static const gd11_5_5_22 = "GD115522";
  /// 23 单式 五中五
  static const gd11_5_5_23 = "GD115523";
  /// 24 单式 六中五
  static const gd11_5_5_24 = "GD115524";
  /// 25 单式 七中五
  static const gd11_5_5_25 = "GD115525";
  /// 26 单式 八中五
  static const gd11_5_5_26 = "GD115526";

  /// 27 复式 一中一
  static const gd11_5_5_27 = "GD115527";
  /// 28 复式 二中二
  static const gd11_5_5_28 = "GD115528";
  /// 29 复式 三中三
  static const gd11_5_5_29 = "GD115529";
  /// 30 复式 四中四
  static const gd11_5_5_30 = "GD115530";
  /// 31 复式 五中五
  static const gd11_5_5_31 = "GD115531";
  /// 32 复式 六中五
  static const gd11_5_5_32 = "GD115532";
  /// 33 复式 七中五
  static const gd11_5_5_33 = "GD115533";
  /// 34 复式 八中五
  static const gd11_5_5_34 = "GD115534";

  /**
   * 获取任选玩法方式
   */
  String gbChoiceNumType(String title, int playModeSingleOrDouble) {
    String typeStr;
    if (playModeSingleOrDouble == 2) {
      switch(title) {
        /// 复式
        case "一中一":
          typeStr = gd11_5_5_27;
          break;
        case "二中二":
          typeStr = gd11_5_5_28;
          break;
        case "三中三":
          typeStr = gd11_5_5_29;
          break;
        case "四中四":
          typeStr = gd11_5_5_30;
          break;
        case "五中五":
          typeStr = gd11_5_5_31;
          break;
        case "六中五":
          typeStr = gd11_5_5_32;
          break;
        case "七中五":
          typeStr = gd11_5_5_33;
          break;
        case "八中五":
          typeStr = gd11_5_5_34;
          break;
      }
    } else {
      switch(title) {
        /// 单式
        case "一中一":
          typeStr = gd11_5_5_19;
          break;
        case "二中二":
          typeStr = gd11_5_5_20;
          break;
        case "三中三":
          typeStr = gd11_5_5_21;
          break;
        case "四中四":
          typeStr = gd11_5_5_22;
          break;
        case "五中五":
          typeStr = gd11_5_5_23;
          break;
        case "六中五":
          typeStr = gd11_5_5_24;
          break;
        case "七中五":
          typeStr = gd11_5_5_25;
          break;
        case "八中五":
          typeStr = gd11_5_5_26;
          break;
      }
    }
    return typeStr;
  }

  /**
   * 获取任选 玩法ID
   */
  String getGD11Choice5PlayID(String title) {
    String playID;
    switch(title) {
    /// 复式
      case gd11_5_5_27:
        playID = "29";
        break;
      case gd11_5_5_28:
        playID = "30";
        break;
      case gd11_5_5_29:
        playID = "31";
        break;
      case gd11_5_5_30:
        playID = "32";
        break;
      case gd11_5_5_31:
        playID = "33";
        break;
      case gd11_5_5_32:
        playID = "34";
        break;
      case gd11_5_5_33:
        playID = "35";
        break;
      case gd11_5_5_34:
        playID = "36";
        break;
    /// 单式
      case gd11_5_5_19:
        playID = "21";
        break;
      case gd11_5_5_20:
        playID = "22";
        break;
      case gd11_5_5_21:
        playID = "23";
        break;
      case gd11_5_5_22:
        playID = "24";
        break;
      case gd11_5_5_23:
        playID = "25";
        break;
      case gd11_5_5_24:
        playID = "26";
        break;
      case gd11_5_5_25:
        playID = "27";
        break;
      case gd11_5_5_26:
        playID = "28";
        break;
    }
    return playID;
  }


}
