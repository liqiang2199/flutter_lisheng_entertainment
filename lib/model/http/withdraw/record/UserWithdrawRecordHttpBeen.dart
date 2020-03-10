
import 'package:json_annotation/json_annotation.dart';
part "UserWithdrawRecordHttpBeen.g.dart";
@JsonSerializable()
class UserWithdrawRecordHttpBeen {

  String token;
  String limit;
  int page;
  String status;
  String start_date;
  String end_date;

  UserWithdrawRecordHttpBeen(this.token, this.limit, this.status,
      this.start_date, this.end_date);

  factory UserWithdrawRecordHttpBeen.fromJson(Map<String, dynamic> json) => _$UserWithdrawRecordHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$UserWithdrawRecordHttpBeenToJson(this);


}