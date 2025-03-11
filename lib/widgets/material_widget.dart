import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:video_player/video_player.dart';
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/models/enums.dart';
import 'package:woniu_creative/models/material_info.dart';
import 'package:woniu_creative/utils/file_manager.dart';
import 'package:woniu_creative/utils/logger_utils.dart';

class DemoWidget {
  static BuildContext get context => navigatorKey.currentContext!;
  static Widget get text {
    return Center(
      child: Text(
        "Hello，蜗牛创意！",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  static Widget get webview {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri.uri(
          Uri.parse(
            "https://i.tianqi.com/?c=code&a=getcode&id=82&site=16&icon=3&py=wuxi1",
          ),
        ),
      ),
    );
  }

  static Widget get image {
    return Image.network(
      // "https://i0.hdslb.com/bfs/archive/63d70f20eb05f89deb14d2be0599e9625c131380.jpg",
      "https://img1.baidu.com/it/u=2786614520,3496145671&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800",
      fit: BoxFit.fill,
    );
  }

  static VideoPlayerController? _videoPlayerController;
  static Widget get video {
    if (_videoPlayerController == null) {
      var controller = VideoPlayerController.file(
        File("C:/Users/xuxiaodong/Pictures/ffmpeg/素材/big_buck_bunny_10s.avi"),
      );
      controller.setVolume(30);
      controller.setLooping(false);
      controller.initialize().then((_) {
        controller.play();
      });
      _videoPlayerController = controller;
    }
    return GestureDetector(
      onDoubleTap: () {
        _videoPlayerController!.value.isPlaying
            ? _videoPlayerController!.pause()
            : _videoPlayerController!.play();
      },
      child: VideoPlayer(_videoPlayerController!),
    );
  }
}

class MaterialWidget extends StatefulWidget {
  const MaterialWidget({super.key, required this.material});
  final MaterialInfo material;
  @override
  State<MaterialWidget> createState() => _MaterialWidgetState();
}

class _MaterialWidgetState extends State<MaterialWidget> {
  MaterialInfo get material => widget.material;

  Future<File>? getLocalFileFuture;

  @override
  void initState() {
    super.initState();
    info('MaterialWidget 初始化 - ${material.uniqueKey}');
  }

  @override
  Widget build(BuildContext context) {
    return getWidgetOfMaterial();
  }

  Widget getWidgetOfMaterial() {
    if (material.type.isFileType && getLocalFileFuture == null) {
      getLocalFileFuture = getLocalFile();
    }
    switch (material.type) {
      case MaterialTypes.text:
        return buildText();
      case MaterialTypes.link:
        return buildWebview();
      case MaterialTypes.image:
      case MaterialTypes.video:
      case MaterialTypes.audio:
        return buildLoading();
      // ignore: unreachable_switch_default
      default:
        return Container();
    }
  }

  Future<File> getLocalFile() async {
    while (mounted) {
      var f = await FileManager.getFile(material);
      // 如果本地文件不存在，则等待。
      if (f == null) {
        await Future.delayed(const Duration(seconds: 1));
      } else {
        return f;
      }
    }
    return File('');
  }

  Widget buildText() {
    return Center(
      child: Text(
        material.content ?? "",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Widget buildWebview() {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri.uri(Uri.parse(material.url ?? "")),
      ),
    );
  }

  Widget buildLoading() {
    return FutureBuilder(
      future: getLocalFileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data!;
          switch (material.type) {
            case MaterialTypes.image:
              return buildImage(data);
            case MaterialTypes.video:
              return buildVideo();
            default:
              return Center(child: Text('暂不支持该类型：${material.type.name}'));
          }
        } else {
          return Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }

  Widget buildImage(File file) {
    return Image.file(file, fit: BoxFit.fill);
  }

  VideoPlayerController? _videoPlayerController;
  Widget buildVideo() {
    if (_videoPlayerController == null) {
      var controller = VideoPlayerController.file(File(material.url ?? ""));
      controller.setVolume(30);
      controller.setLooping(false);
      controller.initialize().then((_) {
        controller.play();
      });
      _videoPlayerController = controller;
    }
    return GestureDetector(
      onDoubleTap: () {
        _videoPlayerController!.value.isPlaying
            ? _videoPlayerController!.pause()
            : _videoPlayerController!.play();
      },
      child: VideoPlayer(_videoPlayerController!),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
