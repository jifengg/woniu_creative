import 'package:woniu_creative/api/mock.dart' as mock;
import 'package:woniu_creative/models/models.dart';

export 'register.dart';

/// 获取当前设备的频道信息
Future<Channel?> getMyChannelData() async {
  await Future.delayed(Duration(seconds: 2));
  var res = mock.getMyChannelData();
  return res.data;
}
