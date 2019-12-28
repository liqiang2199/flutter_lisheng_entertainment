
import 'GetBettingRecordDataListParamBeen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GetBettingRecordDataListBeen.g.dart';

@JsonSerializable()
class GetBettingRecordDataListBeen {
  int id;
  int user_id;
  int lottery_id;
  int paly_id;
  int multiple;//倍数
  String ordercode;
  String jg_money;
  String pre_draw_issue;
  String xz_money;
  String kj_time;
  String remark;
  String status;
  String createtime;
  String play;
  String kj_num;
  int num;//注数
  String lottery_name;

  GetBettingRecordDataListParamBeen param;

  GetBettingRecordDataListBeen();

  factory GetBettingRecordDataListBeen.fromJson(Map<String, dynamic> json) => _$GetBettingRecordDataListBeenFromJson(json);
}