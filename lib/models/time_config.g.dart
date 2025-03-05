// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeConfig _$TimeConfigFromJson(Map<String, dynamic> json) => TimeConfig(
  type: json['type'] as String,
  schedule:
      (json['schedule'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TimeConfigToJson(TimeConfig instance) =>
    <String, dynamic>{'type': instance.type, 'schedule': instance.schedule};
