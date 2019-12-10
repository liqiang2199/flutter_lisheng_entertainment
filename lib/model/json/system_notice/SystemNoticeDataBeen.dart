import 'package:json_annotation/json_annotation.dart';
part 'SystemNoticeDataBeen.g.dart';

@JsonSerializable()
class SystemNoticeDataBeen {
  int id;
  String status;
  String title;
  String content;
  String createtime;
  String updatetime;

  SystemNoticeDataBeen(this.id, this.status, this.title, this.content,
      this.createtime, this.updatetime);

  factory SystemNoticeDataBeen.fromJson(Map<String, dynamic> json) => _$SystemNoticeDataBeenFromJson(json);


}