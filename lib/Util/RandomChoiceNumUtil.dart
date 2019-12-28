
import 'dart:math';

class RandomChoiceNumUtil {
  static List<String> cpNumStr = ["01","02","03","04","05","06","07","08","09","10","11"];
  /**
   * 随机号码 11 选 5
   */
  static List<String> randomNum11Choice5_3() {
    int index1 = Random().nextInt(11);
    int index2 = Random().nextInt(11);

    while(index1 == index2) {
      randomNum11Choice5_3();
      return null;
    }

    int index3 = Random().nextInt(11);
    while(index2 == index3) {
      randomNum11Choice5_3();
      return null;
    }

    while(index3 == index1) {
      randomNum11Choice5_3();
      return null;
    }
    List<String> strRandomSingle = ["${cpNumStr[index1]}${cpNumStr[index2]}${cpNumStr[index3]},"];
    return strRandomSingle;
  }

}