import 'package:flutter/material.dart';
import 'package:woniu_creative/models/channel.dart';
import 'package:woniu_creative/models/enums.dart';
import 'package:woniu_creative/models/layer.dart';
import 'package:woniu_creative/models/layout_config.dart';
import 'package:woniu_creative/models/material_info.dart';
import 'package:woniu_creative/models/period.dart';
import 'package:woniu_creative/models/play_item.dart';
import 'package:woniu_creative/models/play_list.dart';
import 'package:woniu_creative/models/position.dart';
import 'package:woniu_creative/models/program.dart';
import 'package:woniu_creative/models/time_config.dart';

var channel1 = Channel(
  id: 1,
  channelName: "测试频道1",
  programs: [
    Program(
      id: 1,
      programName: "programName",
      priority: 999,
      timeConfig: TimeConfig(
        type: TimeConfigType.daily,
        start: DateTime(2000),
        end: DateTime(2099),
        periods: [Period(start: 0, end: 86400)],
      ),
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
                      version: 1,
                      url:
                          "https://img1.baidu.com/it/u=2786614520,3496145671&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800",
                    ),
                  ),
                  PlayItem(
                    material: MaterialInfo(
                      id: 4,
                      type: MaterialTypes.image,
                      version: 1,
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
                      version: 1,
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
                      version: 1,
                      content: "标题1",
                    ),
                  ),
                  PlayItem(
                    material: MaterialInfo(
                      id: 12,
                      version: 1,
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
                      id: 13,
                      type: MaterialTypes.video,
                      version: 1,
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
    ),
    Program(
      id: 21,
      programName: "programName",
      priority: 1999,
      timeConfig: CustomTimeConfig(
        start: DateTime(2000),
        end: DateTime(2099),
        periods: [Period(start: 0, end: 86400)],
        dateRanges: [
          DateTimeRange(
            start: DateTime.parse("2025-03-05 16:25"),
            end: DateTime.parse("2025-03-05 16:25:20"),
          ),
        ],
      ),
      layers: [
        Layer(
          id: 201,
          layerName: "layerName",
          layoutConfigs: [
            LayoutConfig(
              position: Position.fullscreen,
              playList: PlayList(
                items: [
                  PlayItem(
                    material: MaterialInfo(
                      id: 23,
                      type: MaterialTypes.image,
                      version: 1,
                      url:
                          "https://img0.baidu.com/it/u=3217812679,2585737758&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
                    ),
                  ),
                ],
              ),
            ),
            LayoutConfig(
              position: Position(x: 0.1, y: 0.1, w: 0.5, h: 0.1),
              playList: PlayList(
                items: [
                  PlayItem(
                    material: MaterialInfo(
                      id: 33,
                      type: MaterialTypes.text,
                      version: 1,
                      content: "现在是节目2",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

var channel2 = Channel(
  id: 2,
  channelName: 'channelName',
  programs: [
    Program(
      id: 22,
      programName: 'programName',
      timeConfig: TimeConfig.everyDay,
      layers: [
        Layer(
          id: 401,
          layerName: 'layerName',
          layoutConfigs: [
            LayoutConfig(
              position: Position.fullscreen,
              playList: PlayList(
                items: [
                  PlayItem(
                    material: MaterialInfo(
                      id: 4,
                      type: MaterialTypes.image,
                      version: 1,
                      url:
                          "https://i0.hdslb.com/bfs/archive/63d70f20eb05f89deb14d2be0599e9625c131380.jpg",
                    ),
                  ),
                ],
              ),
            ),
            LayoutConfig(
              position: Position.leftTop,
              playList: PlayList(
                items: [
                  PlayItem(
                    material: MaterialInfo(
                      id: 501,
                      type: MaterialTypes.text,
                      version: 1,
                      content: '这是从api获取的新节目',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
