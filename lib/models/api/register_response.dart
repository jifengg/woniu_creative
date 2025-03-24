import 'package:json_annotation/json_annotation.dart';
import '../api/base_response.dart';
import '../models.dart';

part 'register_response.g.dart';

/// 频道响应顶层对象
@JsonSerializable()
class RegisterResponse extends BaseResponse {
  /// 频道数据容器
  @override
  RegisterData? get data => super.data as RegisterData?;

  RegisterResponse({required super.code, super.message, RegisterData? super.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
