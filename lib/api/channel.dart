import 'package:woniu_creative/api/http_helper.dart';
import 'package:woniu_creative/api/mock.dart' as mock;
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/models/models.dart';

import '../models/api/channel_response.dart';

/// 获取当前设备的频道信息
Future<Channel?> getMyChannelDataMock() async {
  await Future.delayed(Duration(seconds: 2));
  var res = mock.getMyChannelData();
  return res.data;
}

/// 获取当前设备的频道信息
Future<Channel?> getMyChannelData() async {
  var res = await get<ChannelResponse>(
    'client/get_channel_by_device/$deviceId',
  );
  return res.data;
}
