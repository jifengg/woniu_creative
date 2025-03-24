// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  port: (json['port'] as num?)?.toInt(),
  mysql: MysqlConfig.fromJson(json['mysql'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'port': instance.port,
  'mysql': instance.mysql,
};

MysqlConfig _$MysqlConfigFromJson(Map<String, dynamic> json) => MysqlConfig(
  host: json['host'] as String,
  port: (json['port'] as num).toInt(),
  userName: json['userName'] as String,
  password: json['password'] as String,
  maxConnections: (json['maxConnections'] as num?)?.toInt() ?? 10,
  databaseName: json['databaseName'] as String?,
  secure: json['secure'] as bool? ?? true,
  collation: json['collation'] as String? ?? 'utf8mb4_general_ci',
  timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 10000,
);

Map<String, dynamic> _$MysqlConfigToJson(MysqlConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'userName': instance.userName,
      'password': instance.password,
      'maxConnections': instance.maxConnections,
      'databaseName': instance.databaseName,
      'secure': instance.secure,
      'collation': instance.collation,
      'timeoutMs': instance.timeoutMs,
    };
