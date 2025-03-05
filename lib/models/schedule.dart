// lib/models/schedule.dart
import 'package:json_annotation/json_annotation.dart';
import 'period.dart';

part 'schedule.g.dart';

/// 时段配置
@JsonSerializable()
class Schedule {
  /// 星期几（1-7）
  final int day;

  /// 具体时间段列表
  final List<Period> periods;

  Schedule({required this.day, required this.periods});

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}