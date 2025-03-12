import 'package:json_annotation/json_annotation.dart';

part 'register_data.g.dart';

@JsonSerializable()
class RegisterData {
  /// 是否注册成功
  bool isRegistered;

  /// 商户id
  int? ownerId;

  RegisterData({required this.isRegistered, this.ownerId});

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);
}
