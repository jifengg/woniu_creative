import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'merchant.g.dart';

@JsonSerializable()
class Merchant extends BaseDbModel {
  final int? id;
  final String name;
  final String username;
  @JsonKey(name: 'last_login')
  @DateTimeConverter()
  final DateTime? lastLogin;

  @JsonKey(name: 'password_hash')
  @JsonKey(includeToJson: false)
  final String passwordHash;
  @JsonKey(includeToJson: false)
  final String salt;

  Merchant({
    this.id,
    required this.name,
    required this.username,
    this.passwordHash = '',
    this.salt = '',
    this.lastLogin,
    super.createdAt,
    super.updatedAt,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MerchantToJson(this);
}
