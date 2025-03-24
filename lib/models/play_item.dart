import 'package:json_annotation/json_annotation.dart';
import 'material_info.dart';

part 'play_item.g.dart';

/// 布局配置
@JsonSerializable()
class PlayItem {
  /// 素材
  final MaterialInfo material;

  /// 持续时间，单位毫秒。如果为空，则使用
  final int? duration;

  PlayItem({required this.material, this.duration});

  factory PlayItem.fromJson(Map<String, dynamic> json) =>
      _$PlayItemFromJson(json);
  Map<String, dynamic> toJson() => _$PlayItemToJson(this);
}
