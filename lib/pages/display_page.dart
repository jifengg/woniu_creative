import 'dart:async';

import 'package:flutter/material.dart';
import 'package:woniu_creative/api/api.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/pages/play_list_page.dart';
import 'package:woniu_creative/utils/file_manager.dart';
import 'package:woniu_creative/widgets/current_time_widget.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  Channel? channel;

  int currentIndex = -1;

  Program? get program =>
      currentIndex == -1 ? null : channel?.programs[currentIndex];

  Timer? programTimer;

  Timer? apiTimer;

  Channel? newChannelData;

  Future? channelInitFuture;

  @override
  void initState() {
    super.initState();
    channelInitFuture = refreshChannelInfo();
    startProgramTimer();
    startApiTimer();
  }

  void startProgramTimer() {
    programTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 确定当前时间应该播放的节目
      var now = DateTime.now();
      Program? topP;
      int index = -1;
      if (newChannelData != null) {
        channel = newChannelData!;
        newChannelData = null;
        // 下载所有的素材
        FileManager.downloadFromChannel(channel!);
      }
      if (channel != null) {
        for (var i = 0; i < channel!.programs.length; i++) {
          var program = channel!.programs[i];
          if (program.timeConfig.isTimeMatch(now)) {
            if (topP == null || topP.priority < program.priority) {
              topP = program;
              index = i;
            }
          }
        }
      }
      if (mounted) {
        setState(() {
          if (topP != null) {
            currentIndex = index;
          } else {
            currentIndex = -1;
          }
        });
      }
    });
  }

  void startApiTimer() {
    apiTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      // 获取最新的频道信息
      await refreshChannelInfo();
    });
  }

  Future refreshChannelInfo() async {
    // 获取最新的频道信息
    var channelData = await getMyChannelData();
    if (channelData != null) {
      // 直接替换
      newChannelData = channelData;
    }
  }

  @override
  void dispose() {
    super.dispose();
    programTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: channelInitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return (program == null || program!.layers.isEmpty)
                ? getEmptyProgram()
                : Stack(
                  children: program!.layers.map((i) => buildLayer(i)).toList(),
                );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 20),
                  Text(
                    '正在加载频道信息，请稍候。',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  double width(double r) {
    return r * MediaQuery.of(context).size.width;
  }

  double height(double r) {
    return r * MediaQuery.of(context).size.height;
  }

  Widget getEmptyProgram() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "暂无节目",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: width(1 / 10)),
          ),
          SizedBox(height: 10),
          CurrentTimeWidget(
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: width(1 / 23)),
          ),
        ],
      ),
    );
  }

  Widget buildLayer(Layer layer) {
    var list = layer.layoutConfigs;

    return Stack(
      key: ValueKey(layer.id),
      children:
          list.map((item) {
            var p = item.position;
            var l = item.playList;
            var bgc =
                item.backgroundColor == null
                    ? null
                    : Color(item.backgroundColor!);
            return Positioned(
              left: width(p.x),
              top: height(p.y),
              width: width(p.w),
              height: height(p.h),
              child: Container(color: bgc, child: PlayListPage(playList: l)),
            );
          }).toList(),
    );
  }
}
