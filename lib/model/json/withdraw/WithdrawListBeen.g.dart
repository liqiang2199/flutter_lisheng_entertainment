// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WithdrawListBeen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawListBeen _$WithdrawListBeenFromJson(Map<String, dynamic> json) {
  return WithdrawListBeen(
    json['withdrawCount'] as int,
    json['withdrawAllmoney'] as String,
  );
}

Map<String, dynamic> _$WithdrawListBeenToJson(WithdrawListBeen instance) =>
    <String, dynamic>{
      'withdrawCount': instance.withdrawCount,
      'withdrawAllmoney': instance.withdrawAllmoney,
    };
