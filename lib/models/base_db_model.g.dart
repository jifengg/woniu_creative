// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDbModel _$BaseDbModelFromJson(Map<String, dynamic> json) => BaseDbModel(
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<String, DateTime>(
    json['updated_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
);

Map<String, dynamic> _$BaseDbModelToJson(BaseDbModel instance) =>
    <String, dynamic>{
      'created_at': _$JsonConverterToJson<String, DateTime>(
        instance.createdAt,
        const CustomDateTimeFormatter().toJson,
      ),
      'updated_at': _$JsonConverterToJson<String, DateTime>(
        instance.updatedAt,
        const CustomDateTimeFormatter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
