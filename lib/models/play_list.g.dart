// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayList _$PlayListFromJson(Map<String, dynamic> json) => PlayList(
  id: (json['id'] as num?)?.toInt(),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => PlayItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  playMode: (json['play_mode'] as num?)?.toInt() ?? 1,
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
  'items': instance.items,
  'play_mode': instance.playMode,
  'default_delay': instance.defaultDelay,
};
