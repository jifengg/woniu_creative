// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Layer _$LayerFromJson(Map<String, dynamic> json) => Layer(
  id: (json['id'] as num).toInt(),
  layerName: json['layer_name'] as String,
  layoutConfigs:
      (json['layout_config'] as List<dynamic>)
          .map((e) => LayoutConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$LayerToJson(Layer instance) => <String, dynamic>{
  'id': instance.id,
  'layer_name': instance.layerName,
  'layout_config': instance.layoutConfigs,
};
