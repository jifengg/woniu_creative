// lib/models/period.dart
import 'package:json_annotation/json_annotation.dart';

part 'period.g.dart';

/// 具体时间段
@JsonSerializable()
class Period {
  /// 开始时间（HH:mm）
  final String start;

  /// 结束时间（HH:mm）
  final String end;

  Period({required this.start, required this.end});

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodToJson(this);
}