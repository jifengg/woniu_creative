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

  /// 素材URL
  final String? url;

  /// 素材时长
  final int? duration;

  /// 文字内容
  final String? content;

  MaterialInfo({
    required this.id,
    required this.type,
    this.url,
    this.duration,
    this.content,
  });

  factory MaterialInfo.fromJson(Map<String, dynamic> json) =>
      _$MaterialInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialInfoToJson(this);
}
