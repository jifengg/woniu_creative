import 'validator.dart';

class DeviceRequest {
  final String? deviceId;
  final String? deviceName;
  final Map<String, dynamic>? deviceInfo;

  DeviceRequest._(this.deviceId, this.deviceName, this.deviceInfo);

  factory DeviceRequest.forClientRegister(Map<String, dynamic> json) {
    var deviceId = getString(json, 'device_id', min: 3, max: 40)!;
    var deviceName = getString(json, 'device_name', min: 3, max: 40)!;
    var deviceInfo = getMap(json, 'device_info')!;
    return DeviceRequest._(deviceId, deviceName, deviceInfo);
  }
  factory DeviceRequest.forAdminRegister(Map<String, dynamic> json) {
    var deviceId = getString(json, 'device_id', min: 3, max: 40)!;
    return DeviceRequest._(deviceId, null, null);
  }
}
