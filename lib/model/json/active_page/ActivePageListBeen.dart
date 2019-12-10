import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'ActivePageDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ActivePageListBeen.g.dart';

@JsonSerializable()
class ActivePageListBeen extends BaseJson{

  List<ActivePageDataBeen> data;

  ActivePageListBeen(this.data);

  factory ActivePageListBeen.fromJson(Map<String, dynamic> json) => _$ActivePageListBeenFromJson(json);

}