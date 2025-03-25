// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  username: json['username'] as String,
  passwordHash: json['password_hash'] as String? ?? '',
  salt: json['salt'] as String? ?? '',
  lastLogin: const CustomDateTimeFormatter().fromJson(
    json['last_login'] as String?,
  ),
  createdAt: const CustomDateTimeFormatter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const CustomDateTimeFormatter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
  'created_at': const CustomDateTimeFormatter().toJson(instance.createdAt),
  'updated_at': const CustomDateTimeFormatter().toJson(instance.updatedAt),
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'last_login': const CustomDateTimeFormatter().toJson(instance.lastLogin),
  'password_hash': instance.passwordHash,
};
