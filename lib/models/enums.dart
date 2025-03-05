import 'package:json_annotation/json_annotation.dart';

/// 显示素材类型
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

enum TimeConfigType {
  /// 每天
  @JsonValue(1)
  daily,

  /// 每周
  @JsonValue(2)
  weekly,

  /// 每月
  @JsonValue(3)
  monthly,

  /// 每年
  @JsonValue(4)
  yearly,

  /// 自定义
  @JsonValue(9)
  custom,
}
