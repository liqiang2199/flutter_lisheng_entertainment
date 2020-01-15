
import 'TrendHanoiOneLotterySingleDataBeen.dart';
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'TrendHanoiOneLotterySingleReDataBeen.dart';
part 'TrendHanoiOneLotterySingleBeen.g.dart';

@JsonSerializable()
class TrendHanoiOneLotterySingleBeen extends BaseJson{

  //TrendHanoiOneLotterySingleDataBeen data;
  List<TrendHanoiOneLotterySingleReDataBeen> data;

  TrendHanoiOneLotterySingleBeen(this.data);
  factory TrendHanoiOneLotterySingleBeen.fromJson(Map<String, dynamic> json) => _$TrendHanoiOneLotterySingleBeenFromJson(json);
}