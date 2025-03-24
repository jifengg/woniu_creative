import 'package:json_annotation/json_annotation.dart';
import 'enums.dart';
import 'period.dart';
import 'custom_formatter.dart';

part 'time_config.g.dart';

const _$TimeConfigTypeEnumMap = {
  TimeConfigType.daily: 1,
  TimeConfigType.weekly: 2,
  TimeConfigType.monthly: 3,
  TimeConfigType.yearly: 4,
  TimeConfigType.custom: 9,
};

/// 时间配置
class TimeConfig {
  /// 时间类型
  final TimeConfigType type;

  /// 有效日期范围，开始日期
  final DateTime start;

  /// 有效日期范围，结束日期
  final DateTime end;

  /// 时段配置列表
  final List<Period> periods;

  TimeConfig({
    required this.type,
    required this.periods,
    required this.start,
    required this.end,
  });

  factory TimeConfig.fromJson(Map<String, dynamic> json) {
    var type = $enumDecode(_$TimeConfigTypeEnumMap, json['type']);
    switch (type) {
      case TimeConfigType.daily:
        return DailyTimeConfig.fromJson(json);
      case TimeConfigType.weekly:
        return WeeklyTimeConfig.fromJson(json);
      case TimeConfigType.monthly:
        return MonthlyTimeConfig.fromJson(json);
      case TimeConfigType.yearly:
        return YearlyTimeConfig.fromJson(json);
      case TimeConfigType.custom:
        return CustomTimeConfig.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map;
    switch (type) {
      case TimeConfigType.daily:
        map = (this as DailyTimeConfig).toJson();
        break;
      case TimeConfigType.weekly:
        map = (this as WeeklyTimeConfig).toJson();
        break;
      case TimeConfigType.monthly:
        map = (this as MonthlyTimeConfig).toJson();
        break;
      case TimeConfigType.yearly:
        map = (this as YearlyTimeConfig).toJson();
        break;
      case TimeConfigType.custom:
        map = (this as CustomTimeConfig).toJson();
        break;
    }
    return map;
  }

  Map<String, dynamic> fixJson(Map<String, dynamic> map) {
    map["type"] = _$TimeConfigTypeEnumMap[type];
    return map;
  }

  /// 基础时间匹配逻辑
  bool isTimeMatch(DateTime time) {
    final nowSeconds = time.hour * 3600 + time.minute * 60 + time.second;
    return periods.any(
      (range) => nowSeconds >= range.start && nowSeconds <= range.end,
    );
  }

  static TimeConfig get everyDay => DailyTimeConfig(
    periods: [Period.allDay],
    start: DateTime(2000),
    end: DateTime(3000),
  );
}

/// 每日配置
@JsonSerializable()
@CustomDateTimeFormatter()
class DailyTimeConfig extends TimeConfig {
  DailyTimeConfig({
    required super.periods,
    required super.start,
    required super.end,
  }) : super(type: TimeConfigType.daily);

  factory DailyTimeConfig.fromJson(Map<String, dynamic> json) =>
      _$DailyTimeConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => fixJson(_$DailyTimeConfigToJson(this));
}

/// 每周配置
@JsonSerializable()
@CustomDateTimeFormatter()
class WeeklyTimeConfig extends TimeConfig {
  final List<int> daysOfWeek;

  WeeklyTimeConfig({
    required this.daysOfWeek,
    required super.periods,
    required super.start,
    required super.end,
  }) : super(type: TimeConfigType.weekly);

  factory WeeklyTimeConfig.fromJson(Map<String, dynamic> json) =>
      _$WeeklyTimeConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => fixJson(_$WeeklyTimeConfigToJson(this));
  @override
  bool isTimeMatch(DateTime time) {
    return daysOfWeek.contains(time.weekday) && super.isTimeMatch(time);
  }
}

/// 每月配置
@JsonSerializable()
@CustomDateTimeFormatter()
class MonthlyTimeConfig extends TimeConfig {
  final List<int> daysOfMonth;

  MonthlyTimeConfig({
    required this.daysOfMonth,
    required super.periods,
    required super.start,
    required super.end,
  }) : super(type: TimeConfigType.monthly);

  factory MonthlyTimeConfig.fromJson(Map<String, dynamic> json) =>
      _$MonthlyTimeConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => fixJson(_$MonthlyTimeConfigToJson(this));

  @override
  bool isTimeMatch(DateTime time) {
    return daysOfMonth.contains(time.day) && super.isTimeMatch(time);
  }
}

@JsonSerializable()
@CustomDateTimeFormatter()
class YearlyTimeConfig extends TimeConfig {
  final List<MonthDay> monthDays;

  YearlyTimeConfig({
    required this.monthDays,
    required super.periods,
    required super.start,
    required super.end,
  }) : super(type: TimeConfigType.yearly);

  factory YearlyTimeConfig.fromJson(Map<String, dynamic> json) =>
      _$YearlyTimeConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => fixJson(_$YearlyTimeConfigToJson(this));
}

/// 定义一个包含月日的类
@JsonSerializable()
class MonthDay {
  final int month;
  final int day;

  MonthDay({required this.month, required this.day});

  factory MonthDay.fromJson(Map<String, dynamic> json) =>
      _$MonthDayFromJson(json);
  Map<String, dynamic> toJson() => _$MonthDayToJson(this);
}

/// 自定义配置（使用具体日期时间对）
@JsonSerializable()
@CustomDateTimeFormatter()
class CustomTimeConfig extends TimeConfig {
  @JsonKey(name: 'date_ranges')
  final List<DateTimeRange>? dateRanges;

  CustomTimeConfig({
    this.dateRanges,
    required super.periods,
    required super.start,
    required super.end,
  }) : super(type: TimeConfigType.custom);

  factory CustomTimeConfig.fromJson(Map<String, dynamic> json) =>
      _$CustomTimeConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => fixJson(_$CustomTimeConfigToJson(this));
}

@JsonSerializable()
@CustomDateTimeFormatter()
class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange({required this.start, required this.end});
  factory DateTimeRange.fromJson(Map<String, dynamic> json) =>
      _$DateTimeRangeFromJson(json);
  Map<String, dynamic> toJson() => _$DateTimeRangeToJson(this);
}
