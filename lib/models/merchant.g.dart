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
  lastLogin: _$JsonConverterFromJson<String, DateTime>(
    json['last_login'],
    const DateTimeConverter().fromJson,
  ),
  createdAt: const NullableDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const NullableDateTimeConverter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
  'created_at': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const NullableDateTimeConverter().toJson(instance.updatedAt),
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'last_login': _$JsonConverterToJson<String, DateTime>(
    instance.lastLogin,
    const DateTimeConverter().toJson,
  ),
  'password_hash': instance.passwordHash,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
