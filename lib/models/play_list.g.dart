// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayList _$PlayListFromJson(Map<String, dynamic> json) => PlayList(
  items:
      (json['items'] as List<dynamic>)
          .map((e) => PlayItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  playMode: (json['playMode'] as num?)?.toInt() ?? 1,
  defaultDelay: (json['defaultDelay'] as num?)?.toInt() ?? 3000,
);

Map<String, dynamic> _$PlayListToJson(PlayList instance) => <String, dynamic>{
  'items': instance.items,
  'playMode': instance.playMode,
  'defaultDelay': instance.defaultDelay,
};
