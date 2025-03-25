// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseOwnerModel _$BaseOwnerModelFromJson(Map<String, dynamic> json) =>
    BaseOwnerModel(
      ownerId: (json['owner_id'] as num?)?.toInt(),
      createdAt: const NullableDateTimeConverter().fromJson(
        json['created_at'] as String?,
      ),
      updatedAt: const NullableDateTimeConverter().fromJson(
        json['updated_at'] as String?,
      ),
    );

Map<String, dynamic> _$BaseOwnerModelToJson(
  BaseOwnerModel instance,
) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
};
