// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayItem _$PlayItemFromJson(Map<String, dynamic> json) => PlayItem(
  id: (json['id'] as num?)?.toInt(),
  material: MaterialInfo.fromJson(json['material'] as Map<String, dynamic>),
  duration: (json['duration'] as num?)?.toInt(),
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: const CustomDateTimeFormatter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const CustomDateTimeFormatter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$PlayItemToJson(PlayItem instance) => <String, dynamic>{
  'created_at': const CustomDateTimeFormatter().toJson(instance.createdAt),
  'updated_at': const CustomDateTimeFormatter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'material': instance.material,
  'duration': instance.duration,
};
