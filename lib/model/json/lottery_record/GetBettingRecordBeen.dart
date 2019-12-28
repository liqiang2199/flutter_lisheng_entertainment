import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:flutter_lisheng_entertainment/model/json/lottery_record/GetBettingRecordDataBeen.dart';

import 'package:json_annotation/json_annotation.dart';

part 'GetBettingRecordBeen.g.dart';

@JsonSerializable()
class GetBettingRecordBeen extends BaseJson{

  GetBettingRecordDataBeen data;

  GetBettingRecordBeen(this.data);
  factory GetBettingRecordBeen.fromJson(Map<String, dynamic> json) => _$GetBettingRecordBeenFromJson(json);

}