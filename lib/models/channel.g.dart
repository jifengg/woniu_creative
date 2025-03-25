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
  createdAt: const CustomDateTimeFormatter().fromJson(
    json['created_at'] as String?,
  ),
  updatedAt: const CustomDateTimeFormatter().fromJson(
    json['updated_at'] as String?,
  ),
);

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
  'created_at': const CustomDateTimeFormatter().toJson(instance.createdAt),
  'updated_at': const CustomDateTimeFormatter().toJson(instance.updatedAt),
  'owner_id': instance.ownerId,
  'id': instance.id,
  'channel_name': instance.channelName,
  'programs': instance.programs,
};
