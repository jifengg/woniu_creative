// lib/models/layer.dart
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'layer.g.dart';

/// 展示层配置
@JsonSerializable()
class Layer extends BaseOwnerModel{
  /// 层唯一ID
  final int? id;

  /// 层名称
  @JsonKey(name: 'layer_name')
  final String layerName;

  /// 布局配置
  @JsonKey(name: 'layout_config')
  final List<LayoutConfig> layoutConfigs;

  Layer({
    this.id,
    required this.layerName,
    required this.layoutConfigs,
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LayerToJson(this);
}