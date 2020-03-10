
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'UpLoadFileResultDataBeen.dart';

import 'package:json_annotation/json_annotation.dart';
part 'UpLoadFileResultBeen.g.dart';

@JsonSerializable()
class UpLoadFileResultBeen extends BaseJson{

  UpLoadFileResultDataBeen data;

  UpLoadFileResultBeen(this.data);

  factory UpLoadFileResultBeen.fromJson(Map<String, dynamic> json) => _$UpLoadFileResultBeenFromJson(json);
}