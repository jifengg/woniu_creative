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
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<String, DateTime>(
    json['updated_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'created_at': _$JsonConverterToJson<String, DateTime>(
    instance.createdAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'updated_at': _$JsonConverterToJson<String, DateTime>(
    instance.updatedAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'device_id': instance.deviceId,
  'device_name': instance.deviceName,
  'channel_id': instance.channelId,
  'device_info': instance.deviceInfo,
  'is_registered': const BoolIntConverter().toJson(instance.isRegistered),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
