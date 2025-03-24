import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'play_item.g.dart';

/// 布局配置
@JsonSerializable()
class PlayItem extends BaseOwnerModel {
  /// ID
  final int? id;

  /// 素材
  final MaterialInfo material;

  /// 持续时间，单位毫秒。如果为空，则使用
  final int? duration;

  PlayItem({
    this.id,
    required this.material,
    this.duration,
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory PlayItem.fromJson(Map<String, dynamic> json) =>
      _$PlayItemFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PlayItemToJson(this);
}
