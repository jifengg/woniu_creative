// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
  id: (json['id'] as num?)?.toInt(),
  channelName: json['channel_name'] as String,
  programs:
      (json['programs'] as List<dynamic>?)
          ?.map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<String, DateTime>(
    json['updated_at'],
    const CustomDateTimeFormatter().fromJson,
  ),
);

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
  'created_at': _$JsonConverterToJson<String, DateTime>(
    instance.createdAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'updated_at': _$JsonConverterToJson<String, DateTime>(
    instance.updatedAt,
    const CustomDateTimeFormatter().toJson,
  ),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'channel_name': instance.channelName,
  'programs': instance.programs,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
