// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyTimeConfig _$DailyTimeConfigFromJson(Map<String, dynamic> json) =>
    DailyTimeConfig(
      periods:
          (json['periods'] as List<dynamic>)
              .map((e) => Period.fromJson(e as Map<String, dynamic>))
              .toList(),
      start: const DateTimeConverter().fromJson(json['start'] as String),
      end: const DateTimeConverter().fromJson(json['end'] as String),
    );

Map<String, dynamic> _$DailyTimeConfigToJson(DailyTimeConfig instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'periods': instance.periods,
    };

WeeklyTimeConfig _$WeeklyTimeConfigFromJson(Map<String, dynamic> json) =>
    WeeklyTimeConfig(
      daysOfWeek:
          (json['daysOfWeek'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      periods:
          (json['periods'] as List<dynamic>)
              .map((e) => Period.fromJson(e as Map<String, dynamic>))
              .toList(),
      start: const DateTimeConverter().fromJson(json['start'] as String),
      end: const DateTimeConverter().fromJson(json['end'] as String),
    );

Map<String, dynamic> _$WeeklyTimeConfigToJson(WeeklyTimeConfig instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'periods': instance.periods,
      'daysOfWeek': instance.daysOfWeek,
    };

MonthlyTimeConfig _$MonthlyTimeConfigFromJson(Map<String, dynamic> json) =>
    MonthlyTimeConfig(
      daysOfMonth:
          (json['daysOfMonth'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      periods:
          (json['periods'] as List<dynamic>)
              .map((e) => Period.fromJson(e as Map<String, dynamic>))
              .toList(),
      start: const DateTimeConverter().fromJson(json['start'] as String),
      end: const DateTimeConverter().fromJson(json['end'] as String),
    );

Map<String, dynamic> _$MonthlyTimeConfigToJson(MonthlyTimeConfig instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'periods': instance.periods,
      'daysOfMonth': instance.daysOfMonth,
    };

YearlyTimeConfig _$YearlyTimeConfigFromJson(Map<String, dynamic> json) =>
    YearlyTimeConfig(
      monthDays:
          (json['monthDays'] as List<dynamic>)
              .map((e) => MonthDay.fromJson(e as Map<String, dynamic>))
              .toList(),
      periods:
          (json['periods'] as List<dynamic>)
              .map((e) => Period.fromJson(e as Map<String, dynamic>))
              .toList(),
      start: const DateTimeConverter().fromJson(json['start'] as String),
      end: const DateTimeConverter().fromJson(json['end'] as String),
    );

Map<String, dynamic> _$YearlyTimeConfigToJson(YearlyTimeConfig instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'periods': instance.periods,
      'monthDays': instance.monthDays,
    };

MonthDay _$MonthDayFromJson(Map<String, dynamic> json) => MonthDay(
  month: (json['month'] as num).toInt(),
  day: (json['day'] as num).toInt(),
);

Map<String, dynamic> _$MonthDayToJson(MonthDay instance) => <String, dynamic>{
  'month': instance.month,
  'day': instance.day,
};

CustomTimeConfig _$CustomTimeConfigFromJson(Map<String, dynamic> json) =>
    CustomTimeConfig(
      dateRanges:
          (json['date_ranges'] as List<dynamic>?)
              ?.map((e) => DateTimeRange.fromJson(e as Map<String, dynamic>))
              .toList(),
      periods:
          (json['periods'] as List<dynamic>)
              .map((e) => Period.fromJson(e as Map<String, dynamic>))
              .toList(),
      start: const DateTimeConverter().fromJson(json['start'] as String),
      end: const DateTimeConverter().fromJson(json['end'] as String),
    );

Map<String, dynamic> _$CustomTimeConfigToJson(CustomTimeConfig instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'periods': instance.periods,
      'date_ranges': instance.dateRanges,
    };

DateTimeRange _$DateTimeRangeFromJson(Map<String, dynamic> json) =>
    DateTimeRange(
      start: const DateTimeConverter().fromJson(json['start'] as String),
      end: const DateTimeConverter().fromJson(json['end'] as String),
    );

Map<String, dynamic> _$DateTimeRangeToJson(DateTimeRange instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
    };
