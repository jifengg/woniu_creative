import 'package:json_annotation/json_annotation.dart';
import 'custom_formatter.dart';

part 'base_db_model.g.dart';

/// 数据库基础类，包含每个表都有的字段
@JsonSerializable()
class BaseDbModel {

  /// 创建时间
  @JsonKey(name: 'created_at')
  @NullableDateTimeConverter()
  final DateTime? createdAt;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  @NullableDateTimeConverter()
  final DateTime? updatedAt;

  BaseDbModel({
    this.createdAt,
    this.updatedAt,
  });

  factory BaseDbModel.fromJson(Map<String, dynamic> json) =>
      _$BaseDbModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseDbModelToJson(this);
}
