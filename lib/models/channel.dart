// lib/models/channel.dart
import 'package:json_annotation/json_annotation.dart';
import 'program.dart';

part 'channel.g.dart';

/// 频道实体类
@JsonSerializable()
class Channel {
  /// 频道唯一ID
  final int id;

  /// 频道名称
  @JsonKey(name: 'channel_name')
  final String channelName;

  /// 包含的节目列表
  final List<Program> programs;

  Channel({
    required this.id,
    required this.channelName,
    required this.programs,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}