// lib/models/play_policy.dart
import 'package:json_annotation/json_annotation.dart';

part 'play_policy.g.dart';

/// 播放策略配置
@JsonSerializable()
class PlayPolicy {
  /// 循环播放次数（-1表示无限循环）
  final int loop;

  /// 切换动画类型（fade/slide等）
  final String transition;

  /// 默认音量（0.0-1.0）
  final double volume;

  PlayPolicy({
    required this.loop,
    required this.transition,
    required this.volume,
  });

  factory PlayPolicy.fromJson(Map<String, dynamic> json) =>
      _$PlayPolicyFromJson(json);
  Map<String, dynamic> toJson() => _$PlayPolicyToJson(this);
}