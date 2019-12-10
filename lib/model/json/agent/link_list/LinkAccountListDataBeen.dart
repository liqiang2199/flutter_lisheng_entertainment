
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'LinkAccountListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'LinkAccountListDataBeen.g.dart';

@JsonSerializable()
class LinkAccountListDataBeen extends BaseJson{

  List<LinkAccountListBeen> data;

  LinkAccountListDataBeen(this.data);

  factory LinkAccountListDataBeen.fromJson(Map<String, dynamic> json) => _$LinkAccountListDataBeenFromJson(json);


}