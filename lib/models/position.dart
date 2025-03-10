// lib/models/position.dart
import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

/// 坐标定位
@JsonSerializable()
class Position {
  /// X轴坐标百分比（0-100）
  final double x;

  /// Y轴坐标百分比（0-100）
  final double y;

  /// 宽度百分比（0-100）
  final double w;

  /// 高度百分比（0-100）
  final double h;

  Position({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);

  static Position get fullscreen => Position(x: 0, y: 0, w: 1, h: 1);
  static Position get halfLeft => Position(x: 0, y: 0, w: 0.5, h: 1);
  static Position get halfRight => Position(x: 0.5, y: 0, w: 0.5, h: 1);
  static Position get halfTop => Position(x: 0, y: 0, w: 1, h: 0.5);
  static Position get halfBottom => Position(x: 0, y: 0.5, w: 1, h: 0.5);
  static Position get leftTop => Position(x: 0, y: 0, w: 0.5, h: 0.5);
  static Position get rightTop => Position(x: 0.5, y: 0, w: 0.5, h: 0.5);
  static Position get leftBottom => Position(x: 0, y: 0.5, w: 0.5, h: 0.5);
  static Position get rightBottom => Position(x: 0.5, y: 0.5, w: 0.5, h: 0.5);
}
