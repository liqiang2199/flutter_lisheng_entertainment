

abstract class GameCommonService {

  String stringAppend(List<String> list) {
    StringBuffer numStr = new StringBuffer();
    list.forEach((value){
      numStr.write(value);
      numStr.write(",");
    });
    String numS = "";
    if (numStr.length > 0) {
      numS = numStr.toString().substring(0, numStr.length - 1);
    }
    return numS;
  }

  // 单式 计算 加 ，
  String stringSingleAppend(List<String> list) {
    StringBuffer numStr = new StringBuffer();
    list.forEach((value){
      var length = value.length;
      for (int i = 0; i < length; i++) {
        numStr.write(value.substring(i, i + 1));
        if (i != length - 1) {
          numStr.write(",");
        }

      }

      numStr.write(";");
    });
    String numS = "";
    if (numStr.length > 0) {
      numS = numStr.toString().substring(0, numStr.length - 1);
    }
    return numS;
  }
}