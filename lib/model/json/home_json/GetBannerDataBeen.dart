
import 'package:json_annotation/json_annotation.dart';
part 'GetBannerDataBeen.g.dart';

@JsonSerializable()
class GetBannerDataBeen{
  int id;
  String image;
  String title;
  String url;
  int weigh;

  GetBannerDataBeen(this.id, this.image, this.title, this.url, this.weigh);

  factory GetBannerDataBeen.fromJson(Map<String, dynamic> json) => _$GetBannerDataBeenFromJson(json);

}