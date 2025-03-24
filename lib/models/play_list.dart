import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'play_list.g.dart';

/// 布局配置
@JsonSerializable()
class PlayList extends BaseOwnerModel {
  /// ID
  final int? id;

  /// 列表
  final List<PlayItem>? items;

  @JsonKey(name: 'play_mode')
  final int playMode;

  /// 默认的切换间隔时间，单位毫秒。
  @JsonKey(name: 'default_delay')
  final int defaultDelay;

  PlayList({
    this.id,
    this.items,
    this.playMode = 1,
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
