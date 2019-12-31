
import 'TeamReportFormDataListBeen.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TeamReportFormDataBeen.g.dart';

@JsonSerializable()
class TeamReportFormDataBeen {

  List<TeamReportFormDataListBeen> data;
  int count;

  TeamReportFormDataBeen(this.data, this.count);

  factory TeamReportFormDataBeen.fromJson(Map<String, dynamic> json) => _$TeamReportFormDataBeenFromJson(json);
}