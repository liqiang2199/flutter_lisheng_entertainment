
import 'AccountChangeRecordDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AccountChangeRecordDataBeen.g.dart';

@JsonSerializable()
class AccountChangeRecordDataBeen {

  List<AccountChangeRecordDataListBeen> data;
  int count;

  AccountChangeRecordDataBeen(this.data, this.count);

  factory AccountChangeRecordDataBeen.fromJson(Map<String, dynamic> json) => _$AccountChangeRecordDataBeenFromJson(json);
}