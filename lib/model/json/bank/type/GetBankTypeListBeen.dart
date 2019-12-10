
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'GetBankTypeDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'GetBankTypeListBeen.g.dart';

@JsonSerializable()
class GetBankTypeListBeen extends BaseJson {
  List<GetBankTypeDataBeen> data;

  GetBankTypeListBeen(this.data);
  factory GetBankTypeListBeen.fromJson(Map<String, dynamic> json) => _$GetBankTypeListBeenFromJson(json);

}