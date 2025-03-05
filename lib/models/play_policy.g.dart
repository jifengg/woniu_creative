// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayPolicy _$PlayPolicyFromJson(Map<String, dynamic> json) => PlayPolicy(
  loop: (json['loop'] as num).toInt(),
  transition: json['transition'] as String,
  volume: (json['volume'] as num).toDouble(),
);

Map<String, dynamic> _$PlayPolicyToJson(PlayPolicy instance) =>
    <String, dynamic>{
      'loop': instance.loop,
      'transition': instance.transition,
      'volume': instance.volume,
    };
