import 'package:flutter/material.dart' hide DateTimeRange;
import 'package:woniu_creative/models/api/register_response.dart';
import '../models/api/channel_response.dart';
import '../models/models.dart';

var materialsImage = [
  MaterialInfo(
    id: 3,
    type: MaterialTypes.image,
    version: 1,
    fileExtension: 'jpg',
    url: "https://img1.baidu.com/it/u=2786614520,3496145671&fm=253",
  ),
  MaterialInfo(
    id: 4,
    type: MaterialTypes.image,
    version: 1,
    fileExtension: 'jpg',
    url:
        "https://i0.hdslb.com/bfs/archive/63d70f20eb05f89deb14d2be0599e9625c131380.jpg",
  ),
];

var materialsVideo = [
  MaterialInfo(
    id: 13,
    type: MaterialTypes.video,
    version: 1,
    fileExtension: 'avi',
    url: "C:/Users/xuxiaodong/Pictures/ffmpeg/素材/big_buck_bunny_10s.avi",
  ),
];

var materialsLink = [
  MaterialInfo(
    id: 5001,
    type: MaterialTypes.link,
    version: 1,
    // 天气
    url: "https://i.tianqi.com/?c=code&a=getcode&id=82&site=16&icon=3&py=wuxi1",
  ),
  MaterialInfo(
    id: 5002,
    type: MaterialTypes.link,
    version: 1,
    // 翻页时钟
    url: "https://flipflow.neverup.cn/clock.html",
  ),
];

var playLists = [
  PlayList(
    id: 1,
    name: '喜庆图片序列',
    items: [
      PlayItem(material: materialsImage[0]),
      PlayItem(material: materialsImage[1], duration: 10000),
    ],
  ),
  PlayList(id: 2, name: '外网链接', items: [PlayItem(material: materialsLink[1])]),
  PlayList(
    id: 3,
    name: '文字内容',
    items: [
      PlayItem(
        material: MaterialInfo(
          id: 1002,
          type: MaterialTypes.text,
          version: 1,
          content: "标题1",
        ),
      ),
      PlayItem(
        material: MaterialInfo(
          id: 1012,
          version: 1,
          type: MaterialTypes.text,
          content: "这是另一个标题",
        ),
      ),
    ],
  ),
  PlayList(id: 4, name: '一张图片', items: [PlayItem(material: materialsImage[1])]),
  PlayList(id: 5, name: '一个视频', items: [PlayItem(material: materialsVideo[0])]),
  PlayList(
    id: 6,
    name: '文字内容2',
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
];

var channel1 = Channel(
  id: 1,
  channelName: "测试频道1",
  programs: [
    Program(
      id: 1,
      programName: "programName",
      priority: 999,
      timeConfig: TimeConfig.everyDay,
      layers: [
        Layer(
          id: 1,
          layerName: "bg",
          layoutConfigs: [
            LayoutConfig(
              position: Position(x: 0, y: 0, w: 1, h: 1),
              playList: playLists[0],
            ),
          ],
        ),
        Layer(
          id: 2,
          layerName: "xx1",
          layoutConfigs: [
            LayoutConfig(
              position: Position(x: 0.02, y: 0.02, w: 0.32, h: 0.75),
              playList: playLists[1],
              backgroundColor: Colors.white.toARGB32(),
            ),
            LayoutConfig(
              position: Position(x: 0.35, y: 0.02, w: 0.32, h: 0.15),
              playList: playLists[2],
              backgroundColor: Colors.lightBlueAccent.toARGB32(),
            ),
            LayoutConfig(
              position: Position(x: 0.35, y: 0.50, w: 0.35, h: 0.25),
              playList: playLists[4],
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
            LayoutConfig(position: Position.fullscreen, playList: playLists[3]),
            LayoutConfig(
              position: Position(x: 0.1, y: 0.1, w: 0.5, h: 0.1),
              playList: playLists[5],
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
                      fileExtension: 'jpg',
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

ChannelResponse getMyChannelData() {
  var channel = channel1;
  if ((DateTime.now().second / 10).floor() % 2 == 0) {
    channel = channel2;
  }
  var res = ChannelResponse(code: 200, data: channel);
  return res;
}

RegisterResponse register(String deviceId) {
  //
  var data1 = RegisterData(isRegistered: true, ownerId: 9527);
  var data2 = RegisterData(isRegistered: false, ownerId: 9527);
  var data = 2 == 2 ? data1 : data2;
  var res = RegisterResponse(code: 200, data: data);
  return res;
}
