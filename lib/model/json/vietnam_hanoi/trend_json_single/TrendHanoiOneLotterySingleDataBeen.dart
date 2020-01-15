import 'TrendHanoiOneLotterySingleReDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TrendHanoiOneLotterySingleDataBeen.g.dart';

@JsonSerializable()
class TrendHanoiOneLotterySingleDataBeen {
  List<TrendHanoiOneLotterySingleReDataBeen> re_data;

  TrendHanoiOneLotterySingleDataBeen(this.re_data);

  factory TrendHanoiOneLotterySingleDataBeen.fromJson(Map<String, dynamic> json) => _$TrendHanoiOneLotterySingleDataBeenFromJson(json);
}
