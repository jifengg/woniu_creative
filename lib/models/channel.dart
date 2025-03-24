// lib/models/channel.dart
import 'package:json_annotation/json_annotation.dart';
import 'program.dart';
import 'custom_formatter.dart';

part 'channel.g.dart';

/// 频道实体类
@JsonSerializable()
class Channel {
  /// 频道唯一ID
  final int? id;

  /// 频道名称
  @JsonKey(name: 'channel_name')
  final String channelName;

  /// 包含的节目列表
  final List<Program>? programs;

  /// 创建时间
  @JsonKey(name: 'created_at')
  @CustomDateTimeFormatter()
  final DateTime? createdAt;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  @CustomDateTimeFormatter()
  final DateTime? updatedAt;

  /// 所有者ID
  @JsonKey(name: 'owner_id')
  final int? ownerId;

  Channel({
    required this.id,
    required this.channelName,
    this.programs = const [],
    this.createdAt,
    this.updatedAt,
    this.ownerId,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}
