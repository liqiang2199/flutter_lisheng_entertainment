import 'package:json_annotation/json_annotation.dart';
part 'LinkAccountListBeen.g.dart';

@JsonSerializable()
class LinkAccountListBeen {

  int id;
  String voucher;
  String url;
  int day;
  String ratio;
  String is_dali;
  String createtime;
  String expirationtime;

  LinkAccountListBeen(this.id, this.voucher, this.url, this.day, this.ratio,
      this.is_dali, this.createtime, this.expirationtime);

  factory LinkAccountListBeen.fromJson(Map<String, dynamic> json) => _$LinkAccountListBeenFromJson(json);

}