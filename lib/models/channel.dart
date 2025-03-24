// lib/models/channel.dart
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'channel.g.dart';

/// 频道实体类
@JsonSerializable()
class Channel extends BaseOwnerModel {
  /// 频道唯一ID
  final int? id;

  /// 频道名称
  @JsonKey(name: 'channel_name')
  final String channelName;

  /// 包含的节目列表
  final List<Program>? programs;

  Channel({
    this.id,
    required this.channelName,
    this.programs = const [],
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}
