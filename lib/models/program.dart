// lib/models/program.dart
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'program.g.dart';

/// 节目实体类
@JsonSerializable()
class Program extends BaseOwnerModel {
  /// 节目唯一ID
  final int? id;

  /// 节目名称
  @JsonKey(name: 'program_name')
  final String programName;

  /// 时间配置
  @JsonKey(name: 'time_config')
  final TimeConfig? timeConfig;

  /// 节目的优先级，数值越大表示优先级越高
  final int priority;

  /// 包含的展示层列表
  final List<Layer>? layers;

  Program({
    this.id,
    required this.programName,
    this.timeConfig,
    this.layers,
    this.priority = 1000,
    super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
