import 'package:json_annotation/json_annotation.dart';
part 'HanoiOneLotterySingleTrendHttpBeen.g.dart';

@JsonSerializable()
class HanoiOneLotterySingleTrendHttpBeen {
  String token;
  String limmit;
  ///(0=>万位，1=>千位，2=>百位，3=十位，4=个位)
  String address;

  HanoiOneLotterySingleTrendHttpBeen();
  factory HanoiOneLotterySingleTrendHttpBeen.fromJson(Map<String, dynamic> json) => _$HanoiOneLotterySingleTrendHttpBeenFromJson(json);

  Map<String, dynamic> toJson() => _$HanoiOneLotterySingleTrendHttpBeenToJson(this);

}