// lib/models/channel_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:woniu_creative/models/channel.dart';

part 'channel_response.g.dart';

/// 频道响应顶层对象
@JsonSerializable()
class ChannelResponse {
  /// 响应状态码
  final int code;

  /// 响应消息
  final String message;

  /// 频道数据容器
  final Channel data;

  ChannelResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelResponseToJson(this);
}
