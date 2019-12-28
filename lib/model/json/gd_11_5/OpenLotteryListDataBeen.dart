
import '../BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'OpenLotteryListTwoDataBeen.dart';
part 'OpenLotteryListDataBeen.g.dart';

@JsonSerializable()
class OpenLotteryListDataBeen extends BaseJson {
  OpenLotteryListTwoDataBeen data;

  OpenLotteryListDataBeen(this.data);
  factory OpenLotteryListDataBeen.fromJson(Map<String, dynamic> json) => _$OpenLotteryListDataBeenFromJson(json);

}