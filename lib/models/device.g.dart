// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: (json['id'] as num).toInt(),
  hardwareId: json['hardware_id'] as String,
  deviceName: json['device_name'] as String,
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'id': instance.id,
  'hardware_id': instance.hardwareId,
  'device_name': instance.deviceName,
};
