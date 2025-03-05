import 'package:json_annotation/json_annotation.dart';

enum MaterialTypes {
  @JsonValue(1)
  text,
  @JsonValue(2)
  image,
  @JsonValue(3)
  video,
  @JsonValue(4)
  audio,
  @JsonValue(5)
  link,
}
