
import 'package:flutter_lisheng_entertainment/model/json/BaseJson.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PlayMode11Choice5Been.g.dart';

@JsonSerializable()
class PlayMode11Choice5Been extends BaseJson{
  String data;

  PlayMode11Choice5Been(this.data);
  factory PlayMode11Choice5Been.fromJson(Map<String, dynamic> json) => _$PlayMode11Choice5BeenFromJson(json);

}

