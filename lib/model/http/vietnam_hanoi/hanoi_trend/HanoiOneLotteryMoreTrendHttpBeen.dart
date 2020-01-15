import 'package:json_annotation/json_annotation.dart';
part 'HanoiOneLotteryMoreTrendHttpBeen.g.dart';

@JsonSerializable()
class HanoiOneLotteryMoreTrendHttpBeen {
  String token;
  String limmit;
  ///(0=>五星，1=>后四，2=>前四，3=后三，4=前三，5=后二，6=前二)
  String address;

  HanoiOneLotteryMoreTrendHttpBeen();

  factory HanoiOneLotteryMoreTrendHttpBeen.fromJson(Map<String, dynamic> json) => _$HanoiOneLotteryMoreTrendHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$HanoiOneLotteryMoreTrendHttpBeenToJson(this);
}