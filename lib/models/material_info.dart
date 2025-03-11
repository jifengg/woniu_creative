// lib/models/material.dart
import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

part 'material_info.g.dart';

/// 素材实体类
@JsonSerializable()
class MaterialInfo {
  /// 素材唯一ID
  final int id;

  /// 素材类型
  final MaterialTypes type;

  /// 素材版本
  final int version;

  /// 素材URL
  final String? url;

  final String? fileExtension;

  /// 素材时长
  final int? duration;

  /// 文字内容
  final String? content;

  MaterialInfo({
    required this.id,
    required this.type,
    required this.version,
    this.url,
    this.duration,
    this.content,
    this.fileExtension,
  });

  factory MaterialInfo.fromJson(Map<String, dynamic> json) =>
      _$MaterialInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialInfoToJson(this);

  /// 扩展字段，程序中使用
  /// 是否下载完成
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isDownloaded = false;

  /// 文件本地路径
  @JsonKey(includeFromJson: false, includeToJson: false)
  String localPath = '';

  /// 表示文件版本的唯一key，用于判断文件是否需要更新，由type、id、version组成。
  /// 也可以用于文件名
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get uniqueKey =>
      '${type.name}_${id}_$version.${fileExtension ?? 'bin'}';
}
