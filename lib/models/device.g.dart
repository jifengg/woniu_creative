// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: (json['id'] as num?)?.toInt(),
  deviceId: json['device_id'] as String,
  deviceName: json['device_name'] as String?,
  channelId: (json['channel_id'] as num?)?.toInt(),
  deviceInfo: json['device_info'] as Map<String, dynamic>?,
  isRegistered:
      json['is_registered'] == null
          ? false
          : const BoolIntConverter().fromJson(
            (json['is_registered'] as num).toInt(),
          ),
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: const NullableDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const NullableDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'device_id': instance.deviceId,
  'device_name': instance.deviceName,
  'channel_id': instance.channelId,
  'device_info': instance.deviceInfo,
  'is_registered': const BoolIntConverter().toJson(instance.isRegistered),
};
