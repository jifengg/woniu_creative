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
    const CustomDateTimeFormatter().fromJson,
  ),
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<String, DateTime>(
    json['updated_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
);

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
  'created_at': _$JsonConverterToJson<String, DateTime>(
    instance.createdAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'updated_at': _$JsonConverterToJson<String, DateTime>(
    instance.updatedAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'last_login': _$JsonConverterToJson<String, DateTime>(
    instance.lastLogin,
    const CustomDateTimeFormatter().toJson,
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
