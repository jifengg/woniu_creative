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
}