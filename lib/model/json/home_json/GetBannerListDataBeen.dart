import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';

import 'GetBannerDataBeen.dart';
part 'GetBannerListDataBeen.g.dart';

@JsonSerializable()
class GetBannerListDataBeen extends BaseJson{

  List<GetBannerDataBeen> data;

  GetBannerListDataBeen(this.data);

  factory GetBannerListDataBeen.fromJson(Map<String, dynamic> json) => _$GetBannerListDataBeenFromJson(json);


}