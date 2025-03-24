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
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<String, DateTime>(
    json['updated_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
);

Map<String, dynamic> _$LayerToJson(Layer instance) => <String, dynamic>{
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
  'layer_name': instance.layerName,
  'layout_config': instance.layoutConfigs,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
