import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  int? port;
  MysqlConfig mysql;

  AppConfig({
    this.port,
    required this.mysql,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
  Map toJson() => _$AppConfigToJson(this);
}

@JsonSerializable()
class MysqlConfig {
  final String host;
  final int port;
  final String userName;
  final String password;
  final int maxConnections;
  final String? databaseName;
  final bool secure;
  final String collation;
  final int timeoutMs;

  MysqlConfig({
    required this.host,
    required this.port,
    required this.userName,
    required this.password,
    this.maxConnections = 10,
    this.databaseName,
    this.secure = true,
    this.collation = 'utf8mb4_general_ci',
    this.timeoutMs = 10000,
  });

  factory MysqlConfig.fromJson(Map<String, dynamic> json) =>
      _$MysqlConfigFromJson(json);
  Map toJson() => _$MysqlConfigToJson(this);
}
