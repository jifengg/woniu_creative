// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayItem _$PlayItemFromJson(Map<String, dynamic> json) => PlayItem(
  material: MaterialInfo.fromJson(json['material'] as Map<String, dynamic>),
  duration: (json['duration'] as num?)?.toInt(),
);

Map<String, dynamic> _$PlayItemToJson(PlayItem instance) => <String, dynamic>{
  'material': instance.material,
  'duration': instance.duration,
};
