
import 'package:json_annotation/json_annotation.dart';
part 'UserReportDataBeen.g.dart';

@JsonSerializable()
class UserReportDataBeen {
   String userTx;
   String userJg;
   String userHd;
   String userCz;
   String userTz;
   String userFd;
   String userYk;

   UserReportDataBeen();

   factory UserReportDataBeen.fromJson(Map<String, dynamic> json) => _$UserReportDataBeenFromJson(json);

}