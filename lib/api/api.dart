import 'package:woniu_creative/api/mock.dart';
import 'package:woniu_creative/models/api/channel_response.dart';
import 'package:woniu_creative/models/channel.dart';

/// 获取当前设备的频道信息
Future<Channel?> getMyChannelData() async {
  await Future.delayed(Duration(seconds: 2));
  var channel = channel1;
  if ((DateTime.now().second / 10).floor() % 2 == 0) {
    channel = channel2;
  }
  var res = ChannelResponse(code: 200, data: channel);
  return res.data;
}
