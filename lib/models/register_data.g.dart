// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterData _$RegisterDataFromJson(Map<String, dynamic> json) => RegisterData(
  isRegistered: json['isRegistered'] as bool,
  ownerId: (json['ownerId'] as num?)?.toInt(),
);

Map<String, dynamic> _$RegisterDataToJson(RegisterData instance) =>
    <String, dynamic>{
      'isRegistered': instance.isRegistered,
      'ownerId': instance.ownerId,
    };
