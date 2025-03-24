// lib/models/period.dart
import 'package:json_annotation/json_annotation.dart';

part 'period.g.dart';

/// 具体时间段
@JsonSerializable()
class Period {
  /// 开始时间（距离00:00的秒数）
  final int start;

  /// 结束时间（距离00:00的秒数）
  final int end;

  Period({required this.start, required this.end});

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodToJson(this);

  static Period get allDay => Period(start: 0, end: 86400);
  static Period get am => Period(start: 0, end: 43200);
  static Period get pm => Period(start: 43200, end: 86400);
  static Period fromHour(
    int hour, [
    int minute = 0,
    Duration duration = const Duration(hours: 1),
  ]) {
    var start = hour * 3600;
    return Period(start: start, end: start + duration.inSeconds);
  }
}
