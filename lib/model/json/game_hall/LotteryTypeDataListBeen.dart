
import 'LotteryTypeDataListLotteryBeen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LotteryTypeDataListBeen.g.dart';

@JsonSerializable()
class LotteryTypeDataListBeen {

  int id;
  String name;
  List<LotteryTypeDataListLotteryBeen> lottery;

  LotteryTypeDataListBeen(this.id, this.name, this.lottery);

  factory LotteryTypeDataListBeen.fromJson(Map<String, dynamic> json) => _$LotteryTypeDataListBeenFromJson(json);



}