
import 'TeamAccountChangeDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamAccountChangeDataBeen.g.dart';

@JsonSerializable()
class TeamAccountChangeDataBeen {

  List<TeamAccountChangeDataListBeen> data;
  int count;

  TeamAccountChangeDataBeen(this.data, this.count);

  factory TeamAccountChangeDataBeen.fromJson(Map<String, dynamic> json) => _$TeamAccountChangeDataBeenFromJson(json);
}