import 'package:json_annotation/json_annotation.dart';
import 'package:woniu_creative/models/play_item.dart';

part 'play_list.g.dart';

/// 布局配置
@JsonSerializable()
class PlayList {
  final List<PlayItem> items;

  final int playMode;

  /// 默认的切换间隔时间，单位毫秒。
  final int defaultDelay;

  PlayList({required this.items, this.playMode = 1, this.defaultDelay = 3000});

  factory PlayList.fromJson(Map<String, dynamic> json) =>
      _$PlayListFromJson(json);
  Map<String, dynamic> toJson() => _$PlayListToJson(this);
}
