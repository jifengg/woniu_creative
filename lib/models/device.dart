// lib/models/device.dart
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'device.g.dart';

/// 设备实体类
@JsonSerializable()
class Device extends BaseOwnerModel {
  /// 设备唯一ID
  final int? id;

  /// 硬件唯一标识
  @JsonKey(name: 'device_id')
  final String deviceId;

  /// 设备名称
  @JsonKey(name: 'device_name')
  final String? deviceName;

  /// 所属的频道id
  @JsonKey(name: 'channel_id')
  final int? channelId;

  /// 设备附加信息
  @JsonKey(name: 'device_info')
  final Map<String, dynamic>? deviceInfo;

  /// 是否注册
  @JsonKey(name: 'is_registered')
  @BoolIntConverter()
  final bool isRegistered;

  Device({
    this.id,
    required this.deviceId,
    this.deviceName,
    this.channelId,
    this.deviceInfo,
    this.isRegistered = false,
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
