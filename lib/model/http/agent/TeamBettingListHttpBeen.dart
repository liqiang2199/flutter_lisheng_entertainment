import 'package:json_annotation/json_annotation.dart';
part 'TeamBettingListHttpBeen.g.dart';
/// 团队投注
@JsonSerializable()
class TeamBettingListHttpBeen {
   String token;
   String username;
   String limit;
   String page;
   String lottery_id;
   String status;
   String pre_draw_issue;
   String kj_time;
   String start_date;
   String end_date;

   TeamBettingListHttpBeen(this.token, this.username, this.limit, this.page,
       this.lottery_id, this.status, this.pre_draw_issue, this.kj_time);
   factory TeamBettingListHttpBeen.fromJson(Map<String, dynamic> json) => _$TeamBettingListHttpBeenFromJson(json);

   Map<String, dynamic> toJson() => _$TeamBettingListHttpBeenToJson(this);

}