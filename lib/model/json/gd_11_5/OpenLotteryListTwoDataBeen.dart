import 'package:json_annotation/json_annotation.dart';

import 'OpenLotteryListTwoDataListBeen.dart';

part 'OpenLotteryListTwoDataBeen.g.dart';

@JsonSerializable()
class OpenLotteryListTwoDataBeen {
  List<OpenLotteryListTwoDataListBeen> data;

  OpenLotteryListTwoDataBeen(this.data);

  factory OpenLotteryListTwoDataBeen.fromJson(Map<String, dynamic> json) => _$OpenLotteryListTwoDataBeenFromJson(json);

}