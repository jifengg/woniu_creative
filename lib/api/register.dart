import 'package:woniu_creative/api/http_helper.dart';
import 'package:woniu_creative/models/api/register_response.dart';

import '../models/models.dart';
import 'mock.dart' as mock;

/// 生成设备id
/// 用设备id请求频道数据
///   返回未注册
///     显示注册页面，循环调用注册信息查询接口，直到返回已注册
///   返回频道信息，正常显示。
///
/// 问题列表：
/// 设备id相同？
///   客户端注销重新生成设备id
/// 客户端卸载后设备id丢失？
///   只能重新注册。管理端可以把新设备加入原先的设备列表中，无需重新配置频道信息
/// 设备id暴露？
///   可以通过接口查询该设备的信息，但是不影响管理端和其它设备。
///   影响：
///     建立实时通讯的时候，会把同id的设备踢下线；
///     设备的在线信息等会不准确；
///     该设备id上报的信息变得不可信；
///
/// 解决方案：
/// 注册的时候，后端返回一个api-token，客户端每次请求都带上这个token，后端通过设备id+token来识别设备。
/// token永远不过期，客户端可以用旧token请求新token，token可以随时刷新。
/// 客户端将token保存在本地。
/// 增加token会增加接口的复杂性，也不能完全避免token泄露的问题。

Future<RegisterData> registerMock(String deviceId) async {
  await Future.delayed(Duration(seconds: 2));
  var res = mock.register(deviceId);
  if (res.data == null) {
    throw Exception(res.message);
  }
  return res.data!;
}

Future<RegisterResponse> register(
  String deviceId,
  String deviceName,
  Map<String, dynamic> deviceInfo,
) async {
  var data = Device(
    deviceId: deviceId,
    deviceName: deviceName,
    deviceInfo: deviceInfo,
  );
  var res = await post<RegisterResponse>('client/register', data: data);
  return res;
}
