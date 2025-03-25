// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialInfo _$MaterialInfoFromJson(Map<String, dynamic> json) => MaterialInfo(
  id: (json['id'] as num?)?.toInt(),
  type: $enumDecode(_$MaterialTypesEnumMap, json['type']),
  version: (json['version'] as num?)?.toInt(),
  url: json['url'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  content: json['content'] as String?,
  fileExtension: json['file_extension'] as String?,
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: const NullableDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const NullableDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$MaterialInfoToJson(
  MaterialInfo instance,
) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'type': _$MaterialTypesEnumMap[instance.type]!,
  'version': instance.version,
  'url': instance.url,
  'file_extension': instance.fileExtension,
  'duration': instance.duration,
  'content': instance.content,
};

const _$MaterialTypesEnumMap = {
  MaterialTypes.text: 1,
  MaterialTypes.image: 2,
  MaterialTypes.video: 3,
  MaterialTypes.audio: 4,
  MaterialTypes.link: 5,
};
