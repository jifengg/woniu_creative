// lib/models/channel_data.dart
import 'package:json_annotation/json_annotation.dart';
import 'channel.dart';

part 'channel_data.g.dart';

/// 频道数据容器
@JsonSerializable()
class ChannelData {
  /// 频道实体对象
  final Channel channel;

  ChannelData({required this.channel});

  factory ChannelData.fromJson(Map<String, dynamic> json) =>
      _$ChannelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelDataToJson(this);
}
