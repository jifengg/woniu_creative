// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
  id: (json['id'] as num).toInt(),
  channelName: json['channel_name'] as String,
  device: Device.fromJson(json['device'] as Map<String, dynamic>),
  defaultPlayPolicy: PlayPolicy.fromJson(
    json['default_play_policy'] as Map<String, dynamic>,
  ),
  programs:
      (json['programs'] as List<dynamic>)
          .map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
  'id': instance.id,
  'channel_name': instance.channelName,
  'device': instance.device,
  'default_play_policy': instance.defaultPlayPolicy,
  'programs': instance.programs,
};
