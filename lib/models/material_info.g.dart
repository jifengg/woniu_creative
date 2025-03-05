// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialInfo _$MaterialInfoFromJson(Map<String, dynamic> json) => MaterialInfo(
  id: (json['id'] as num).toInt(),
  type: $enumDecode(_$MaterialTypesEnumMap, json['type']),
  url: json['url'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  content: json['content'] as String?,
);

Map<String, dynamic> _$MaterialInfoToJson(MaterialInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MaterialTypesEnumMap[instance.type]!,
      'url': instance.url,
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
