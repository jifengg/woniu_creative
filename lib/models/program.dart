// lib/models/program.dart
import 'package:json_annotation/json_annotation.dart';
import 'time_config.dart';
import 'layer.dart';

part 'program.g.dart';

/// 节目实体类
@JsonSerializable()
class Program {
  /// 节目唯一ID
  final int id;

  /// 节目名称
  @JsonKey(name: 'program_name')
  final String programName;

  /// 时间配置
  @JsonKey(name: 'time_config')
  final TimeConfig timeConfig;

  /// 包含的展示层列表
  final List<Layer> layers;

  Program({
    required this.id,
    required this.programName,
    required this.timeConfig,
    required this.layers,
  });

  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}