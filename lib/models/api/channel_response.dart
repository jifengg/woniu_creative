// lib/models/channel_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:woniu_creative/models/api/base_response.dart';
import 'package:woniu_creative/models/channel.dart';

part 'channel_response.g.dart';

/// 频道响应顶层对象
@JsonSerializable()
class ChannelResponse extends BaseResponse {
  /// 频道数据容器
  @override
  Channel? get data => super.data as Channel?;

  ChannelResponse({required super.code, super.message, Channel? super.data});

  factory ChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChannelResponseToJson(this);
}
