
import 'package:json_annotation/json_annotation.dart';
part 'UpLoadFileResultDataBeen.g.dart';

@JsonSerializable()
class UpLoadFileResultDataBeen {
  String url;

  UpLoadFileResultDataBeen(this.url);
  factory UpLoadFileResultDataBeen.fromJson(Map<String, dynamic> json) => _$UpLoadFileResultDataBeenFromJson(json);
}