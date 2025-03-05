// lib/models/layer.dart
import 'package:json_annotation/json_annotation.dart';
import 'layout_config.dart';

part 'layer.g.dart';

/// 展示层配置
@JsonSerializable()
class Layer {
  /// 层唯一ID
  final int id;

  /// 层名称
  @JsonKey(name: 'layer_name')
  final String layerName;

  /// 布局配置
  @JsonKey(name: 'layout_config')
  final List<LayoutConfig> layoutConfigs;

  Layer({
    required this.id,
    required this.layerName,
    required this.layoutConfigs,
  });

  factory Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);
  Map<String, dynamic> toJson() => _$LayerToJson(this);
}