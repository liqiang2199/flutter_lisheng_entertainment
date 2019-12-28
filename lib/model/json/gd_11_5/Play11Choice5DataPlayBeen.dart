import 'package:json_annotation/json_annotation.dart';
part 'Play11Choice5DataPlayBeen.g.dart';

@JsonSerializable()
class Play11Choice5DataPlayBeen {

  int id;
  int lottery_id;
  int play_id;
  String name;
  String is_group;
  String status;
  String money_award;
  String money;
  String remark;
  bool isChoice = false;
  bool isChoiceType = false; /// 彩票选中类型
  int playMode;///
  int playModeSingleOrDouble;//单式或者复式 (1 或者 2. 0 既不是单式也不是复式)1 三码 2 二码 3 不定胆 4 定胆位 5 任选
  bool isGroupSelection = false;// 是否是直选 还是 组选 。true 为组选
  int groupSelectionNum = 1;// 如果是组选 组选数量 1 表示一组 默认就有一组
  String playModeTitle;/// 选号 玩法标识

  Play11Choice5DataPlayBeen(this.id, this.lottery_id, this.play_id, this.name,
      this.is_group, this.status, this.money_award, this.money, this.remark);

  factory Play11Choice5DataPlayBeen.fromJson(Map<String, dynamic> json) => _$Play11Choice5DataPlayBeenFromJson(json);

  Map<String, dynamic> toJson() => _$Play11Choice5DataPlayBeenToJson(this);


}