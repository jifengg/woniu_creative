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
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<String, DateTime>(
    json['updated_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
);

Map<String, dynamic> _$PlayListToJson(PlayList instance) => <String, dynamic>{
  'created_at': _$JsonConverterToJson<String, DateTime>(
    instance.createdAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'updated_at': _$JsonConverterToJson<String, DateTime>(
    instance.updatedAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'items': instance.items,
  'play_mode': instance.playMode,
  'default_delay': instance.defaultDelay,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
