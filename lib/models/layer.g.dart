// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Layer _$LayerFromJson(Map<String, dynamic> json) => Layer(
  id: (json['id'] as num?)?.toInt(),
  layerName: json['layer_name'] as String,
  layoutConfigs:
      (json['layout_config'] as List<dynamic>)
          .map((e) => LayoutConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: const CustomDateTimeFormatter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const CustomDateTimeFormatter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$LayerToJson(Layer instance) => <String, dynamic>{
  'created_at': const CustomDateTimeFormatter().toJson(instance.createdAt),
  'updated_at': const CustomDateTimeFormatter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'layer_name': instance.layerName,
  'layout_config': instance.layoutConfigs,
};
