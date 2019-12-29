 import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';

import 'MemberManagerDataBeen.dart';
 import 'package:json_annotation/json_annotation.dart';
 part 'MemberManagerBeen.g.dart';

 @JsonSerializable()
class MemberManagerBeen extends BaseJson{

  MemberManagerDataBeen data;

  MemberManagerBeen(this.data);
  factory MemberManagerBeen.fromJson(Map<String, dynamic> json) => _$MemberManagerBeenFromJson(json);

}