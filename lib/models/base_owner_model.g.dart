// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseOwnerModel _$BaseOwnerModelFromJson(Map<String, dynamic> json) =>
    BaseOwnerModel(
      ownerId: (json['owner_id'] as num?)?.toInt(),
      createdAt: const CustomDateTimeFormatter().fromJson(
        json['created_at'] as String?,
      ),
      updatedAt: const CustomDateTimeFormatter().fromJson(
        json['updated_at'] as String?,
      ),
    );

Map<String, dynamic> _$BaseOwnerModelToJson(BaseOwnerModel instance) =>
    <String, dynamic>{
      'created_at': const CustomDateTimeFormatter().toJson(instance.createdAt),
      'updated_at': const CustomDateTimeFormatter().toJson(instance.updatedAt),
      'owner_id': instance.ownerId,
    };
