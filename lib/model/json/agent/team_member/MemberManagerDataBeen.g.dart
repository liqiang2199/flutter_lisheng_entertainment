// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MemberManagerDataBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberManagerDataBeen _$MemberManagerDataBeenFromJson(
    Map<String, dynamic> json) {
  return MemberManagerDataBeen(
    (json['userlist'] as List)
        ?.map((e) => e == null
            ? null
            : MemberManagerDataListBeen.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$MemberManagerDataBeenToJson(
        MemberManagerDataBeen instance) =>
    <String, dynamic>{
      'userlist': instance.userlist,
      'count': instance.count,
    };
