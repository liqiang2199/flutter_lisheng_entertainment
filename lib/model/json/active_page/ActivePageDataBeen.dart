import 'package:json_annotation/json_annotation.dart';
part 'ActivePageDataBeen.g.dart';

@JsonSerializable()
class ActivePageDataBeen {

  int id;
  String status;
  String title;
  String image;
  String content;
  String createtime;
  String updatetime;

  ActivePageDataBeen(this.id, this.status, this.title, this.image, this.content,
      this.createtime, this.updatetime);

  factory ActivePageDataBeen.fromJson(Map<String, dynamic> json) => _$ActivePageDataBeenFromJson(json);

}