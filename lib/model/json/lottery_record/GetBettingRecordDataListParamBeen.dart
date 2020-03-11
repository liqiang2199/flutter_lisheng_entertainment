import 'package:json_annotation/json_annotation.dart';

part 'GetBettingRecordDataListParamBeen.g.dart';

@JsonSerializable()
class GetBettingRecordDataListParamBeen {

  String one_num;
  String two_num;
  String three_num;
  String four_num;
  String five_num;
  String six_num;//幸运飞艇
  String seven_num;//幸运飞艇
  String eight_num;//幸运飞艇
  String nine_num;//幸运飞艇
  String ten_num;//幸运飞艇
  String data_num;
  String num_type;//幸运飞艇

  GetBettingRecordDataListParamBeen(this.one_num, this.two_num, this.three_num,
      this.data_num);
  factory GetBettingRecordDataListParamBeen.fromJson(Map<String, dynamic> json) => _$GetBettingRecordDataListParamBeenFromJson(json);

}