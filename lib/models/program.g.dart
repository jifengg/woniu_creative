// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
  id: (json['id'] as num?)?.toInt(),
  programName: json['program_name'] as String,
  timeConfig:
      json['time_config'] == null
          ? null
          : TimeConfig.fromJson(json['time_config'] as Map<String, dynamic>),
  layers:
      (json['layers'] as List<dynamic>?)
          ?.map((e) => Layer.fromJson(e as Map<String, dynamic>))
          .toList(),
  priority: (json['priority'] as num?)?.toInt() ?? 1000,
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: const NullableDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const NullableDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'program_name': instance.programName,
  'time_config': instance.timeConfig,
  'priority': instance.priority,
  'layers': instance.layers,
};
