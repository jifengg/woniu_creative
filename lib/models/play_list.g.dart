// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayList _$PlayListFromJson(Map<String, dynamic> json) => PlayList(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String? ?? 'playlist',
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => PlayItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  playMode:
      $enumDecodeNullable(_$PlayModeEnumMap, json['play_mode']) ??
      PlayMode.order,
  defaultDelay: (json['default_delay'] as num?)?.toInt() ?? 3000,
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: const NullableDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const NullableDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$PlayListToJson(PlayList instance) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'name': instance.name,
  'items': instance.items,
  'play_mode': _$PlayModeEnumMap[instance.playMode]!,
  'default_delay': instance.defaultDelay,
};

const _$PlayModeEnumMap = {PlayMode.order: 1, PlayMode.random: 2};
