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
  link;

  static Set<MaterialTypes> fileTypes = {image, video, audio};

  /// 是否是文件素材
  bool get isFileType => fileTypes.contains(this);
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
  custom;

  static final nameMap = {
    daily: '每天',
    weekly: '每周',
    monthly: '每月',
    yearly: '每年',
    custom: '自定义',
  };

  String getName() {
    return nameMap[this] ?? name;
  }
}
