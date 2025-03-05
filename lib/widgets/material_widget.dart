import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:video_player/video_player.dart';
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/models/enums.dart';
import 'package:woniu_creative/models/material_info.dart';

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
  @override
  Widget build(BuildContext context) {
    return getWidgetOfMaterial();
  }

  Widget getWidgetOfMaterial() {
    switch (material.type) {
      case MaterialTypes.text:
        return buildText();
      case MaterialTypes.image:
        return buildImage();
      case MaterialTypes.link:
        return buildWebview();
      case MaterialTypes.video:
        return buildVideo();
      default:
        return Container();
    }
  }

  Widget buildText() {
    return Center(
      child: Text(
        material.content ?? "",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Widget buildImage() {
    return Image.network(material.url ?? "", fit: BoxFit.fill);
  }

  Widget buildWebview() {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri.uri(Uri.parse(material.url ?? "")),
      ),
    );
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
