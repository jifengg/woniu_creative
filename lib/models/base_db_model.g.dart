// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDbModel _$BaseDbModelFromJson(Map<String, dynamic> json) => BaseDbModel(
  createdAt: const CustomDateTimeFormatter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const CustomDateTimeFormatter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$BaseDbModelToJson(BaseDbModel instance) =>
    <String, dynamic>{
      'created_at': const CustomDateTimeFormatter().toJson(instance.createdAt),
      'updated_at': const CustomDateTimeFormatter().toJson(instance.updatedAt),
    };
