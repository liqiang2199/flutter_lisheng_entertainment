// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Play11Choice5DataPlayBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Play11Choice5DataPlayBeen _$Play11Choice5DataPlayBeenFromJson(
    Map<String, dynamic> json) {
  return Play11Choice5DataPlayBeen(
    json['id'] as int,
    json['lottery_id'] as int,
    json['play_id'] as int,
    json['name'] as String,
    json['is_group'] as String,
    json['status'] as String,
    json['money_award'] as String,
    json['money'] as String,
    json['remark'] as String,
  )
    ..isChoice = json['isChoice'] as bool
    ..isChoiceType = json['isChoiceType'] as bool
    ..playMode = json['playMode'] as int
    ..playModeSingleOrDouble = json['playModeSingleOrDouble'] as int
    ..isGroupSelection = json['isGroupSelection'] as bool
    ..groupSelectionNum = json['groupSelectionNum'] as int
    ..playModeTitle = json['playModeTitle'] as String;
}

Map<String, dynamic> _$Play11Choice5DataPlayBeenToJson(
        Play11Choice5DataPlayBeen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lottery_id': instance.lottery_id,
      'play_id': instance.play_id,
      'name': instance.name,
      'is_group': instance.is_group,
      'status': instance.status,
      'money_award': instance.money_award,
      'money': instance.money,
      'remark': instance.remark,
      'isChoice': instance.isChoice,
      'isChoiceType': instance.isChoiceType,
      'playMode': instance.playMode,
      'playModeSingleOrDouble': instance.playModeSingleOrDouble,
      'isGroupSelection': instance.isGroupSelection,
      'groupSelectionNum': instance.groupSelectionNum,
      'playModeTitle': instance.playModeTitle,
    };
