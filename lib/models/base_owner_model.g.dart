// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseOwnerModel _$BaseOwnerModelFromJson(Map<String, dynamic> json) =>
    BaseOwnerModel(
      ownerId: (json['owner_id'] as num?)?.toInt(),
      createdAt: _$JsonConverterFromJson<String, DateTime>(
        json['created_at'],
        const CustomDateTimeFormatter().fromJson,
      ),
      updatedAt: _$JsonConverterFromJson<String, DateTime>(
        json['updated_at'],
        const CustomDateTimeFormatter().fromJson,
      ),
    );

Map<String, dynamic> _$BaseOwnerModelToJson(BaseOwnerModel instance) =>
    <String, dynamic>{
      'created_at': _$JsonConverterToJson<String, DateTime>(
        instance.createdAt,
        const CustomDateTimeFormatter().toJson,
      ),
      'updated_at': _$JsonConverterToJson<String, DateTime>(
        instance.updatedAt,
        const CustomDateTimeFormatter().toJson,
      ),
      'owner_id': instance.ownerId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
