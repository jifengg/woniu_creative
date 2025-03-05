// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  w: (json['w'] as num).toDouble(),
  h: (json['h'] as num).toDouble(),
);

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'w': instance.w,
  'h': instance.h,
};
