
import 'MemberManagerDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MemberManagerDataBeen.g.dart';

@JsonSerializable()
class MemberManagerDataBeen {

  List<MemberManagerDataListBeen> userlist;
  int count;

  MemberManagerDataBeen(this.userlist, this.count);
  factory MemberManagerDataBeen.fromJson(Map<String, dynamic> json) => _$MemberManagerDataBeenFromJson(json);

}