
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'LotteryTypeDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LotteryTypeDataBeen.g.dart';

@JsonSerializable()
class LotteryTypeDataBeen extends BaseJson{

  List<LotteryTypeDataListBeen> data;


  LotteryTypeDataBeen();

  factory LotteryTypeDataBeen.fromJson(Map<String, dynamic> json) => _$LotteryTypeDataBeenFromJson(json);


}