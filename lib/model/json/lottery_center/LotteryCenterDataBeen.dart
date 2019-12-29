import 'package:json_annotation/json_annotation.dart';

part 'LotteryCenterDataBeen.g.dart';

@JsonSerializable()
class LotteryCenterDataBeen {

  String name;
  int id;
  String frequency;
  int preDrawIssue;
  String preDrawTime;
  String preDrawCode;
  String drawTime;
  int drawIssue;
  String serverTime;

  LotteryCenterDataBeen();

  factory LotteryCenterDataBeen.fromJson(Map<String, dynamic> json) => _$LotteryCenterDataBeenFromJson(json);


}