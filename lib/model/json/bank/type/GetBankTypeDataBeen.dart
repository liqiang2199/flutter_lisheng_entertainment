
import 'package:json_annotation/json_annotation.dart';
part 'GetBankTypeDataBeen.g.dart';

@JsonSerializable()
class GetBankTypeDataBeen {
  int id;
  String name;
  String image;

  GetBankTypeDataBeen(this.id, this.name, this.image);
  factory GetBankTypeDataBeen.fromJson(Map<String, dynamic> json) => _$GetBankTypeDataBeenFromJson(json);

}