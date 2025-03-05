import 'package:json_annotation/json_annotation.dart';
import 'package:woniu_creative/models/play_list.dart';
import 'position.dart';

part 'layout_config.g.dart';

/// 布局配置
@JsonSerializable()
class LayoutConfig {
  /// 坐标定位配置
  final Position position;

  final PlayList playList;

  /// 背景颜色（16进制颜色值）
  final int? backgroundColor;

  LayoutConfig({
    required this.position,
    required this.playList,
    this.backgroundColor,
  });

  factory LayoutConfig.fromJson(Map<String, dynamic> json) =>
      _$LayoutConfigFromJson(json);
  Map<String, dynamic> toJson() => _$LayoutConfigToJson(this);
}
