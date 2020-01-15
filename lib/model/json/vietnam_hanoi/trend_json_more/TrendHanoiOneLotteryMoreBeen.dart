
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'TrendHanoiOneLotteryMoreDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TrendHanoiOneLotteryMoreBeen.g.dart';

@JsonSerializable()
class TrendHanoiOneLotteryMoreBeen extends BaseJson{

  List<TrendHanoiOneLotteryMoreDataBeen> data;

  TrendHanoiOneLotteryMoreBeen(this.data);

  factory TrendHanoiOneLotteryMoreBeen.fromJson(Map<String, dynamic> json) => _$TrendHanoiOneLotteryMoreBeenFromJson(json);
}