import 'package:json_annotation/json_annotation.dart';
part 'CpOpenLotteryInfoHttp.g.dart';

@JsonSerializable()
class CpOpenLotteryInfoHttp {
  String token;
  String lottery;

  CpOpenLotteryInfoHttp(this.token, this.lottery);

  factory CpOpenLotteryInfoHttp.fromJson(Map<String, dynamic> json) => _$CpOpenLotteryInfoHttpFromJson(json);

  Map<String, dynamic> toJson() => _$CpOpenLotteryInfoHttpToJson(this);

}