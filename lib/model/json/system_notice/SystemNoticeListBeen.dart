
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'SystemNoticeDataBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SystemNoticeListBeen.g.dart';

@JsonSerializable()
class SystemNoticeListBeen extends BaseJson{

  List<SystemNoticeDataBeen> data;

  SystemNoticeListBeen(this.data);

  factory SystemNoticeListBeen.fromJson(Map<String, dynamic> json) => _$SystemNoticeListBeenFromJson(json);


}