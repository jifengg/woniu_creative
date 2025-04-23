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

  static final nameMap = {
    text: '文本',
    image: '图片',
    video: '视频',
    audio: '音频',
    link: '链接',
  };

  String getName() {
    return nameMap[this] ?? name;
  }
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

/// 播放列表的播放模式
enum PlayMode {
  /// 顺序播放
  @JsonValue(1)
  order,

  /// 随机播放
  @JsonValue(2)
  random;

  static final nameMap = {order: '顺序', random: '随机'};

  String getName() {
    return nameMap[this] ?? name;
  }
}
