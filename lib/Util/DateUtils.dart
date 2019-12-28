
import 'package:flustars/flustars.dart';

class DateUtils {

  static String formatLongToTimeStrToDay(String time) {

    var today = DateTime.now();
    var date1 = today.millisecondsSinceEpoch;
    var dateTime = DateTime.parse("$time");
    int date = DateUtil.getDateMsByTimeStr("$time");
//    var date = dateTime.millisecondsSinceEpoch;

    var dateValue = (date - date1) - 8 * 60 * 60 * 1000;
    String dateStrByMs = DateUtil.getDateStrByMs(date1);
    //print("dateStrByMs: "+dateStrByMs.toString());

    String dateStrBy = DateUtil.getDateStrByMs(dateValue.toInt() ,format: DateFormat.HOUR_MINUTE_SECOND);
    //print("dateStrByMs: "+dateStrBy.toString());

//    var day = dateValue / (60 * 60 * 24);
//    var hour = (dateValue / (60 * 60)) - (day * 24);
//    var min = dateValue / 60 - day * 24 * 60 - hour * 60;
//    var s = dateValue - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60;


    return "$dateStrBy";

  }
}