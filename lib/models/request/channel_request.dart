import 'validator.dart';

class ChannelRequest {
  final int? id;
  final String? channelName;

  ChannelRequest._(this.id, this.channelName);

  factory ChannelRequest.forCreate(Map<String, dynamic> json) {
    var channelName = getString(json, 'channel_name', min: 3, max: 10);
    return ChannelRequest._(null, channelName);
  }

  factory ChannelRequest.forUpdate(Map<String, dynamic> json) {
    var id = getUint(json, 'id');
    var channelName = getString(json, 'channel_name', min: 3, max: 10);
    return ChannelRequest._(id, channelName);
  }
}
