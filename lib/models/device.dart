// lib/models/device.dart
import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

/// 设备实体类
@JsonSerializable()
class Device {
  /// 设备唯一ID
  final int id;

  /// 硬件唯一标识
  @JsonKey(name: 'hardware_id')
  final String hardwareId;

  /// 设备名称
  @JsonKey(name: 'device_name')
  final String deviceName;

  Device({
    required this.id,
    required this.hardwareId,
    required this.deviceName,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}