// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutConfig _$LayoutConfigFromJson(Map<String, dynamic> json) => LayoutConfig(
  position: Position.fromJson(json['position'] as Map<String, dynamic>),
  playList: PlayList.fromJson(json['playList'] as Map<String, dynamic>),
  backgroundColor: (json['backgroundColor'] as num?)?.toInt(),
);

Map<String, dynamic> _$LayoutConfigToJson(LayoutConfig instance) =>
    <String, dynamic>{
      'position': instance.position,
      'playList': instance.playList,
      'backgroundColor': instance.backgroundColor,
    };
