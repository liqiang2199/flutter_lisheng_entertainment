
import 'package:json_annotation/json_annotation.dart';
part 'OpenAccountIntervalDataBeen.g.dart';

@JsonSerializable()
class OpenAccountIntervalDataBeen {

  String max_ratio;
  int gd_ratio;

  OpenAccountIntervalDataBeen(this.max_ratio, this.gd_ratio);

  factory OpenAccountIntervalDataBeen.fromJson(Map<String, dynamic> json) => _$OpenAccountIntervalDataBeenFromJson(json);
}