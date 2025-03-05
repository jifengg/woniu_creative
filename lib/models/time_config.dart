// lib/models/time_config.dart
import 'package:json_annotation/json_annotation.dart';
import 'schedule.dart';

part 'time_config.g.dart';

/// 时间配置
@JsonSerializable()
class TimeConfig {
  /// 时间类型（always/weekly/custom）
  final String type;

  /// 时段配置列表
  final List<Schedule> schedule;

  TimeConfig({required this.type, required this.schedule});

  factory TimeConfig.fromJson(Map<String, dynamic> json) =>
      _$TimeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$TimeConfigToJson(this);
}