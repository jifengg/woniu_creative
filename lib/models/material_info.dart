// lib/models/material.dart
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'material_info.g.dart';

/// 素材实体类
@JsonSerializable()
class MaterialInfo extends BaseOwnerModel {
  /// 素材唯一ID
  final int? id;

  /// 素材类型
  final MaterialTypes type;

  /// 素材版本
  final int? version;

  /// 素材URL
  final String? url;

  @JsonKey(name: 'file_extension')
  final String? fileExtension;

  /// 素材时长
  final int? duration;

  /// 文字内容
  final String? content;

  final String? name;

  final String? filename;

  MaterialInfo({
    this.id,
    required this.type,
    this.version,
    this.url,
    this.duration,
    this.content,
    this.fileExtension,
    this.name,
    this.filename,
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory MaterialInfo.fromJson(Map<String, dynamic> json) =>
      _$MaterialInfoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MaterialInfoToJson(this);

  /// 扩展字段，程序中使用
  // /// 是否下载完成
  // @JsonKey(includeFromJson: false, includeToJson: false)
  // bool isDownloaded = false;

  // /// 文件本地路径
  // @JsonKey(includeFromJson: false, includeToJson: false)
  // String localPath = '';

  /// 表示文件版本的唯一key，用于判断文件是否需要更新，由type、id、version组成。
  /// 也可以用于文件名
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get uniqueKey =>
      '${type.name}_${id}_$version.${fileExtension ?? 'bin'}';
}
