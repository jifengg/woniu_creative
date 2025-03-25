// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDbModel _$BaseDbModelFromJson(Map<String, dynamic> json) => BaseDbModel(
  createdAt: const NullableDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const NullableDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$BaseDbModelToJson(
  BaseDbModel instance,
) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
};
