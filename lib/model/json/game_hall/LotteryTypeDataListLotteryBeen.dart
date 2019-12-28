import 'package:json_annotation/json_annotation.dart';

part 'LotteryTypeDataListLotteryBeen.g.dart';

@JsonSerializable()
class LotteryTypeDataListLotteryBeen {

  int id;
  String name;
  String image;
  bool isChoice = false;

  LotteryTypeDataListLotteryBeen(this.id, this.name, this.image);

  factory LotteryTypeDataListLotteryBeen.fromJson(Map<String, dynamic> json) => _$LotteryTypeDataListLotteryBeenFromJson(json);
  Map<String, dynamic> toJson() => _$LotteryTypeDataListLotteryBeenToJson(this);

}