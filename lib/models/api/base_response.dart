// lib/models/channel_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// 频道响应顶层对象
@JsonSerializable()
class BaseResponse {
  /// 响应状态码
  final int code;

  /// 响应消息
  final String? message;

  /// 频道数据容器
  final dynamic data;

  BaseResponse({required this.code, this.message, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
