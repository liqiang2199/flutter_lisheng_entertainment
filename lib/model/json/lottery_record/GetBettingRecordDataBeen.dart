import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'GetBettingRecordDataListBeen.dart';

import 'package:json_annotation/json_annotation.dart';

part 'GetBettingRecordDataBeen.g.dart';

@JsonSerializable()
class GetBettingRecordDataBeen extends BaseJson{

  int count;
  List<GetBettingRecordDataListBeen> data;

  GetBettingRecordDataBeen(this.count, this.data);
  factory GetBettingRecordDataBeen.fromJson(Map<String, dynamic> json) => _$GetBettingRecordDataBeenFromJson(json);

}