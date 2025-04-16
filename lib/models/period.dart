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

  @override
  String toString() {
    return '${_format(start)}-${_format(end)}';
  }

  factory Period.parse(String s) {
    var parts = s.split('-');
    return Period(start: _parse(parts[0].trim()), end: _parse(parts[1].trim()));
  }

  static int _parse(String s) {
    var parts = s.split(':');
    return int.parse(parts[0]) * 3600 +
        int.parse(parts[1]) * 60 +
        int.parse(parts[2]);
  }

  static String _format(int t) {
    return '${(t ~/ 3600).toString().padLeft(2, '0')}:${((t % 3600) ~/ 60).toString().padLeft(2, '0')}:${(t % 60).toString().padLeft(2, '0')}';
  }

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
