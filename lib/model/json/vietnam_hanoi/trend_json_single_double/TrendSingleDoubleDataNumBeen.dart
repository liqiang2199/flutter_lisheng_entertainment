import 'package:json_annotation/json_annotation.dart';
part 'TrendSingleDoubleDataNumBeen.g.dart';

@JsonSerializable()
class TrendSingleDoubleDataNumBeen {
  String code;
  String ds;
  String dx;

  TrendSingleDoubleDataNumBeen(this.code, this.ds);
  factory TrendSingleDoubleDataNumBeen.fromJson(Map<String, dynamic> json) => _$TrendSingleDoubleDataNumBeenFromJson(json);
}