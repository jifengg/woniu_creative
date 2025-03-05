import 'package:flutter/material.dart';
import 'package:woniu_creative/models/enums.dart';
import 'package:woniu_creative/models/layer.dart';
import 'package:woniu_creative/models/layout_config.dart';
import 'package:woniu_creative/models/material_info.dart';
import 'package:woniu_creative/models/play_item.dart';
import 'package:woniu_creative/models/play_list.dart';
import 'package:woniu_creative/models/position.dart';
import 'package:woniu_creative/models/program.dart';
import 'package:woniu_creative/models/time_config.dart';
import 'package:woniu_creative/pages/play_list_page.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  Program program = Program(
    id: 1,
    programName: "programName",
    timeConfig: TimeConfig(type: "type", schedule: []),
    layers: [
      Layer(
        id: 1,
        layerName: "bg",
        layoutConfigs: [
          LayoutConfig(
            position: Position(x: 0, y: 0, w: 1, h: 1),
            playList: PlayList(
              items: [
                PlayItem(
                  material: MaterialInfo(
                    id: 3,
                    type: MaterialTypes.image,
                    url:
                        "https://img1.baidu.com/it/u=2786614520,3496145671&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800",
                  ),
                ),
                PlayItem(
                  material: MaterialInfo(
                    id: 4,
                    type: MaterialTypes.image,
                    url:
                        "https://i0.hdslb.com/bfs/archive/63d70f20eb05f89deb14d2be0599e9625c131380.jpg",
                  ),
                  duration: 10000,
                ),
              ],
            ),
          ),
        ],
      ),
      Layer(
        id: 2,
        layerName: "xx1",
        layoutConfigs: [
          LayoutConfig(
            position: Position(x: 0.02, y: 0.02, w: 0.32, h: 0.75),
            playList: PlayList(
              items: [
                PlayItem(
                  material: MaterialInfo(
                    id: 1,
                    type: MaterialTypes.link,
                    url:
                        "https://i.tianqi.com/?c=code&a=getcode&id=82&site=16&icon=3&py=wuxi1",
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white.toARGB32(),
          ),
          LayoutConfig(
            position: Position(x: 0.35, y: 0.02, w: 0.32, h: 0.15),
            playList: PlayList(
              items: [
                PlayItem(
                  material: MaterialInfo(
                    id: 2,
                    type: MaterialTypes.text,
                    content: "标题1",
                  ),
                ),
                PlayItem(
                  material: MaterialInfo(
                    id: 2,
                    type: MaterialTypes.text,
                    content: "这是另一个标题",
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.lightBlueAccent.toARGB32(),
          ),
          LayoutConfig(
            position: Position(x: 0.35, y: 0.50, w: 0.35, h: 0.25),
            playList: PlayList(
              items: [
                PlayItem(
                  material: MaterialInfo(
                    id: 3,
                    type: MaterialTypes.video,
                    url:
                        "C:/Users/xuxiaodong/Pictures/ffmpeg/素材/big_buck_bunny_10s.avi",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: program.layers.map((i) => layer1(i)).toList()),
    );
  }

  double width(double r) {
    return r * MediaQuery.of(context).size.width;
  }

  double height(double r) {
    return r * MediaQuery.of(context).size.height;
  }

  Widget layer1(Layer layer) {
    var list = layer.layoutConfigs;

    return Stack(
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
