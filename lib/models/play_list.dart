import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'play_list.g.dart';

/// 布局配置
@JsonSerializable()
class PlayList extends BaseOwnerModel {
  /// ID
  final int? id;

  String name;

  /// 列表
  final List<PlayItem>? items;

  @JsonKey(name: 'play_mode')
  final PlayMode playMode;

  /// 默认的切换间隔时间，单位毫秒。
  @JsonKey(name: 'default_delay')
  final int defaultDelay;

  PlayList({
    this.id,
    this.name = 'playlist',
    this.items,
    this.playMode = PlayMode.order,
    this.defaultDelay = 3000,
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory PlayList.fromJson(Map<String, dynamic> json) =>
      _$PlayListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PlayListToJson(this);
}
