import 'dart:io';
import 'package:path/path.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/utils/http_downloader.dart';
import 'package:woniu_creative/utils/logger_utils.dart';

/// 用于管理文件的类。
/// 根据uniqueKey从本地文件从获取指定的文件。
/// 管理下载文件的队列 。
/// 根据策略，清理长期不使用的文件。
class FileManager {
  static String rootPath = '';
  static final String cacheDir = 'cache';
  static final String downloadTempDir = 'download_temp';

  static int maxDownloadQueueSize = 3;
  static int maxDownloadQueueTimeout = 1000 * 60 * 60 * 24;

  static final Map<String, Downloader> _downloadingQueue = {};
  static final List<MaterialInfo> _downloadWaitingQueue = [];

  /// 初始化
  static Future init({
    String? rootPath,
    int maxDownloadQueueSize = 3,
    int maxDownloadQueueTimeout = 1000 * 60 * 60 * 24,
  }) async {
    //配置存储文件的根目录
    FileManager.rootPath = rootPath ?? '';
    //配置下载队列的相关参数
    FileManager.maxDownloadQueueSize = maxDownloadQueueSize;
    FileManager.maxDownloadQueueTimeout = maxDownloadQueueTimeout;

    Directory(join(FileManager.rootPath, cacheDir)).createSync();
    Directory(join(FileManager.rootPath, downloadTempDir)).createSync();
  }

  /// 获取该材料对应的本地文件
  static Future<File?> getFile(MaterialInfo materialInfo) async {
    var filepath = join(rootPath, cacheDir, materialInfo.uniqueKey);
    var f = File(filepath);
    if (f.existsSync()) {
      return f;
    } else {
      return null;
    }
  }

  static Set<MaterialTypes> fileTypes = {
    MaterialTypes.image,
    MaterialTypes.video,
    MaterialTypes.audio,
  };
  static Future downloadFromChannel(Channel channel) async {
    if (channel.programs == null) {
      return;
    }
    for (var p in channel.programs!) {
      if (p.layers == null) {
        continue;
      }
      for (var l in p.layers!) {
        for (var lc in l.layoutConfigs) {
          if (lc.playList.items != null) {
            for (var i in lc.playList.items!) {
              if (i.material.type.isFileType) {
                downloadFile(i.material);
              }
            }
          }
        }
      }
    }
  }

  /// 下载一个素材。该任务将会添加到下载队列中
  static Future downloadFile(MaterialInfo materialInfo) async {
    if (_downloadingQueue.containsKey(materialInfo.uniqueKey)) {
      debug('该素材（${materialInfo.uniqueKey}）正在下载中，无需重复下载');
      return;
    }
    if (_downloadWaitingQueue.contains(materialInfo)) {
      debug('该素材（${materialInfo.uniqueKey}）已经在下载队列中，无需重复添加');
      return;
    }
    _downloadWaitingQueue.add(materialInfo);
    _checkDownloadQueue();
  }

  /// 检查下载队列，如果下载队列中有任务，则开始下载
  static void _checkDownloadQueue() async {
    //  如果下载队列中没有任务，则不添加新的下载任务
    if (_downloadWaitingQueue.isEmpty) {
      return;
    }
    // 如果下载队列中的任务数量大于等于最大下载队列大小，则不添加新的下载任务
    if (_downloadingQueue.length >= maxDownloadQueueSize) {
      return;
    }
    var materialInfo = _downloadWaitingQueue.removeAt(0);
    _downloadFile(materialInfo);
  }

  /// 下载文件
  static void _downloadFile(MaterialInfo materialInfo) async {
    var filepath = join(rootPath, cacheDir, materialInfo.uniqueKey);
    if (File(filepath).existsSync()) {
      debug('素材文件已存在，跳过。$filepath');
      _checkDownloadQueue();
      return;
    }
    //将下载任务加入下载队列
    var tempFilepath = join(
      rootPath,
      downloadTempDir,
      '${materialInfo.uniqueKey}.tmp',
    );
    info('开始下载文件，素材信息：$materialInfo，临时文件路径：$tempFilepath');
    var d = Downloader(
      url: materialInfo.url!,
      localPath: tempFilepath,
      onProgress: (received, total) {},
      onSuccess: (path, duration) {
        LoggerUtils.i('文件下载成功，耗时：${duration.inMilliseconds}ms，路径：$path');
        _removeDownloadTask(materialInfo);
        File(path).renameSync(filepath);
      },
      onFailure: (error) {
        LoggerUtils.e('文件下载失败，错误信息：$error');
        _removeDownloadTask(materialInfo);
      },
    )..start();
    // 将下载任务加入下载队列
    _downloadingQueue[materialInfo.uniqueKey] = d;
  }

  /// 移除下载任务
  static void _removeDownloadTask(MaterialInfo materialInfo) {
    _downloadingQueue.remove(materialInfo.uniqueKey);
    _checkDownloadQueue();
  }
}
