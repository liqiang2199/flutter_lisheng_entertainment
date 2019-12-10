
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'BankDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'BankListBeen.g.dart';

@JsonSerializable()
class BankListBeen extends BaseJson {

  List<BankDataBeen> data;

  BankListBeen(this.data);

  factory BankListBeen.fromJson(Map<String, dynamic> json) => _$BankListBeenFromJson(json);

}