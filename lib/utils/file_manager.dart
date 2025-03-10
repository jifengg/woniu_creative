import 'dart:io';

import 'package:woniu_creative/models/material_info.dart';

/// 用于管理文件的类。
/// 根据uniqueKey从本地文件从获取指定的文件。
/// 管理下载文件的队列 。
/// 根据策略，清理长期不使用的文件。
class FileManager {
  /// 初始化
  static Future init({
    String? rootPath,
    int maxDownloadQueueSize = 10,
    int maxDownloadQueueTimeout = 60 * 60 * 24,
  }) async {
    //配置存储文件的根目录
    //配置下载队列的相关参数
  }

  /// 获取该材料对应的本地文件
  static Future<File?> getFile(MaterialInfo materialInfo) async {
    return null;
  }

  static Future downloadFile(MaterialInfo materialInfo) async {
    //将下载任务加入下载队列
  }
}
